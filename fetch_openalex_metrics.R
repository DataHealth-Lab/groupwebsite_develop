# fetch_openalex_metrics.R
# Reads DOIs from content/publication/*/index.md,
# queries OpenAlex via openalexR, and writes
# assets/openalex_metrics.json for the Hugo site to use.
library(openalexR)
library(jsonlite)
library(purrr)
library(dplyr)

# Helper (base R version of rlang's %||%)
`%||%` <- function(a, b) {
    if (is.null(a)) return(b)
    if (length(a) == 1 && is.na(a)) return(b)
    a
}

# ── 1. Collect DOIs from publication frontmatter ──────────────────────────────

index_files <- list.files("content/publication_all", pattern = "\\.md$", 
                          full.names = TRUE)
normalize_doi <- function(doi) {
    doi <- trimws(gsub("\r", "", doi))          # strip CRLF artefacts
    doi <- gsub('^["\']|["\']$', "", doi)       # strip surrounding quotes
    doi <- sub("^doi:\\s*", "", doi, ignore.case = TRUE)  # strip "doi:" prefix
    doi <- sub("^https?://(dx\\.)?doi\\.org/", "", doi, ignore.case = TRUE)
    tolower(trimws(doi))
}

extract_doi <- function(path) {
    lines <- readLines(path, warn = FALSE)
    doi_line <- grep("^doi_value:", lines, value = TRUE)[1]
    if (is.na(doi_line)) return(NA_character_)
    raw <- sub("^doi_value:\\s*", "", doi_line)
    normalize_doi(raw)
}

dois <- sapply(index_files, extract_doi, USE.NAMES = FALSE)
dois <- dois[!is.na(dois) & nchar(dois) > 0]
cat(sprintf("Found %d publications, %d with DOIs\n", length(index_files), length(dois)))

# ── 2. Query OpenAlex ─────────────────────────────────────────────────────────
# Split into batches of max 100
doi_batches <- split(
    dois,
    ceiling(seq_along(dois) / 100)
)

get_oa_batch <- function(doi_batch) {
    
    q <- oa_query(
        entity = "works",
        doi = doi_batch,
        options = oa_options(
            select = c(
                "id",
                "doi",
                "title",
                "publication_year",
                "cited_by_count",
                "counts_by_year",
                "fwci",
                "open_access",
                "citation_normalized_percentile",
                "countries_distinct_count"
            )
        )
    )
    
    x <- oa_request(q)
    
    map_dfr(x, \(w) {
        
        p  <- w$citation_normalized_percentile %||% list()
        oa <- w$open_access %||% list()
        
        tibble(
            id = w$id,
            doi = w$doi,
            title = w$title,
            publication_year = w$publication_year,
            cited_by_count = w$cited_by_count,
            
            # keep yearly citation data as a list-column
            counts_by_year = list(w$counts_by_year),
            
            fwci = w$fwci,
            
            is_oa = oa$is_oa %||% NA,
            oa_status = oa$oa_status %||% NA_character_,
            oa_url = oa$oa_url %||% NA_character_,
            
            citation_percentile = p$value %||% NA_real_,
            top_1_percent = p$is_in_top_1_percent %||% NA,
            top_10_percent = p$is_in_top_10_percent %||% NA,
            
            countries_distinct_count =
                w$countries_distinct_count %||% NA_integer_
        )
    })
}

db_oa <- map_dfr(
    doi_batches,
    get_oa_batch,
    .progress = TRUE
)

cat(sprintf("OpenAlex returned %d records\n", nrow(db_oa)))

# ── 3. Tidy and write JSON ────────────────────────────────────────────────────

# Normalise DOI to match what's in the frontmatter
db_oa$doi_norm <- tolower(sub("https?://(dx\\.)?doi\\.org/", "", db_oa$doi))

# Sparkline: last 8 years, oldest→newest, zero-filled
compact_yearly <- function(cby, n = 8) {
    
    if (is.null(cby) || length(cby) == 0) {
        return(list())
    }
    
    # OpenAlex returns counts_by_year as a list of lists
    cby <- dplyr::bind_rows(cby)
    
    if (nrow(cby) == 0) {
        return(list())
    }
    
    # Current/latest year available in OpenAlex
    end_yr   <- max(cby$year, na.rm = TRUE)
    start_yr <- end_yr - n + 1
    years    <- seq(start_yr, end_yr)
    
    # Add zero for years absent from OpenAlex
    counts <- vapply(
        years,
        function(y) {
            v <- cby$cited_by_count[cby$year == y]
            if (length(v) == 0) 0L else as.integer(v[[1]])
        },
        integer(1)
    )
    
    Map(
        function(y, count) {
            list(
                year = as.integer(y),
                count = as.integer(count)
            )
        },
        years,
        counts
    )
}

metrics_list <- lapply(seq_len(nrow(db_oa)), function(i) {
    w <- db_oa[i, ]
    list(
        doi                 = w$doi_norm,
        cited_by_count      = w$cited_by_count,
        fwci                = w$fwci,
        citation_percentile = w$citation_percentile,
        is_top_1_percent    = w$top_1_percent,
        is_top_10_percent   = w$top_10_percent,
        is_oa               = w$is_oa,
        oa_status           = w$oa_status %||% NA_character_,
        countries_distinct_count = w$countries_distinct_count,
        counts_by_year      = compact_yearly(w$counts_by_year[[1]])
    )
})

names(metrics_list) <- sapply(metrics_list, `[[`, "doi")

out <- list(
    generated_at = format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"),
    source       = "openalex",
    count        = length(metrics_list),
    metrics      = metrics_list
)

# dir.create("assets", showWarnings = FALSE)
write_json(out, "assets/openalex_metrics.json", pretty = TRUE, auto_unbox = TRUE)
cat(sprintf("Wrote assets/openalex_metrics.json (%d entries)\n", length(metrics_list)))



# ── 4. Patch frontmatter of each publication file ─────────────────────────────

patch_frontmatter <- function(path, m) {
    lines <- readLines(path, warn = FALSE)
    marks <- which(trimws(lines) == "---")
    if (length(marks) < 2) return(invisible(FALSE))
    
    fm_range <- seq(marks[1] + 1, marks[2] - 1)
    
    # Update a field that already exists in frontmatter
    replace_field <- function(lines, field, value) {
        pat <- paste0("^", field, ":")
        idx <- grep(pat, lines[fm_range])
        if (length(idx) == 0) return(lines)
        abs_idx <- fm_range[idx[1]]
        lines[abs_idx] <- paste0(field, ": ", value)
        lines
    }
    
    # Add a field just before the closing --- if it doesn't exist
    add_or_replace_field <- function(lines, field, value) {
        pat <- paste0("^", field, ":")
        idx <- grep(pat, lines[fm_range])
        if (length(idx) > 0) {
            abs_idx <- fm_range[idx[1]]
            lines[abs_idx] <- paste0(field, ": ", value)
        } else {
            # Insert before closing ---
            close_mark <- marks[2]
            lines <- c(lines[1:(close_mark - 1)],
                       paste0(field, ": ", value),
                       lines[close_mark:length(lines)])
        }
        lines
    }
    
    lines <- replace_field(lines, "citations", as.integer(m$cited_by_count))
    lines <- replace_field(lines, "fwci",      round(m$fwci, 2))
    lines <- replace_field(lines, "oa_status", paste0('"', m$oa_status, '"'))
    lines <- add_or_replace_field(lines, "is_top_1_percent",  tolower(as.character(isTRUE(m$is_top_1_percent))))
    lines <- add_or_replace_field(lines, "is_top_10_percent", tolower(as.character(isTRUE(m$is_top_10_percent))))    
    writeLines(lines, path, useBytes = TRUE)
    invisible(TRUE)
}

patched <- 0
for (path in index_files) {
    doi <- extract_doi(path)
    if (!is.na(doi) && doi %in% names(metrics_list)) {
        m <- metrics_list[[doi]]
        if (patch_frontmatter(path, m)) patched <- patched + 1
    }
}
cat(sprintf("Patched %d/%d publication files\n", patched, length(index_files)))


# ── 5. Stamp the publications index with the update date ──────────────────────

# index_file <- file.path("content/publication_all", "_index.md")
# if (file.exists(index_file)) {
#     idx <- readLines(index_file, warn = FALSE)
#     date_line <- paste0('<small style="color: #888;">Updated: ',
#                         format(Sys.Date(), "%d %B %Y"), "</small>")
#     idx <- idx[!grepl("^<small.*Updated:", idx)]   # remove old line if present
#     writeLines(c(idx, date_line), index_file)
#     cat(sprintf("Stamped index: %s\n", date_line))
# } else {
#     cat("No _index.md found at content/publication_all/_index.md — skipping stamp\n")
# }

# ── 6. Write summary stats ────────────────────────────────────────────────────

ml <- metrics_list
n_oa      <- sum(sapply(ml, function(x) isTRUE(x$is_oa)))
n_top1    <- sum(sapply(ml, function(x) isTRUE(x$is_top_1_percent)))
n_top10   <- sum(sapply(ml, function(x) isTRUE(x$is_top_10_percent)))
fwci_vals <- sapply(ml, function(x) if (is.null(x$fwci) || is.na(x$fwci)) NA_real_ else x$fwci)
med_fwci  <- round(median(fwci_vals, na.rm = TRUE), 1)
p75_fwci <- round(as.numeric(quantile(fwci_vals, 0.75, na.rm = TRUE)),1)
count_fwci_1 <- sum(fwci_vals>1, na.rm = T)

summary_out <- list(
    generated_at = format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"),
    n_total      = length(dois),
    n_oa         = n_oa,
    n_top1       = n_top1,
    n_top10      = n_top10,
    median_fwci  = med_fwci,
    p75_fwci     = p75_fwci,
    count_fwci_1 = count_fwci_1
)
write_json(summary_out, "assets/openalex_summary.json", pretty = TRUE, auto_unbox = TRUE)
cat(sprintf("Summary: %d OA | Top 1%%: %d | Top 10%%: %d | Median FWCI: %.1f\n",
            n_oa, n_top1, n_top10, med_fwci))

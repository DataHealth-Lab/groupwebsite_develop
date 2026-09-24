# fetch_openalex_metrics.R
# Reads DOIs from content/publication_all/*.md,
# queries OpenAlex via openalexR, and writes
# assets/openalex_metrics.json for the Hugo site to use.

library(openalexR)
library(jsonlite)

# ── 1. Collect DOIs from publication frontmatter ──────────────────────────────

index_files <- list.files("content/publication_all", pattern = "\\.md$", full.names = TRUE)

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
  # grab everything after "doi_value:" and normalize
  raw <- sub("^doi_value:\\s*", "", doi_line)
  normalize_doi(raw)
}

dois <- sapply(index_files, extract_doi, USE.NAMES = FALSE)
dois <- dois[!is.na(dois) & nchar(dois) > 0]
cat(sprintf("Found %d publications, %d with DOIs\n", length(index_files), length(dois)))

# ── 2. Query OpenAlex ─────────────────────────────────────────────────────────

works <- oa_fetch(
  entity  = "works",
  doi     = dois,
  select  = c(
    "doi",
    "cited_by_count",
    "fwci",
    "citation_normalized_percentile",
    "open_access",
    "counts_by_year"
  ),
  verbose = TRUE
)

cat(sprintf("OpenAlex returned %d records\n", nrow(works)))

# ── 3. Tidy and write JSON ────────────────────────────────────────────────────

# Normalise DOI to match what's in the frontmatter
works$doi_norm <- tolower(sub("https?://(dx\\.)?doi\\.org/", "", works$doi))

# Flatten citation_normalized_percentile (it's a list-column)
get_pct <- function(x) if (is.null(x) || !is.data.frame(x)) NA_real_ else x$value[1] * 100
get_top1 <- function(x) if (is.null(x) || !is.data.frame(x)) FALSE else isTRUE(x$is_in_top_1_percent[1])
get_top10 <- function(x) if (is.null(x) || !is.data.frame(x)) FALSE else isTRUE(x$is_in_top_10_percent[1])

works$citation_percentile <- sapply(works$citation_normalized_percentile, get_pct)
works$is_top_1_percent    <- sapply(works$citation_normalized_percentile, get_top1)
works$is_top_10_percent   <- sapply(works$citation_normalized_percentile, get_top10)

# Sparkline: last 8 years, oldest→newest, zero-filled
compact_yearly <- function(cby, n = 8) {
  if (is.null(cby) || !is.data.frame(cby) || nrow(cby) == 0) return(list())
  end_yr   <- max(cby$year)
  start_yr <- end_yr - n + 1
  years    <- seq(start_yr, end_yr)
  counts   <- sapply(years, function(y) {
    v <- cby$cited_by_count[cby$year == y]
    if (length(v) == 0) 0L else as.integer(v[1])
  })
  mapply(function(y, c) list(year = y, count = c),
         years, counts, SIMPLIFY = FALSE, USE.NAMES = FALSE)
}

metrics_list <- lapply(seq_len(nrow(works)), function(i) {
  w <- works[i, ]
  list(
    doi                 = w$doi_norm,
    cited_by_count      = w$cited_by_count,
    fwci                = w$fwci,
    citation_percentile = w$citation_percentile,
    is_top_1_percent    = w$is_top_1_percent,
    is_top_10_percent   = w$is_top_10_percent,
    is_oa               = isTRUE(w$open_access[[1]]$is_oa),
    oa_status           = w$open_access[[1]]$oa_status %||% NA_character_,
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

dir.create("assets", showWarnings = FALSE)
write_json(out, "assets/openalex_metrics.json", pretty = TRUE, auto_unbox = TRUE)
cat(sprintf("Wrote assets/openalex_metrics.json (%d entries)\n", length(metrics_list)))

# Helper (base R version of rlang's %||%)
`%||%` <- function(a, b) if (!is.null(a) && !is.na(a)) a else b

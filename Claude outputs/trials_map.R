# World map of DataHealthLab trial & implementation countries
# install.packages(c("ggplot2", "rnaturalearth", "rnaturalearthdata", "svglite"))

library(ggplot2)
library(rnaturalearth)
library(rnaturalearthdata)
library(svglite)

# ── Countries ──────────────────────────────────────────────────────────────────
countries <- c(
  # LMICs
  "Afghanistan", "Ethiopia", "Ghana", "India", "Kenya",
  "Malaysia", "Nepal", "Pakistan", "South Africa", "Uganda", "Vietnam",
  # HICs
  "Brazil", "Spain", "Italy", "Croatia", "Germany", "United States of America"
)

# ── World polygons (medium resolution) ─────────────────────────────────────────
world <- ne_countries(scale = "medium", returnclass = "sf")
world$highlight <- world$name_long %in% countries

# ── Colours ────────────────────────────────────────────────────────────────────
col_highlight <- "#2a7a2a"   # site accent green
col_land      <- "#e8e8e8"   # neutral land
col_border    <- "#ffffff"   # country borders
col_ocean     <- "#f4f4f4"   # background (matches site bg)

# ── Plot ───────────────────────────────────────────────────────────────────────
p <- ggplot(world) +
  geom_sf(aes(fill = highlight),
          colour = col_border, linewidth = 0.15) +
  scale_fill_manual(
    values = c("FALSE" = col_land, "TRUE" = col_highlight),
    guide  = "none"
  ) +
  coord_sf(crs = "+proj=robin", expand = FALSE) +   # Robinson projection
  theme_void() +
  theme(
    plot.background  = element_rect(fill = col_ocean, colour = NA),
    panel.background = element_rect(fill = col_ocean, colour = NA),
    plot.margin      = margin(6, 6, 6, 6)
  )

# ── Export ─────────────────────────────────────────────────────────────────────
# SVG (for embedding in the Hugo page)
svglite("trials_map.svg", width = 9, height = 4.5)
print(p)
dev.off()

# PNG (optional — for a quick preview)
ggsave("trials_map.png", p, width = 9, height = 4.5, dpi = 150, bg = col_ocean)

message("Done — trials_map.svg and trials_map.png written to working directory.")

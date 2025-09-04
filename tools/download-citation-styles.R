#!/usr/bin/env Rscript

# Script to download common citation styles for templates
# Run this to update citation style files

library(here)

# Common citation styles from Zotero Style Repository
# Browse more styles at: https://www.zotero.org/styles
citation_styles <- list(
  "apa.csl" = "https://www.zotero.org/styles/apa",
  "ieee.csl" = "https://www.zotero.org/styles/ieee", 
  "chicago-author-date.csl" = "https://www.zotero.org/styles/chicago-author-date",
  "nature.csl" = "https://www.zotero.org/styles/nature",
  "science.csl" = "https://www.zotero.org/styles/science",
  "plos-one.csl" = "https://www.zotero.org/styles/plos",
  "mla.csl" = "https://www.zotero.org/styles/modern-language-association"
)

# Templates that need citation styles
templates_with_citations <- c("simple-paper", "empirical-study", "grant-application", "literature-review")

cat("Downloading citation styles...\n")

for (template in templates_with_citations) {
  template_dir <- here("templates", template)
  assets_dir <- file.path(template_dir, "assets")
  
  # Create assets directory if it doesn't exist
  if (!dir.exists(assets_dir)) {
    dir.create(assets_dir, recursive = TRUE)
    cat("Created assets directory for", template, "\n")
  }
  
  # Download citation styles
  for (style_name in names(citation_styles)) {
    style_url <- citation_styles[[style_name]]
    output_file <- file.path(assets_dir, style_name)
    
    tryCatch({
      download.file(style_url, output_file, quiet = TRUE, mode = "wb")
      cat("✓ Downloaded", style_name, "for", template, "\n")
    }, error = function(e) {
      cat("✗ Failed to download", style_name, "for", template, ":", e$message, "\n")
      cat("  You can manually download from:", style_url, "\n")
    })
  }
}

cat("\nCitation style download complete!\n")
cat("\nUsage in _quarto.yml:\n")
cat("bibliography: references.bib\n")
cat("csl: assets/apa.csl  # or other style\n")
cat("\nBrowse thousands more styles at: https://www.zotero.org/styles\n")
cat("To add a new style:\n")
cat("1. Find the style at zotero.org/styles\n")
cat("2. Download the .csl file to your assets/ directory\n")
cat("3. Reference it in your _quarto.yml file\n")
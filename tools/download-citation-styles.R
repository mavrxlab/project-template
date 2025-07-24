#!/usr/bin/env Rscript

# Script to download common citation styles for templates
# Run this to update citation style files

library(here)

# Common citation styles and their URLs
citation_styles <- list(
  "apa.csl" = "https://raw.githubusercontent.com/citation-style-language/styles/master/apa.csl",
  "ieee.csl" = "https://raw.githubusercontent.com/citation-style-language/styles/master/ieee.csl", 
  "chicago-author-date.csl" = "https://raw.githubusercontent.com/citation-style-language/styles/master/chicago-author-date.csl",
  "nature.csl" = "https://raw.githubusercontent.com/citation-style-language/styles/master/nature.csl",
  "science.csl" = "https://raw.githubusercontent.com/citation-style-language/styles/master/science.csl",
  "plos-one.csl" = "https://raw.githubusercontent.com/citation-style-language/styles/master/plos.csl",
  "mla.csl" = "https://raw.githubusercontent.com/citation-style-language/styles/master/modern-language-association.csl"
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
      download.file(style_url, output_file, quiet = TRUE)
      cat("✓ Downloaded", style_name, "for", template, "\n")
    }, error = function(e) {
      cat("✗ Failed to download", style_name, "for", template, ":", e$message, "\n")
    })
  }
}

cat("\nCitation style download complete!\n")
cat("Usage in _quarto.yml:\n")
cat("bibliography: references.bib\n")
cat("csl: assets/apa.csl  # or other style\n")
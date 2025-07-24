#!/usr/bin/env Rscript

# Pre-commit hook to validate Quarto syntax
# Usage: Called automatically by pre-commit on .qmd files

args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0) {
  cat("No files to check\n")
  quit(status = 0)
}

library(yaml, quietly = TRUE)

exit_code <- 0
issues_found <- FALSE

for (file in args) {
  cat("Checking Quarto syntax:", file, "\n")
  
  tryCatch({
    # Read file content
    content <- readLines(file, warn = FALSE)
    
    if (length(content) == 0) {
      cat("WARNING:", file, "is empty\n")
      next
    }
    
    # Check for YAML header
    if (content[1] != "---") {
      cat("ERROR:", file, "missing YAML header (should start with ---)\n")
      exit_code <- 1
      issues_found <- TRUE
      next
    }
    
    # Find YAML header boundaries
    yaml_end <- which(content == "---")[2]
    if (is.na(yaml_end) || yaml_end <= 1) {
      cat("ERROR:", file, "malformed YAML header (missing closing ---)\n")
      exit_code <- 1
      issues_found <- TRUE
      next
    }
    
    # Extract and validate YAML
    yaml_content <- content[2:(yaml_end - 1)]
    yaml_text <- paste(yaml_content, collapse = "\n")
    
    tryCatch({
      yaml_data <- yaml.load(yaml_text)
      
      # Check for required fields
      if (is.null(yaml_data$title)) {
        cat("WARNING:", file, "missing 'title' in YAML header\n")
      }
      
      if (is.null(yaml_data$format)) {
        cat("WARNING:", file, "missing 'format' in YAML header\n")
      }
      
    }, error = function(e) {
      cat("ERROR:", file, "invalid YAML syntax:", e$message, "\n")
      exit_code <- 1
      issues_found <- TRUE
    })
    
    # Check for Quarto best practices
    
    # Look for blank lines between different element types
    for (i in 2:(length(content) - 1)) {
      line <- content[i]
      next_line <- content[i + 1]
      
      # Check for blank line before headers (after YAML)
      if (i > yaml_end && grepl("^#{1,6}\\s", next_line) && !grepl("^\\s*$", line) && !grepl("^#{1,6}\\s", line)) {
        cat("WARNING:", file, "line", i+1, "- consider adding blank line before header\n")
      }
      
      # Check for blank line before lists
      if (grepl("^\\s*[-*+]\\s", next_line) && !grepl("^\\s*$", line) && !grepl("^\\s*[-*+]\\s", line)) {
        cat("WARNING:", file, "line", i+1, "- consider adding blank line before list\n")
      }
    }
    
    cat("✓", file, "syntax OK\n")
    
  }, error = function(e) {
    cat("ERROR:", file, "failed to process:", e$message, "\n")
    exit_code <- 1
    issues_found <- TRUE
  })
}

if (issues_found) {
  cat("\nQuarto syntax validation found issues. Please fix before committing.\n")
} else {
  cat("\nAll Quarto files passed syntax validation.\n")
}

quit(status = exit_code)
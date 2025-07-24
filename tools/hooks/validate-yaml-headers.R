#!/usr/bin/env Rscript

# Pre-commit hook to validate YAML headers in Quarto files
# Usage: Called automatically by pre-commit on .qmd files

args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0) {
  cat("No Quarto files to check\n")
  quit(status = 0)
}

library(yaml, quietly = TRUE)

exit_code <- 0
issues_found <- FALSE

for (file in args) {
  cat("Checking YAML header:", file, "\n")
  
  tryCatch({
    # Read file content
    content <- readLines(file, warn = FALSE)
    
    if (length(content) == 0) {
      cat("WARNING:", file, "is empty\n")
      next
    }
    
    # Check for YAML header
    if (content[1] != "---") {
      cat("ERROR:", file, "missing YAML header\n")
      exit_code <- 1
      issues_found <- TRUE
      next
    }
    
    # Find YAML header boundaries
    yaml_end <- which(content == "---")
    if (length(yaml_end) < 2) {
      cat("ERROR:", file, "malformed YAML header\n")
      exit_code <- 1
      issues_found <- TRUE
      next
    }
    
    yaml_end <- yaml_end[2]
    
    # Extract YAML content
    yaml_content <- content[2:(yaml_end - 1)]
    yaml_text <- paste(yaml_content, collapse = "\n")
    
    # Parse YAML
    tryCatch({
      yaml_data <- yaml.load(yaml_text)
      
      # Template-specific validation
      template_type <- basename(dirname(file))
      
      # Common field validation
      if (is.null(yaml_data$title) || yaml_data$title == "") {
        cat("ERROR:", file, "missing or empty 'title' field\n")
        exit_code <- 1
        issues_found <- TRUE
      }
      
      if (is.null(yaml_data$format)) {
        cat("WARNING:", file, "missing 'format' field\n")
      }
      
      # Check for placeholder content
      placeholder_patterns <- c(
        "Your.*Title.*Here",
        "Your.*Name",
        "you@university\\.edu",
        "Your.*Institution",
        "0000-0000-0000-0000"
      )
      
      yaml_string <- toString(yaml_data)
      for (pattern in placeholder_patterns) {
        if (grepl(pattern, yaml_string, ignore.case = TRUE)) {
          cat("WARNING:", file, "contains placeholder content that should be customized\n")
          break
        }
      }
      
      # Template-specific validation
      if (template_type == "empirical-study") {
        # Check for research-specific fields
        if (is.null(yaml_data$abstract)) {
          cat("WARNING:", file, "empirical study should include abstract\n")
        }
        
        if (is.null(yaml_data$keywords)) {
          cat("WARNING:", file, "empirical study should include keywords\n")
        }
        
        if (is.null(yaml_data$bibliography)) {
          cat("WARNING:", file, "empirical study should include bibliography reference\n")
        }
      }
      
      if (template_type == "conference-presentation") {
        # Check presentation-specific format
        if (!is.null(yaml_data$format) && is.null(yaml_data$format$revealjs)) {
          cat("WARNING:", file, "presentation should use revealjs format\n")
        }
      }
      
      # Check format configuration
      if (!is.null(yaml_data$format)) {
        if (is.list(yaml_data$format)) {
          # Check for common format issues
          if (!is.null(yaml_data$format$pdf) && is.null(yaml_data$format$pdf$documentclass)) {
            cat("INFO:", file, "PDF format could specify documentclass\n")
          }
          
          if (!is.null(yaml_data$format$html) && is.null(yaml_data$format$html$toc)) {
            cat("INFO:", file, "HTML format could specify table of contents\n")
          }
        }
      }
      
      cat("✓", file, "YAML header valid\n")
      
    }, error = function(e) {
      cat("ERROR:", file, "invalid YAML syntax:", e$message, "\n")
      exit_code <- 1
      issues_found <- TRUE
    })
    
  }, error = function(e) {
    cat("ERROR:", file, "failed to process:", e$message, "\n")
    exit_code <- 1
    issues_found <- TRUE
  })
}

if (issues_found) {
  cat("\nYAML header validation found issues. Please fix before committing.\n")
} else {
  cat("\nAll YAML headers passed validation.\n")
}

quit(status = exit_code)
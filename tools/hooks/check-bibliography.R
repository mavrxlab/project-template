#!/usr/bin/env Rscript

# Pre-commit hook to validate bibliography files
# Usage: Called automatically by pre-commit on .bib files

args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0) {
  cat("No bibliography files to check\n")
  quit(status = 0)
}

exit_code <- 0
issues_found <- FALSE

for (file in args) {
  cat("Checking bibliography file:", file, "\n")
  
  tryCatch({
    # Read file content
    content <- readLines(file, warn = FALSE)
    
    if (length(content) == 0) {
      cat("WARNING:", file, "is empty\n")
      next
    }
    
    # Basic BibTeX validation
    entry_count <- 0
    in_entry <- FALSE
    brace_count <- 0
    current_entry_type <- NULL
    
    for (i in seq_along(content)) {
      line <- trimws(content[i])
      
      # Skip empty lines and comments
      if (nchar(line) == 0 || startsWith(line, "%")) {
        next
      }
      
      # Check for entry start
      if (grepl("^@\\w+\\s*\\{", line)) {
        if (in_entry) {
          cat("ERROR:", file, "line", i, "- new entry started before previous ended\n")
          exit_code <- 1
          issues_found <- TRUE
        }
        
        in_entry <- TRUE
        entry_count <- entry_count + 1
        
        # Extract entry type
        current_entry_type <- gsub("^@(\\w+)\\s*\\{.*", "\\1", line, ignore.case = TRUE)
        
        # Count opening braces
        brace_count <- brace_count + length(gregexpr("\\{", line)[[1]]) - length(gregexpr("\\}", line)[[1]])
      } else if (in_entry) {
        # Count braces in entry lines
        brace_count <- brace_count + length(gregexpr("\\{", line)[[1]]) - length(gregexpr("\\}", line)[[1]])
        
        # Check if entry ended
        if (brace_count <= 0) {
          in_entry <- FALSE
          brace_count <- 0
          current_entry_type <- NULL
        }
      } else {
        # Line outside of entry that's not a comment
        if (!startsWith(line, "%")) {
          cat("WARNING:", file, "line", i, "- content outside of bibliography entry\n")
        }
      }
    }
    
    # Check if last entry was properly closed
    if (in_entry) {
      cat("ERROR:", file, "- unclosed bibliography entry\n")
      exit_code <- 1
      issues_found <- TRUE
    }
    
    # Check entry count
    if (entry_count == 0) {
      cat("WARNING:", file, "contains no bibliography entries\n")
    } else {
      cat("✓", file, "contains", entry_count, "bibliography entries\n")
    }
    
    # Look for common issues
    content_text <- paste(content, collapse = "\n")
    
    # Check for missing required fields (basic check)
    entries <- regmatches(content_text, gregexpr("@\\w+\\{[^@]*", content_text))[[1]]
    
    for (entry in entries) {
      # Check articles have required fields
      if (grepl("@article", entry, ignore.case = TRUE)) {
        required_fields <- c("title", "author", "journal", "year")
        for (field in required_fields) {
          if (!grepl(paste0(field, "\\s*="), entry, ignore.case = TRUE)) {
            cat("WARNING:", file, "- article entry may be missing required field:", field, "\n")
          }
        }
      }
      
      # Check books have required fields
      if (grepl("@book", entry, ignore.case = TRUE)) {
        required_fields <- c("title", "author", "publisher", "year")
        for (field in required_fields) {
          if (!grepl(paste0(field, "\\s*="), entry, ignore.case = TRUE)) {
            cat("WARNING:", file, "- book entry may be missing required field:", field, "\n")
          }
        }
      }
    }
    
  }, error = function(e) {
    cat("ERROR:", file, "failed to process:", e$message, "\n")
    exit_code <- 1
    issues_found <- TRUE
  })
}

if (issues_found) {
  cat("\nBibliography validation found issues. Please fix before committing.\n")
} else {
  cat("\nAll bibliography files passed validation.\n")
}

quit(status = exit_code)
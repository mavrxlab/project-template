#!/usr/bin/env Rscript

# Pre-commit hook to validate template structure
# Usage: Called automatically by pre-commit when templates/ directory changes

library(fs, quietly = TRUE)

exit_code <- 0
issues_found <- FALSE

cat("Validating template structure...\n")

# Expected templates
expected_templates <- c("simple-paper", "empirical-study", "grant-application", 
                       "literature-review", "conference-presentation")

# Check each template directory
for (template in expected_templates) {
  template_dir <- file.path("templates", template)
  
  if (!dir.exists(template_dir)) {
    cat("ERROR: Template directory missing:", template_dir, "\n")
    exit_code <- 1
    issues_found <- TRUE
    next
  }
  
  # Required files for all templates
  required_files <- c("README.md", "_quarto.yml", "references.bib")
  
  for (file in required_files) {
    file_path <- file.path(template_dir, file)
    if (!file.exists(file_path)) {
      cat("ERROR:", template, "missing required file:", file, "\n")
      exit_code <- 1
      issues_found <- TRUE
    }
  }
  
  # Template-specific main files
  main_files <- list(
    "simple-paper" = "paper.qmd",
    "empirical-study" = "manuscript.qmd", 
    "grant-application" = "proposal.qmd",
    "literature-review" = "review.qmd",
    "conference-presentation" = "slides.qmd"
  )
  
  main_file <- main_files[[template]]
  if (!is.null(main_file)) {
    main_path <- file.path(template_dir, main_file)
    if (!file.exists(main_path)) {
      cat("ERROR:", template, "missing main file:", main_file, "\n")
      exit_code <- 1
      issues_found <- TRUE
    }
  }
  
  # Check README.md mentions template name
  readme_path <- file.path(template_dir, "README.md")
  if (file.exists(readme_path)) {
    readme_content <- readLines(readme_path, warn = FALSE)
    readme_text <- paste(readme_content, collapse = " ")
    
    # Convert template name to different cases for checking
    template_variants <- c(
      template,
      gsub("-", " ", template),
      gsub("-", "_", template),
      tools::toTitleCase(gsub("-", " ", template))
    )
    
    if (!any(sapply(template_variants, function(variant) grepl(variant, readme_text, ignore.case = TRUE)))) {
      cat("WARNING:", template, "README.md may not mention template name\n")
    }
  }
  
  cat("✓", template, "structure OK\n")
}

# Check that project initializer knows about all templates
initializer_path <- "tools/project-initializer.R"
if (file.exists(initializer_path)) {
  initializer_content <- readLines(initializer_path, warn = FALSE)
  initializer_text <- paste(initializer_content, collapse = "\n")
  
  for (template in expected_templates) {
    if (!grepl(paste0('"', template, '"'), initializer_text)) {
      cat("WARNING: Template", template, "may not be defined in project-initializer.R\n")
    }
  }
}

if (issues_found) {
  cat("\nTemplate structure validation found issues. Please fix before committing.\n")
} else {
  cat("\nAll templates passed structure validation.\n")
}

quit(status = exit_code)
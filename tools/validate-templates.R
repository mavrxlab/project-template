# Template Validation Script
# Tests that all templates can be created and rendered successfully

library(fs)
library(here)
library(cli)

validate_all_templates <- function(test_dir = tempdir()) {
  cli_h1("Template Validation Suite")
  
  # Source the project initializer
  source(here("tools", "project-initializer.R"))
  
  # Available templates to test
  templates <- c("simple-paper", "empirical-study", "grant-application", 
                "literature-review", "conference-presentation")
  
  test_results <- list()
  
  for (template in templates) {
    cli_h2(paste("Testing template:", template))
    
    result <- test_template(template, test_dir)
    test_results[[template]] <- result
    
    if (result$success) {
      cli_alert_success(paste("✓", template, "template validation passed"))
    } else {
      cli_alert_danger(paste("✗", template, "template validation failed"))
      cli_text(paste("Error:", result$error))
    }
  }
  
  # Summary report
  cli_rule()
  cli_h2("Validation Summary")
  
  successful <- sum(sapply(test_results, function(x) x$success))
  total <- length(test_results)
  
  if (successful == total) {
    cli_alert_success(paste("All", total, "templates validated successfully!"))
  } else {
    cli_alert_warning(paste(successful, "of", total, "templates passed validation"))
  }
  
  return(test_results)
}

test_template <- function(template_name, base_dir) {
  test_name <- paste0("test-", template_name, "-", format(Sys.time(), "%Y%m%d%H%M%S"))
  test_path <- file.path(base_dir, test_name)
  
  result <- list(
    template = template_name,
    test_path = test_path,
    success = FALSE,
    error = NULL,
    warnings = c(),
    tests_passed = c()
  )
  
  tryCatch({
    # Test 1: Template creation
    cli_alert_info("  Creating project...")
    project_path <- initialize_project(test_name, template_name, test_path)
    result$tests_passed <- c(result$tests_passed, "project_creation")
    
    # Test 2: Directory structure validation
    cli_alert_info("  Validating directory structure...")
    validate_directory_structure(project_path, template_name)
    result$tests_passed <- c(result$tests_passed, "directory_structure")
    
    # Test 3: Required files exist
    cli_alert_info("  Checking required files...")
    validate_required_files(project_path, template_name)
    result$tests_passed <- c(result$tests_passed, "required_files")
    
    # Test 4: Quarto rendering (if applicable)
    cli_alert_info("  Testing Quarto rendering...")
    validate_quarto_rendering(project_path, template_name)
    result$tests_passed <- c(result$tests_passed, "quarto_rendering")
    
    # Test 5: R project file validation
    cli_alert_info("  Validating R project file...")
    validate_rproject_file(project_path, test_name)
    result$tests_passed <- c(result$tests_passed, "rproject_file")
    
    result$success <- TRUE
    
  }, error = function(e) {
    result$success <- FALSE
    result$error <- as.character(e)
  }, finally = {
    # Clean up test directory
    if (dir.exists(test_path)) {
      unlink(test_path, recursive = TRUE)
    }
  })
  
  return(result)
}

validate_directory_structure <- function(project_path, template_name) {
  # Common directories that should exist for all templates
  common_dirs <- c("figures", "tables", "archive", "admin", "docs")
  
  # Template-specific directories
  if (template_name == "empirical-study") {
    expected_dirs <- c(common_dirs, "data/raw", "data/processed", "instruments", "outputs/reports")
  } else if (template_name == "literature-review") {
    # For now, just check common directories since we create specific ones in the initializer
    expected_dirs <- common_dirs
  } else if (template_name == "conference-presentation") {
    # For now, just check common directories since we create specific ones in the initializer
    expected_dirs <- common_dirs
  } else {
    expected_dirs <- common_dirs
  }
  
  for (dir in expected_dirs) {
    dir_path <- file.path(project_path, dir)
    if (!dir.exists(dir_path)) {
      stop(paste("Expected directory not found:", dir))
    }
  }
}

validate_required_files <- function(project_path, template_name) {
  # Common files
  common_files <- c("README.md", ".gitignore")
  
  # Template-specific required files
  if (template_name == "simple-paper") {
    required_files <- c(common_files, "paper.qmd", "references.bib", "_quarto.yml", "R/setup.R")
  } else if (template_name == "empirical-study") {
    required_files <- c(common_files, "manuscript.qmd", "references.bib", "_quarto.yml")
  } else if (template_name == "grant-application") {
    required_files <- c(common_files, "proposal.qmd", "references.bib", "_quarto.yml")
  } else if (template_name == "literature-review") {
    required_files <- c(common_files, "review.qmd", "references.bib", "_quarto.yml")
  } else if (template_name == "conference-presentation") {
    required_files <- c(common_files, "slides.qmd", "_quarto.yml")
  } else {
    required_files <- common_files
  }
  
  for (file in required_files) {
    file_path <- file.path(project_path, file)
    if (!file.exists(file_path)) {
      stop(paste("Required file not found:", file))
    }
  }
}

validate_quarto_rendering <- function(project_path, template_name) {
  # Skip rendering test for now - would require Quarto to be installed
  # Future enhancement: could test if main .qmd files have valid YAML headers
  
  # Get the main document file
  if (template_name == "simple-paper") {
    main_file <- "paper.qmd"
  } else if (template_name == "empirical-study") {
    main_file <- "manuscript.qmd"
  } else if (template_name == "grant-application") {
    main_file <- "proposal.qmd"
  } else if (template_name == "literature-review") {
    main_file <- "review.qmd"
  } else if (template_name == "conference-presentation") {
    main_file <- "slides.qmd"
  } else {
    return() # No main document to test
  }
  
  main_path <- file.path(project_path, main_file)
  if (file.exists(main_path)) {
    # Basic validation: check if file starts with YAML header
    content <- readLines(main_path, n = 5)
    if (length(content) > 0 && content[1] == "---") {
      # File has YAML header, which is good
      return()
    } else {
      stop(paste("Main document", main_file, "does not have proper YAML header"))
    }
  }
}

validate_rproject_file <- function(project_path, project_name) {
  rproj_file <- file.path(project_path, paste0(project_name, ".Rproj"))
  
  if (!file.exists(rproj_file)) {
    stop("R project file not created")
  }
  
  # Check that it has basic R project content
  content <- readLines(rproj_file)
  if (!any(grepl("Version:", content))) {
    stop("R project file does not have valid content")
  }
}

# Run validation if script is executed directly
if (interactive()) {
  cat("Run validate_all_templates() to test all templates\n")
  cat("Run test_template('template-name', tempdir()) to test a specific template\n")
} else {
  # If run as script, validate all templates
  results <- validate_all_templates()
  
  # Exit with error code if any templates failed
  if (!all(sapply(results, function(x) x$success))) {
    quit(status = 1)
  }
}
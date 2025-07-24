# Project Initialization Tool
# Automates the setup of new projects from templates

library(fs)
library(here)
library(cli)
library(yaml)

initialize_project <- function(project_name, template_type, project_path = NULL) {
  
  # Validate inputs
  if (missing(project_name) || missing(template_type)) {
    stop("Both project_name and template_type are required")
  }
  
  available_templates <- c("simple-paper", "empirical-study", "grant-application", 
                          "literature-review", "conference-presentation")
  
  if (!template_type %in% available_templates) {
    stop("template_type must be one of: ", paste(available_templates, collapse = ", "))
  }
  
  # Set up paths
  template_root <- here()
  template_path <- file.path(template_root, "templates", template_type)
  shared_path <- file.path(template_root, "_shared")
  
  if (is.null(project_path)) {
    project_path <- file.path(getwd(), project_name)
  }
  
  # Check if template exists
  if (!dir.exists(template_path)) {
    stop("Template not found: ", template_path)
  }
  
  # Check if project directory already exists
  if (dir.exists(project_path)) {
    overwrite <- menu(
      choices = c("Yes", "No"),
      title = paste("Directory", project_path, "already exists. Overwrite?")
    )
    if (overwrite == 2) {
      cli_alert_info("Project initialization cancelled.")
      return(invisible(NULL))
    }
    fs::dir_delete(project_path)
  }
  
  cli_h1(paste("Initializing", template_type, "project:", project_name))
  
  # Copy template files
  cli_alert_info("Copying template files...")
  fs::dir_copy(template_path, project_path)
  
  # Copy shared components if they don't exist
  cli_alert_info("Adding shared components...")
  copy_shared_components(shared_path, project_path, template_type)
  
  # Customize project files
  cli_alert_info("Customizing project files...")
  customize_project_files(project_path, project_name, template_type)
  
  # Create .Rproj file if it doesn't exist
  create_rproject_file(project_path, project_name)
  
  # Initialize git repository
  initialize_git_repo(project_path, template_type)
  
  # Create initial directory structure
  create_project_directories(project_path, template_type)
  
  cli_alert_success(paste("Project", project_name, "initialized successfully!"))
  cli_h3("Next steps:")
  cli_ol(c(
    paste("Navigate to your project: cd", project_path),
    "Open the .Rproj file in RStudio",
    "Read the README.md for template-specific instructions",
    "Customize the template files for your specific project",
    "Begin your research work!"
  ))
  
  return(project_path)
}

copy_shared_components <- function(shared_path, project_path, template_type) {
  
  # Always copy admin files
  admin_source <- file.path(shared_path, "admin")
  admin_dest <- file.path(project_path, "admin")
  
  if (dir.exists(admin_source) && !dir.exists(admin_dest)) {
    fs::dir_copy(admin_source, admin_dest)
  }
  
  # Copy docs if needed
  docs_source <- file.path(shared_path, "docs") 
  docs_dest <- file.path(project_path, "docs")
  
  if (dir.exists(docs_source) && !dir.exists(docs_dest)) {
    fs::dir_copy(docs_source, docs_dest)
  }
  
  # Copy shared scripts for certain templates
  if (template_type %in% c("empirical-study", "literature-review")) {
    scripts_source <- file.path(shared_path, "scripts")
    scripts_dest <- file.path(project_path, "R", "shared")
    
    if (dir.exists(scripts_source)) {
      fs::dir_create(dirname(scripts_dest))
      fs::dir_copy(scripts_source, scripts_dest)
    }
  }
}

customize_project_files <- function(project_path, project_name, template_type) {
  
  # Update project name in key files
  update_files <- c("README.md", "paper.qmd", "manuscript.qmd", "proposal.qmd")
  
  for (file in update_files) {
    file_path <- file.path(project_path, file)
    if (file.exists(file_path)) {
      content <- readLines(file_path)
      
      # Replace placeholder project name
      content <- gsub("Your Project Title Here", project_name, content)
      content <- gsub("PROJECT_NAME", project_name, content)
      content <- gsub("your-project-name", project_name, content)
      
      # Update dates
      content <- gsub("YYYY-MM-DD", Sys.Date(), content)
      content <- gsub("today", Sys.Date(), content)
      
      writeLines(content, file_path)
    }
  }
  
  # Update _quarto.yml if it exists
  quarto_file <- file.path(project_path, "_quarto.yml")
  if (file.exists(quarto_file)) {
    quarto_config <- yaml::read_yaml(quarto_file)
    
    # Add project name to title if not present
    if (is.null(quarto_config$project$title)) {
      quarto_config$project$title <- project_name
    }
    
    yaml::write_yaml(quarto_config, quarto_file)
  }
}

get_template_gitignore <- function(template_type) {
  if (is.null(template_type)) {
    return(c())
  }
  
  switch(template_type,
    "simple-paper" = c(
      "# Simple paper outputs",
      "*.html",
      "*.pdf", 
      "*.docx",
      "",
      "# LaTeX intermediate files",
      "*.tex",
      "*.aux",
      "*.log",
      "*.out"
    ),
    
    "empirical-study" = c(
      "# Research data (be careful with sensitive data)",
      "data/raw/*.csv",
      "data/raw/*.xlsx", 
      "data/raw/*.sav",
      "data/raw/*.dta",
      "!data/raw/README.md",
      "",
      "# Analysis outputs", 
      "outputs/figures/*.png",
      "outputs/figures/*.jpg",
      "outputs/figures/*.pdf",
      "outputs/tables/*.csv",
      "outputs/tables/*.html",
      "!outputs/**/README.md",
      "",
      "# Document outputs",
      "*.html",
      "*.pdf",
      "*.docx"
    ),
    
    "grant-application" = c(
      "# Grant documents",
      "*.html",
      "*.pdf",
      "*.docx",
      "",
      "# Budget files (may contain sensitive info)",
      "budget/*.xlsx",
      "budget/*.csv",
      "!budget/template.xlsx",
      "",
      "# Letters of support (may contain sensitive info)",
      "letters/*.pdf",
      "correspondence/*.pdf"
    ),
    
    "literature-review" = c(
      "# Review outputs",
      "*.html",
      "*.pdf",
      "*.docx",
      "",
      "# Search results (large files)",
      "search-results/*.ris",
      "search-results/*.bib",
      "search-results/*.csv",
      "!search-results/README.md",
      "",
      "# Screening workflow",
      "screening/*.csv",
      "screening/*.xlsx",
      "!screening/README.md"
    ),
    
    "conference-presentation" = c(
      "# Presentation outputs",
      "*.html",
      "*.pdf",
      "*.pptx",
      "",
      "# Media files (can be large)",
      "media/*.mp4",
      "media/*.mov", 
      "media/*.avi",
      "!media/README.md"
    ),
    
    # Default case
    c()
  )
}

create_rproject_file <- function(project_path, project_name) {
  rproj_file <- file.path(project_path, paste0(project_name, ".Rproj"))
  
  if (!file.exists(rproj_file)) {
    rproj_content <- c(
      "Version: 1.0",
      "",
      "RestoreWorkspace: No", 
      "SaveWorkspace: No",
      "AlwaysSaveHistory: Default",
      "",
      "EnableCodeIndexing: Yes",
      "UseSpacesForTab: Yes",
      "NumSpacesForTab: 2",
      "Encoding: UTF-8",
      "",
      "RnwWeave: knitr",
      "LaTeX: pdfLaTeX",
      "",
      "AutoAppendNewline: Yes",
      "StripTrailingWhitespace: Yes",
      "LineEndingConversion: Posix"
    )
    
    writeLines(rproj_content, rproj_file)
  }
}

initialize_git_repo <- function(project_path, template_type = NULL) {
  # Base .gitignore content for all templates
  base_gitignore <- c(
    "# R",
    ".RData",
    ".Rhistory", 
    ".Rproj.user/",
    "",
    "# Quarto",
    "/.quarto/",
    "_site/",
    "_book/",
    "_output/",
    "",
    "# System files",
    ".DS_Store",
    "Thumbs.db",
    "",
    "# Sensitive information",
    "*.env",
    "credentials.R",
    "api_keys.R"
  )
  
  # Template-specific additions
  template_specific <- get_template_gitignore(template_type)
  
  # Combine base and template-specific patterns
  gitignore_content <- c(base_gitignore, "", template_specific)
  
  writeLines(gitignore_content, file.path(project_path, ".gitignore"))
  
  # Initialize git repo if git is available
  if (Sys.which("git") != "") {
    old_wd <- getwd()
    setwd(project_path)
    
    system("git init", intern = TRUE)
    system("git add .", intern = TRUE) 
    system('git commit -m "Initial project setup from template"', intern = TRUE)
    
    setwd(old_wd)
    cli_alert_success("Git repository initialized")
  } else {
    cli_alert_warning("Git not found - skipping repository initialization")
  }
}

create_project_directories <- function(project_path, template_type) {
  
  # Common directories for all templates
  common_dirs <- c("figures", "tables", "archive")
  
  # Template-specific directories
  if (template_type == "empirical-study") {
    dirs <- c(common_dirs, "data/raw", "data/processed", "instruments", "outputs/reports")
  } else if (template_type == "grant-application") {
    dirs <- c(common_dirs, "admin/correspondence", "reporting/annual-reports")
  } else if (template_type == "literature-review") {
    dirs <- c(common_dirs, "search-results", "screening", "data-extraction")
  } else {
    dirs <- common_dirs
  }
  
  # Create directories with README files
  for (dir in dirs) {
    dir_path <- file.path(project_path, dir)
    fs::dir_create(dir_path)
    
    readme_path <- file.path(dir_path, "README.md")
    if (!file.exists(readme_path)) {
      readme_content <- paste("# ", basename(dir), "\n\nThis directory contains ", basename(dir), " for the project.")
      writeLines(readme_content, readme_path)
    }
  }
}

# Interactive project setup
interactive_setup <- function() {
  cli_h1("Interactive Project Setup")
  
  # Get project details
  project_name <- readline("Enter project name: ")
  if (project_name == "") {
    cli_alert_danger("Project name is required")
    return(invisible(NULL))
  }
  
  # Choose template
  templates <- c("simple-paper", "empirical-study", "grant-application", 
                "literature-review", "conference-presentation")
  
  template_choice <- menu(
    choices = templates,
    title = "Choose a template type:"
  )
  
  if (template_choice == 0) {
    cli_alert_info("Setup cancelled")
    return(invisible(NULL))
  }
  
  template_type <- templates[template_choice]
  
  # Get project location
  use_current_dir <- menu(
    choices = c("Yes", "No"),
    title = paste("Create project in current directory (", getwd(), ")?")
  )
  
  if (use_current_dir == 2) {
    project_path <- readline("Enter full path for project directory: ")
    if (project_path == "") {
      project_path <- NULL
    }
  } else {
    project_path <- NULL
  }
  
  # Initialize project
  result <- initialize_project(project_name, template_type, project_path)
  return(result)
}

# Run interactive setup if script is executed directly
if (interactive()) {
  cat("Run template_chooser() first to select the right template, then:\n")
  cat("- initialize_project('my-project', 'simple-paper') for direct setup\n")
  cat("- interactive_setup() for guided setup\n")
}
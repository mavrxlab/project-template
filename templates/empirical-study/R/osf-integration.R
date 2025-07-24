# OSF Integration Helper Functions
# Functions to help with Open Science Framework integration

#' Check if OSF R package is available
#' 
#' @return logical indicating if osfr package is installed
check_osf_package <- function() {
  if (!requireNamespace("osfr", quietly = TRUE)) {
    message("OSF integration requires the 'osfr' package.")
    message("Install with: install.packages('osfr')")
    message("See: https://docs.ropensci.org/osfr/")
    return(FALSE)
  }
  return(TRUE)
}

#' Setup OSF authentication
#' 
#' @details This function helps set up OSF authentication.
#' You'll need to create a Personal Access Token on OSF.
setup_osf_auth <- function() {
  if (!check_osf_package()) return(invisible(NULL))
  
  cat("OSF Authentication Setup\n")
  cat("========================\n\n")
  cat("1. Go to https://osf.io/settings/tokens/\n")
  cat("2. Click 'Create token'\n")
  cat("3. Give it a name (e.g., 'R Integration')\n")
  cat("4. Select appropriate scopes (osf.full_write for uploads)\n")
  cat("5. Copy the token\n")
  cat("6. Store it securely using:\n")
  cat("   Sys.setenv(OSF_PAT = 'your_token_here')\n")
  cat("   Or add to your .Renviron file\n\n")
  cat("Then restart R and test with: osfr::osf_auth()\n")
}

#' Create OSF project for study
#' 
#' @param title Character string with project title
#' @param description Character string with project description
#' @param public Logical, whether project should be public (default: FALSE)
#' @return OSF project object if successful
create_osf_project <- function(title, description = "", public = FALSE) {
  if (!check_osf_package()) return(invisible(NULL))
  
  tryCatch({
    # Check authentication
    osfr::osf_auth()
    
    # Create project
    project <- osfr::osf_create_project(
      title = title,
      description = description,
      public = public
    )
    
    cat("OSF project created successfully!\n")
    cat("Project URL:", project$relationships$html$links$related$href, "\n")
    cat("Project ID:", project$id, "\n")
    
    return(project)
    
  }, error = function(e) {
    cat("Error creating OSF project:", e$message, "\n")
    cat("Make sure you're authenticated with OSF.\n")
    cat("Run setup_osf_auth() for help.\n")
    return(invisible(NULL))
  })
}

#' Upload pre-registration to OSF
#' 
#' @param project_id OSF project ID (from create_osf_project or existing project)
#' @param prereg_file Path to pre-registration file (default: "preregistration.qmd")
#' @return Upload result if successful
upload_preregistration <- function(project_id, prereg_file = "preregistration.qmd") {
  if (!check_osf_package()) return(invisible(NULL))
  
  if (!file.exists(prereg_file)) {
    cat("Pre-registration file not found:", prereg_file, "\n")
    return(invisible(NULL))
  }
  
  tryCatch({
    # Get project
    project <- osfr::osf_retrieve_node(project_id)
    
    # Create preregistration folder if it doesn't exist
    folders <- osfr::osf_ls_files(project)
    
    if (!"preregistration" %in% folders$name) {
      osfr::osf_mkdir(project, "preregistration")
    }
    
    # Upload file
    upload_result <- osfr::osf_upload(
      x = project,
      path = prereg_file,
      recurse = FALSE,
      conflicts = "overwrite"
    )
    
    cat("Pre-registration uploaded successfully!\n")
    cat("File URL:", upload_result$meta$download, "\n")
    
    return(upload_result)
    
  }, error = function(e) {
    cat("Error uploading pre-registration:", e$message, "\n")
    return(invisible(NULL))
  })
}

#' Create study materials structure on OSF
#' 
#' @param project_id OSF project ID
#' @return TRUE if successful
create_study_structure <- function(project_id) {
  if (!check_osf_package()) return(invisible(NULL))
  
  tryCatch({
    project <- osfr::osf_retrieve_node(project_id)
    
    # Standard folders for empirical studies
    folders_to_create <- c(
      "preregistration",
      "materials",
      "data", 
      "analysis",
      "manuscripts",
      "supplements"
    )
    
    existing_folders <- osfr::osf_ls_files(project)$name
    
    for (folder in folders_to_create) {
      if (!folder %in% existing_folders) {
        osfr::osf_mkdir(project, folder)
        cat("Created folder:", folder, "\n")
      } else {
        cat("Folder already exists:", folder, "\n")
      }
    }
    
    cat("Study structure created successfully!\n")
    return(TRUE)
    
  }, error = function(e) {
    cat("Error creating study structure:", e$message, "\n")
    return(invisible(NULL))
  })
}

#' Generate OSF citation for project
#' 
#' @param project_id OSF project ID
#' @return Citation string
get_osf_citation <- function(project_id) {
  if (!check_osf_package()) return(invisible(NULL))
  
  tryCatch({
    project <- osfr::osf_retrieve_node(project_id)
    
    # Basic citation format
    title <- project$attributes$title
    date <- as.Date(project$attributes$date_created)
    url <- project$relationships$html$links$related$href
    
    citation <- paste0(
      "Retrieved from Open Science Framework: ", url,
      " (Created: ", format(date, "%B %d, %Y"), ")"
    )
    
    cat("OSF Citation:\n")
    cat(citation, "\n\n")
    cat("Add this to your manuscript acknowledgments or data availability statement.\n")
    
    return(citation)
    
  }, error = function(e) {
    cat("Error generating citation:", e$message, "\n")
    return(invisible(NULL))
  })
}

#' Quick start guide for OSF integration
osf_quick_start <- function() {
  cat("OSF Integration Quick Start Guide\n")
  cat("=================================\n\n")
  cat("1. Set up authentication:\n")
  cat("   setup_osf_auth()\n\n")
  cat("2. Create project:\n")
  cat("   project <- create_osf_project('My Study Title')\n\n")
  cat("3. Create folder structure:\n") 
  cat("   create_study_structure(project$id)\n\n")
  cat("4. Upload pre-registration:\n")
  cat("   upload_preregistration(project$id)\n\n")
  cat("5. Get citation:\n")
  cat("   get_osf_citation(project$id)\n\n")
  cat("For more help, see: https://docs.ropensci.org/osfr/\n")
}

# Print quick start when script is sourced
if (interactive()) {
  cat("OSF integration functions loaded.\n")
  cat("Run osf_quick_start() to see usage guide.\n")
}
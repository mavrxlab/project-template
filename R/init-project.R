# Project initialization script

library(fs)
library(here)

# Create project structure
create_dirs <- function() {
  dirs <- c('data/raw', 'data/tidy',
           'analysis/data-prep', 'analysis/scripts',
           'papers', 'presentations')
  walk(dirs, dir_create)
}

# Initialize git
init_git <- function() {
  usethis::use_git()
  usethis::use_github()
}

# Setup dependencies
setup_deps <- function() {
  renv::init()
}

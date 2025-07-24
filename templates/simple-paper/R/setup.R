# Simple Paper Template - Basic Setup
# Load essential packages and functions for academic writing

# Essential packages for academic writing
library(here)      # Robust file paths
library(knitr)     # Document generation
library(kableExtra) # Enhanced tables (if needed)

# Set up knitr options for consistent output
knitr::opts_chunk$set(
  echo = FALSE,           # Don't show code by default
  warning = FALSE,        # Suppress warnings
  message = FALSE,        # Suppress messages
  fig.width = 7,          # Default figure width
  fig.height = 5,         # Default figure height
  dpi = 300,              # High resolution figures
  fig.path = "figures/"   # Save figures to figures/ directory
)

# Helper function for formatting numbers in text
format_number <- function(x, digits = 2) {
  format(round(x, digits), nsmall = digits, big.mark = ",")
}

# Helper function for creating simple tables
simple_table <- function(data, caption = NULL) {
  kable(data, 
        caption = caption,
        booktabs = TRUE,
        longtable = TRUE) %>%
    kable_styling(
      latex_options = c("striped", "hold_position"),
      bootstrap_options = c("striped", "hover", "condensed")
    )
}

# Set up figure and table directories
if (!dir.exists("figures")) dir.create("figures")
if (!dir.exists("tables")) dir.create("tables")

# Print setup confirmation
message("Simple paper template setup complete")
message("Using here() root: ", here())
message("Figures will be saved to: ", file.path(here(), "figures"))
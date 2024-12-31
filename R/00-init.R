# Initialize project environment and settings
library(here)

# Set random seed for reproducibility
set.seed(20240101)

# Create necessary directories if they don't exist
dir.create(here("data", "raw"), recursive = TRUE, showWarnings = FALSE)
dir.create(here("data", "processed"), recursive = TRUE, showWarnings = FALSE)
dir.create(here("outputs", "figures"), recursive = TRUE, showWarnings = FALSE)
dir.create(here("outputs", "tables"), recursive = TRUE, showWarnings = FALSE)
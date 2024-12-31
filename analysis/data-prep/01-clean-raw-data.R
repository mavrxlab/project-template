# Data cleaning script template

library(tidyverse)
library(here)

# Source custom functions
source(here('R', 'functions.R'))

# Read raw data
raw_data <- read_csv(here('data', 'raw', 'dataset.csv'))

# Clean and process

# Save to tidy
write_csv(clean_data, here('data', 'tidy', 'clean_dataset.csv'))

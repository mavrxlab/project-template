# Load and preprocess data
source(here("R", "10-libraries.R"))

# Function to load survey data (modify based on data format)
load_survey_data <- function() {
  raw_data <- read_csv(here("data", "raw", "survey_data.csv"))
  return(raw_data)
}

# Function to clean and prepare data
prepare_data <- function(data) {
  clean_data <- data %>%
    drop_na() %>%           # Handle missing values
    mutate(across(where(is.character), as.factor))  # Convert characters to factors
  
  return(clean_data)
}

# Load and prepare data
raw_data <- load_survey_data()
clean_data <- prepare_data(raw_data)

# Save processed data
write_rds(clean_data, here("data", "processed", "clean_data.rds"))
# Data validation functions

validate_data <- function(data) {
  # Check for missing values
  missing <- colSums(is.na(data))
  
  # Check data types
  types <- sapply(data, class)
  
  # Check value ranges
  ranges <- sapply(data[sapply(data, is.numeric)], range)
  
  list(
    missing = missing,
    types = types,
    ranges = ranges
  )
}

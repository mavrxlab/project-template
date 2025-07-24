# Descriptive statistics

# Generate descriptive statistics
describe_variables <- function(data) {
  # Summary statistics
  descriptives <- data %>%
    tbl_summary(
      statistic = list(
        all_continuous() ~ "{mean} ({sd})",
        all_categorical() ~ "{n} ({p}%)"
      )
    )
  
  # Save to file
  gt::gtsave(
    as_gt(descriptives),
    here("outputs", "tables", "descriptives.html")
  )
  
  return(descriptives)
}

# Create demographic visualizations
create_demographic_plots <- function(data) {
  # Example plots (modify based on variables)
  age_dist <- ggplot(data, aes(x = age)) +
    geom_histogram() +
    theme_minimal() +
    labs(title = "Age Distribution")
  
  ggsave(
    here("outputs", "figures", "age_distribution.png"),
    age_dist
  )
}
# Scale reliability analysis

# Function to compute scale reliability
compute_reliability <- function(data, scale_items) {
  # Cronbach's alpha
  alpha_result <- psych::alpha(data[scale_items])
  
  # McDonald's omega
  omega_result <- psych::omega(data[scale_items])
  
  # Create summary table
  reliability_summary <- tibble(
    scale_name = deparse(substitute(scale_items)),
    cronbach_alpha = alpha_result$total$raw_alpha,
    mcdonalds_omega = omega_result$omega.tot
  )
  
  write_csv(
    reliability_summary,
    here("outputs", "tables", "reliability_analysis.csv")
  )
  
  return(reliability_summary)
}
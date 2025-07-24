# Hypothesis testing

# Function to test hypotheses and generate report
test_hypotheses <- function(data, hypotheses) {
  results <- list()
  
  for(h in names(hypotheses)) {
    # Run appropriate test based on hypothesis type
    test_result <- switch(hypotheses[[h]]$type,
      "correlation" = conduct_correlations(data, hypotheses[[h]]$vars),
      "t_test" = conduct_ttests(data, hypotheses[[h]]$dv, hypotheses[[h]]$group),
      "regression" = conduct_regression(data, hypotheses[[h]]$dv, hypotheses[[h]]$ivs),
      "anova" = conduct_anova(data, hypotheses[[h]]$dv, hypotheses[[h]]$factor)
    )
    
    results[[h]] <- test_result
  }
  
  # Generate summary report
  report <- report_table(results) %>%
    as_gt() %>%
    gt::gtsave(here("outputs", "tables", "hypothesis_tests.html"))
  
  return(results)
}

# Example hypotheses structure
hypotheses <- list(
  H1 = list(
    type = "correlation",
    vars = c("var1", "var2"),
    description = "There is a positive correlation between var1 and var2"
  ),
  H2 = list(
    type = "t_test",
    dv = "outcome",
    group = "condition",
    description = "Condition affects outcome"
  )
)
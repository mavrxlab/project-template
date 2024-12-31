# Inferential statistics

# T-tests
conduct_ttests <- function(data, dv, group_var) {
  t_result <- t.test(data[[dv]] ~ data[[group_var]])
  d <- cohens_d(data[[dv]] ~ data[[group_var]])
  
  return(list(t_test = t_result, effect_size = d))
}

# ANOVA
conduct_anova <- function(data, dv, factor_var) {
  model <- aov(as.formula(paste(dv, "~", factor_var)), data = data)
  eta <- eta_squared(model)
  
  return(list(anova = model, effect_size = eta))
}

# Correlation analysis
conduct_correlations <- function(data, vars) {
  cor_matrix <- correlation(data[vars]) %>%
    summary()
  
  write_csv(
    cor_matrix,
    here("outputs", "tables", "correlation_matrix.csv")
  )
  
  return(cor_matrix)
}

# Regression analysis
conduct_regression <- function(data, dv, ivs) {
  formula <- as.formula(paste(dv, "~", paste(ivs, collapse = " + ")))
  model <- lm(formula, data = data)
  
  # Model diagnostics
  check_model(model)
  ggsave(here("outputs", "figures", "model_diagnostics.png"))
  
  # Summary table
  summary_table <- model %>%
    tbl_regression() %>%
    add_glance_table()
  
  gt::gtsave(
    as_gt(summary_table),
    here("outputs", "tables", "regression_summary.html")
  )
  
  return(model)
}
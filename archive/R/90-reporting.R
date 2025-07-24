# Generate statistical reports

# Create APA-style results section
generate_results_report <- function(results, hypotheses) {
  report <- report_performance(results) %>%
    report_parameters() %>%
    report_statistics()
  
  # Save report
  write_lines(
    report,
    here("outputs", "results_report.txt")
  )
  
  return(report)
}

# Generate tables for publication
create_publication_tables <- function(results) {
  # Descriptive statistics table
  desc_table <- tbl_summary(results$descriptives)
  
  # Results table
  results_table <- tbl_regression(results$model) %>%
    add_glance_source_note() %>%
    modify_header(label = "**Variable**") %>%
    modify_spanning_header(c("stat_1", "stat_2") ~ "**Model Results**")
  
  # Save tables
  gt::gtsave(
    as_gt(desc_table),
    here("outputs", "tables", "descriptives_publication.html")
  )
  
  gt::gtsave(
    as_gt(results_table),
    here("outputs", "tables", "results_publication.html")
  )
  
  return(list(
    descriptives = desc_table,
    results = results_table
  ))
}
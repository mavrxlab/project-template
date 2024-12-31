# Source all analysis scripts in order
library(here)

scripts <- c(
  "00-init.R",
  "10-libraries.R",
  "15-functions.R", 
  "20-data-load.R",
  "30-descriptives.R",
  "40-reliability.R",
  "50-inferential.R",
  "60-hypothesis-testing.R",
  "70-visualization.R",
  "80-power-analysis.R",
  "90-reporting.R"
)

for(script in scripts) {
  source(here("R", script))
}
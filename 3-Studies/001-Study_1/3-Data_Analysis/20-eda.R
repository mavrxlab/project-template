# This is for your exploratory data analysis

library(tidyverse)

# Create a kilometers per litre variable
df <- mtcars %>% mutate(
  kpl = mpg * 0.425143706
)

# Check out the structure of the new dataframe
str(df)

# Get a summary table grouped by cylinder

cylindersummary <- df %>%
  group_by(cyl) %>% 
  summarize(
  mean_mpg = mean(mpg),
  mean_kpl = mean(kpl),
  n = n()
)

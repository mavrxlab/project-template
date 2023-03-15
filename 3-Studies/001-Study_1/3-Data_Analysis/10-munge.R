# This is where you'll use your data loading scripts, as well as any code
# that is meant to clean, alter, et cetera. NEVER over-write your raw
# data! (If using tidytuesday to load data, this won't be an issue.)

library(tidytuesdayR)
library(tidyverse)

tuesdata <- tidytuesdayR::tt_load(2022, week = 2)

colony <- tuesdata$colony
stressor <- tuesdata$stressor

# Don't actually do this. It's just an example. drop_na() drops ALL missing data.
colony <- colony %>% drop_na()

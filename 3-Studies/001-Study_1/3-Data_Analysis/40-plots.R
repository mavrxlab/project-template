# Put the code for your plots here. Assign them to objects.
# In your document, simply call the object.

library(ggplot2)
library(tidyverse)

carsplot <- mtcars %>% ggplot(
            aes(x = mpg)) +
            geom_histogram()


## install new package in RStudio
# install.packages("dplyr")
# install.packages("tidyverse")

## load library
library(tidyverse)

################################################################################

# data.frame vs tibble
(df_tibble <- tibble(id = 1:3, name = c("toy", "jisoo", "lisa")))
(df <- data.frame(id = 1:3, name = c("toy", "jisoo", "lisa")))

# convert dataframe to tibble
mtcars %>% head(10)
(mtcars_tibble <- tibble(mtcars))

################################################################################

## sample n
sample_n(mtcars, size=5)

## set seed
set.seed(555)
sample_n(mtcars, size=5)

# sample data 50% of all rows
sample_frac(mtcars, size=0.5)

# sample data 20% of all rows (row «éÓä´é)
sample_frac(mtcars, size=0.5, replace=TRUE)

################################################################################

## slice
mtcars %>%
  slice(1:5)

mtcars %>%
  slice(6:10)

mtcars %>%
  slice(c(1,3,5))

mtcars %>%
  slice(sample(nrow(mtcars), 10))

################################################################################

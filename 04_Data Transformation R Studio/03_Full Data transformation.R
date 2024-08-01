# load library
library(tidyverse)
library(glue)
library(lubridate)

################################################################################

# glue messages
my_name <- "toy"
my_age <- 35

glue("Hi! my name is {my_name}. Today I'm {my_age} years old.")

paste("Hi! my name is", my_name, ".")

################################################################################

# library tidyverse
# data transformation => dplyr

# 1. select
# 2. filter
# 3. arrange
# 4. mutate => create new column
# 5. summarise + group_by

mtcars <- rownames_to_column(mtcars, "model")
view(mtcars)

################################################################################

## pipeline
select(mtcars, mpg, hp, wt)

select(mtcars, 1:5)

select(mtcars, 1, 2, 5, 8)

select(mtcars, mpg, hp, wt, 11)

select(mtcars, starts_with("m"))

select(mtcars, ends_with("p"))

select(mtcars, contains("a"))

################################################################################

## Filter
m2 <- mtcars %>%
  select(mpg, hp, wt) %>%
  filter(hp > 200)

mtcars %>%
  select(mpg, hp, wt) %>%
  filter(hp > 200 & mpg >= 15)

mtcars %>%
  select(mpg, hp, wt) %>%
  filter(hp > 200 | mpg >= 15)

mtcars %>%
  select(mpg, hp, wt, am) %>%
  filter(am == 0)

################################################################################

state.name
grep("^A", state.name)
grep("^A", state.name, value = F)

grep("^A", state.name, value = T)

grepl("^A", state.name)


grepl("^M", mtcars$model)

mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  filter(grepl("^M", model) & hp > 150)

################################################################################

## filter am==0
m3 <- mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  filter(between(hp, 100, 200)) %>%
  arrange(am, desc(hp)) %>%
  head()

################################################################################

## write csv file
write_csv(m3, "result.csv")

################################################################################

## mutate to create new columns
mtcars %>%
  filter(mpg >= 20) %>%
  select(model, mpg, hp, wt, am) %>%
  mutate(
    mpg_double = mpg*2,
    mpg_hahaha = mph_double+10)

mtcars %>%
  filter(mpg >= 20) %>%
  select(model, mpg, hp, wt, am) %>%
  mutate(
    model_upper = toupper(model))

mtcars %>%
  filter(mpg >= 20) %>%
  select(model, mpg, hp, wt, am) %>%
  mutate(
    ## =IF(am=0, "auto", "manual")
    am_label = if_else(am==0, "auto", "manual"))

################################################################################

## summarise, summarize
## aggregate function in SQL

mtcars %>%
  summarise(mean(mpg))

mtcars %>%
  summarise(avg_mpg = mean(mpg),
            med_mpg = median(mpg),
            sum_mpg = sum(mpg),
            min_mpg = min(mpg),
            max_hp = max(hp),
            # spread
            var_hp = var(hp),
            sd_hp = sd(hp),
            n = n())

################################################################################

## group_by + summarise

m4 <- mtcars %>%
  mutate(am = if_else(am==0,
                      "Auto","Manual")) %>%
  group_by(am) %>%
  summarise(avg_mpg = mean(mpg),
            sum_mpg = sum(mpg),
            min_mpg = min(mpg),
            max_hp = max(hp),
            n = n())

################################################################################

band_members %>% 
  left_join(band_instruments)

band_members %>% 
  left_join(band_instruments, by="name")

band_members %>% 
  inner_join(band_instruments, by="name")

band_members %>% 
  full_join(band_instruments, by="name")

m4 <- band_members %>%
  select(member_name = name,
         band_name = band) %>%
  left_join(band_instruments,
            by = c("member_name" = "name"))

################################################################################

## random sampling 
mtcars %>%
  sample_n(5)

mtcars %>%
  sample_n(2) %>%
  pull(model)

mtcars %>%
  sample_frac(0.15)

mtcars %>%
  summarise(avg_hp = mean(hp))
mtcars %>%
  sample_frac(0.20) %>%
  summarise(avg_hp = mean(hp))

################################################################################

## count
mtcars <- mtcars %>%
  mutate(am = if_else(am==0, "Auto", "Manual"))

mtcars %>%
  count(am) %>%
  mutate(pecentage = n / sum(n))

mtcars %>%
  count(am, cyl) %>%
  mutate(pecentage = n / sum(n))

################################################################################

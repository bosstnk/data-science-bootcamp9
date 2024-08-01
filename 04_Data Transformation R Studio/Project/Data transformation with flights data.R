## transform nycflights13
library(nycflights13)
library(tidyverse

data("flights")
data("airlines")
data("weather")
data("airports")
        
################################################################################

## Q1-Which month in the year 2013 had the most flights?
flights %>%
  filter(year == 2013) %>%
  count(month) %>%
  group_by(month) %>%
  arrange(desc(n)) %>%
  select(month, No_flights = n) %>%
  head(1)

################################################################################

## Q2-What are the top 5 destinations that flights fly to the most in July?
flights %>%
filter(month == 7 ,year == 2013) %>%
count(dest) %>%
group_by(dest) %>%
left_join(airports,by = c("dest" = "faa")) %>%
select(dest,total_flight = n,airport_name = name) %>%
arrange(desc(total_flight)) %>%
head(5)

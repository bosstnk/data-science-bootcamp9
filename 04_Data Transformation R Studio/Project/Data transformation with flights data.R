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

################################################################################

## Q3-Identify the top 5 carriers that have the most opportunity for delayed flights?
# Find how many flight delay
air_delay <- flights %>%
        group_by(carrier) %>%
        select(carrier, arr_delay) %>%
        filter(arr_delay > 0) %>%
        summarise(t_delay = n())
  
# Calculate with all flight
carrier_delay <- flights %>%
        group_by(carrier) %>%
        select(carrier, arr_delay) %>%
        summarise(t_flights = n()) %>%
        inner_join(air_delay, by = "carrier") %>%
        mutate(pct_delay = (t_delay/t_flights)*100) %>%
        arrange(desc(pct_delay)) %>%
        select(carrier, pct_delay) %>%
        inner_join(airlines, by = "carrier") %>%
        head(5)

################################################################################

## Q4-Average arrival and departure delay flight of each airlines?
avg_delay <- flights %>%
        select(dep_delay, arr_delay, carrier) %>%
        left_join(airlines, by = "carrier") %>%
        group_by(name) %>%
        summarise(avg_arrival_delay = mean(arr_delay,na.rm = TRUE),
                  avg_departure_delay = mean(dep_delay,na.rm = TRUE)) %>%
        arrange(avg_arrival_delay,avg_departure_delay)

################################################################################

## Q5-How many flights from all carriers fly from EWR to SFO
flights %>%
        filter(origin == "EWR" & dest == "SFO") %>%
        count(carrier) %>%
        select(carrier, total_flights = n)
        

## install new package in RStudio
# install.packages("dplyr")

## load library
library(dplyr)
library(readr)

################################################################################

imdb <- read.csv("data/imdb.csv", stringsAsFactors = FALSE)
View(imdb)

## review data structure
glimpse(imdb)

head(imdb)
head(imdb, 10)
tail(imdb)
tail(imdb, 10)

imdb %>% head()

################################################################################

names(imdb)

# by column name
select(imdb, SCORE, RATING)

# by column index 
select(imdb, 1, 5)

select(imdb, id_movie = NO, release_year = YEAR)

## pipe operator
imdb %>% 
  select(id_movie = NO, release_year = YEAR) %>%
  head(10)

################################################################################

## change column names
names(imdb) <- tolower(names(imdb))
names(imdb)

################################################################################

## pattern matching in character
grepl("Drama", imdb$genre)

################################################################################

## filter data I
filter(imdb, SCORE >= 9.0)

imdb %>% 
  filter(SCORE >= 9.0)

imdb %>% 
  select(movie_name, year, score) %>%
  filter(SCORE >= 9 & year > 2000)

imdb %>%
  select(movie_name, length, score) %>%
  filter(score == 8.8 | score == 8.3 | score == 9)

imdb %>%
  select(movie_name, length, score) %>%
  filter(score %in% c(8.3, 8.8, 9.0))

################################################################################

## filter data II
imdb %>%
  select(movie_name, genre, rating) %>%
  filter(genre == "Drama")

imdb %>%
  select(movie_name, genre, rating) %>%
  filter(grepl("Drama", imdb$genre))

imdb %>%
  select(movie_name) %>%
  filter(grepl("The", imdb$movie_name))

imdb %>%
  select(movie_name) %>%
  filter(grepl("the", imdb$movie_name))

################################################################################

## create new column
imdb %>%
  select(no, score, length) %>%
  mutate(score_group = if_else(score >= 9, "High Rating", "Low Rating"),
         length_group = if_else(length >= 120, "Long Film", "Short Film"))

imdb %>%
  select(no, score, length) %>%
  mutate(score_update = score + 0.1) %>%
  head(10)

imdb %>%
  select(no, score, length) %>%
  mutate(score = score + 0.1) %>%
  head(10)

################################################################################

## Arrange data

imdb %>%
  arrange(length) %>%
  head(10)

imdb %>%
  arrange(desc(length)) %>% ## descending order
  head(10)

imdb %>%
  arrange(rating, desc(length)) %>%
  head(10)

################################################################################

## Summary Statistics

## summarise and group_by

imdb %>%
  summarise(mean_length = mean(length),
            sum_length = sum(length),
            sd_length = sd(length),
            min_length = min(length),
            max_length = max(length),
            count = n())

imdb %>%
  filter(rating != "") %>%
  group_by(rating) %>%
  summarise(mean_length = mean(length),
            sum_length = sum(length),
            sd_length = sd(length),
            min_length = min(length),
            max_length = max(length),
            count = n())

################################################################################

## Join data

favourite_films <- data.frame(id = c(5, 10, 25, 30, 98))

favourite_films %>%
  inner_join(imdb, by = c("id" = "no"))

################################################################################

## write csv file (export result)
imdb_prep <- imdb %>%
  select(movie_name, released_year = year, rating, length, score) %>%
  filter(rating == "R", released_year > 2000)

write.csv(imdb_prep, "data/imdb_prep.csv", row.names = FALSE)

################################################################################

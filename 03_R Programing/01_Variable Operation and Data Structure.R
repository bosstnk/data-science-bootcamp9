## Create variable
income <- 50000
income
expense <- 30000
expense
saving <-  income - expense
saving

## remove variable
rm(saving)

####################################################################

## compare values
1 + 1 == 2
2 * 2 <= 4
5 >= 10
5-2 != 3 # not equal
10 < 2
10 < 2

## compare texts/characters
"Hello" == "Hello"

"Hello" == "hello"

####################################################################

## Data Types

# 1. Numeric
age <-32
print(age)
class(age)

# 2. Character
my_name <- "Folk"
my_university <-'UTCC'
print(my_name)
print(my_university)
class(my_name); class(my_university)

# 3. logical
result <- 1 + 1 == 2
print(result)
class(result)

# 4. factor
animals_vector <- c("Dog", "Cat", "Cat", "Hippo")
animals_vector
class(animals_vector)

animals_factor <- factor(animals_vector)
animals_factor
class(animals_factor)

# 5. date/time
time_now <- Sys.time()
time_now
class(time_now)

# NULL
class(NULL)

####################################################################

## Convert Data Types

## main function
## as.numeric()
## as.character()
## as.logical()

x = 100
class(x)
char_x = as.character(x)
num_x = as.numeric(x)

## logical: TRUE / FALSE
as.logical(0)
as.logical(1)
as.numeric(TRUE)
as.numeric(FALSE)

####################################################################

## Data Structures

#-----------------------------

## 1. Vector

1:10
16:25

# sequence generation
seq(from = 1, to = 100, by = 5)

# help file
help("seq")

## function c
friends <- c("David", "Marry", 
             "Anna", "John", 
             "William")
friends

age <- c(30, 31, 25, 29, 32)
age

is_male <- c(TRUE, FALSE, FALSE, TRUE, TRUE)
is_male


#-----------------------------

## 2. Matrix

x <- 1:25
x
length(x)

dim(x) <- c(5,5)
x

m1 <- matrix(1:25, ncol=5)
m1

m2 <- matrix(1:6, ncol=3, nrow=2)
m2

m3 <- matrix(1:6, ncol=3, nrow=2, byrow=T)
m3

# element wise computation
# + ทุก element ใน matrix
m2 + 100

#-----------------------------

## 3. List
my_name <- "Toy"
my_friends <- c("Wan", "Ink", "Zue")
m1 <- matrix(1:25, ncol=5)
R_is_cool <- TRUE

my_list <- list(item1 = my_name,
                item2 = my_friends,
                item3 = m1,
                item4 = R_is_cool)
my_list

my_list$item3
my_list$item4


#-----------------------------

## 4. DataFrame
friends <- c("Wan", "Ink", "Aan",
             "Bee", "Top")
ages <- c(26, 27, 32, 31, 28)
locations <- c("New York", "London",
               "London", "Tokyo",
               "Manchester")
movie_lover <- c(TRUE, TRUE, FALSE,
                 TRUE, TRUE)

df <- data.frame(friends,
                 ages,
                 locations,
                 movie_lover)
df

View(df)

my_list <- list(friends = friends,
                ages = ages,
                locations = locations,
                movie_lover = movie_lover)
df <- data.frame(my_list)

# slice dataframe
df[,c(2,4)] # all row and some row
df[1:4,] # some row and all column

####################################################################

## Subset Data Structure

friends <- c("Wan", "Ink", "Aan",
             "Bee", "Top")
ages <- c(26, 27, 32, 31, 28)
locations <- c("New York", "London",
               "London", "Tokyo",
               "Manchester")
movie_lover <- c(TRUE, TRUE, FALSE,
                 TRUE, TRUE)

df <- data.frame(friends,
                 ages,
                 locations,
                 movie_lover)

# Subset vector
friends[1]
friends[3:5]
friends[c(1,3,5)]

ages[ages>30]
ages[ages<=30]

names(ages) <- friends
ages
ages["Wan"]
ages[c("Wan", "Aan", "Bee")]


# subset dataframe
df[1, 3]
df[1:2, 3]
df[, 2:4]

df[2:4, "friends"]
df[, c("friends", "locations")]

df[df$movie_lover == TRUE, ]
df[df$ages < 30, c("friends", "ages")]
df[df$friends == "Top", ]

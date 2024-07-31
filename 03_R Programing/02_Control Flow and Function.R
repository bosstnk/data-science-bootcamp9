# control flow
## if
score <- 88
if (score >= 80) {
  print("Passed")
} else {
  print("Failed")
}

## if if
score <- 88
if (score >= 90) {
  print("Passed")
} else if (score >= 50) {
  print("Ok")
} else {
  print("Enroll again!")
}

-------------------------------------------------------------------
## ifelse
score <- 25
ifelse(score >= 80, "Passed", "Failed")


ifelse(score >= 80, "Passed", ifelse(
  score >= 50, "OK", "Enroll Again"
))
-------------------------------------------------------------------

# for
friends <- c("Toy", "John", "Mary", "Anna")

for (friend in friends) {
  print(paste("Hi!", friend))
}

-------------------------------------------------------------------

# vectorization

(friends <- c("Toy", "John", "Mary", "Anna"))
(paste("Hi!", friends))

(nums <- c(5, 10, 12, 20, 25))
(nums <- nums + 2)

-------------------------------------------------------------------

# while loop
count <- 0

while (count < 5) {
  print("Hi!")
  count <- count + 1
}

####################################################################

# function
# input -> f() -> output

x <- c(10, 25, 50, 100)

sum(x)
mean(x)
sd(x)

-------------------------------------------------------------------

# create our first function

greating <- function() {
  print("Hello World!")
}
greating()

#------

greeting_name <- function(name) {
  print(paste("Hello!", name))
}
greeting_name("Folk")
greeting_name("Anna")
greeting_name("York")

#------

func <- function(){
  greating()
  greeting_name("Toy")
}
func()

-------------------------------------------------------------------

greeting <- function(name = "Toy") { 
  print(paste("Hi!", name)) 
}

greeting()


greeting <- function(name = "Toy", 
                     age = 25) { 
  print(paste("Hi!", name))
  print(paste("Age:", age))
}

greeting()

greeting("David", 18)
greeting(18, "David")

greeting(name="David", age=18)
greeting(age=18, name="David")

-------------------------------------------------------------------

# Function Kata

# add_two_nums() function
add_two_nums <- function(val1, val2) {
  return(val1 + val2)
}

# หรือ
add_two_nums <- function(val1, val2) {
  val1 + val2
}

add_two_nums(10, 150)


# cube() function
cube <- function(base, power=3) {
  return(base ** power)
}
cube(5, power=3)
cube(5, power=4)


# count_ball() function
balls <- c("red", "red", "blue", "green",
           "green", "green", "green", "red")
balls

count_ball <- function(balls, color) {
  sum(balls == color)
}
count_ball(balls, "red")

-------------------------------------------------------------------

data()
USArrests

####################################################################


nrow(USArrests)
ncol(USArrests)

head(USArrests)
tail(USArrests)

# แบบ for loop print name
# โดยจะปริ้นออกมาทีละแถวว
for (i in 1:ncol(USArrests)) {
  print(names(USArrests)[i])
}

# แบบใช้ function
names(USArrests)

#------------------------------

# แบบ for loop print name
# โดยจะปริ้นออกมาทีละแถวว
for (i in 1:ncol(USArrests)) {
  print(names(USArrests)[i])
  print(mean(USArrests[[i]]))
}

#------------------------------

cal_mean_by_col <- function(df) {
  for (i in 1:ncol(df)) {
    print(names(df)[i])
    print(mean(df[[i]]))
  }
}

cal_mean_by_col(USArrests)
cal_mean_by_col(mtcars)

#------------------------------

# refactor our code for more readability
cal_mean_by_col <- function(df) {
  col_names <- names(df)
  
  # we use [[]] to extract column as vector
  for (i in 1:ncol(df)) {
    avg_col <- mean(df[[i]]) 
    print(paste(col_names[i], ":", avg_col))
  }
}

# test our code with mtcars
cal_mean_by_col(mtcars)

####################################################################


(avg_row <- apply(mtcars, MARGIN=1, mean))

(avg_col <- apply(mtcars, MARGIN=2, mean))

apply(mtcars, MARGIN=2, sum)
apply(mtcars, MARGIN=2, sd)
apply(mtcars, MARGIN=2, median)

####################################################################

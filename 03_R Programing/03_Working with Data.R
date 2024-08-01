# install packages
install.packages(c("readr", 
                   "readxl", 
                   "googlesheets4",
                   "jsonlite",
                   "dplyr",
                   "sqldf",
                   "RSQLite"))

# load library
library(readr)
library(readxl)
library(googlesheets4)
library(jsonlite)
library(dplyr)
library(sqldf)
library(RSQLite)

################################################################################

library(readr)
students <- read_table("data/students.txt")
students

################################################################################

library(readr)
students <- read_csv("data/students.csv")
students

################################################################################

library(readxl)
students1 <- read_excel("data/students.xlsx", sheet=1)
students1 <- read_excel("data/students.xlsx", sheet="Economics")
students1

students2 <- read_excel("data/students.xlsx", sheet=2)
students2 <- read_excel("data/students.xlsx", sheet="Business")
students2

students3 <- read_excel("data/students.xlsx", sheet=3)
students3 <- read_excel("data/students.xlsx", sheet="Data")
students3

#-------------------

result <- list()
for (i in 1:3) {
  result[[i]] <- read_excel("data/students.xlsx", sheet=i)
}
result
result[[1]]
result[[2]]
result[[3]]

################################################################################

library(googlesheets4)

url <- "https://docs.google.com/spreadsheets/d/1HmEh-0AehDDTFQigqHjrbcI0lgeHdxwiBVkLgsxSgek"

gs4_deauth()

df <- read_sheet(url, sheet="student")
df

################################################################################

library(jsonlite)
data <- fromJSON("data/blackpink.json")
data$name
data$id
data


library(jsonlite)
data <- data.frame(fromJSON("data/blackpink.json"))
data$name
data$id
data

################################################################################

# read excel file
library(readxl)
(econ <- read_excel("data/students.xlsx", sheet=1))
(business <- read_excel("data/students.xlsx", sheet=2))
(data <- read_excel("data/students.xlsx", sheet=3))

## bind_rows == SQL UNION ALL
library(dplyr)
bind_rows(econ, business, data)

# ถ้าจำนวน dataframe เยอะกว่านี้
list_df <- list(econ, business, data)
(bind_rows(list_df))

################################################################################

# bind_cols() != JOIN

df1 <- data.frame(
  id = 1:5,
  name = c("John", "Marry", "Anna",
           "David", "Lisa")
)

df2 <- data.frame(
  id = 1:5,
  city = c(rep("BKK", 3), rep("LONDON", 2)),
  country = c(rep("TH", 3), rep("UK", 2))
)

bind_cols(df1, df2)

bind_cols(df2, df1)

################################################################################

# LEFT JOIN

df1 <- data.frame(
  id = 1:5,
  name = c("John", "Marry", "Anna",
           "David", "Lisa")
)

df2 <- data.frame(
  id = 1:5,
  city = c(rep("BKK", 3), rep("LONDON", 2)),
  country = c(rep("TH", 3), rep("UK", 2))
)

left_join(df1, df2, by="id")

################################################################################


# load library sqldf
library(sqldf)
library(readr) # for read_csv

school <- read_csv("data/school.csv")

sqldf("select * from school;")

sqldf("select avg(student), sum(student) from school;")

sqldf("
	select 
		school_id, 
		school_name, 
		country 
	from school;
		")

sql_query <- "select * from school where country = 'USA';"
usa_school <- sqldf(sql_query)
usa_school 


################################################################################

# load library
library(RSQLite)

# connect to SQLite database (.db file)
# 1. open connection
conn <- dbConnect(SQLite(), "chinook.db")
conn

# 2. get data
dbListTables(conn) # List table ทั้งหมด ใน database นี้
dbListFields(conn, "customers") # จงเข้าไปดูใน db-conn, search หา customer

df <- dbGetQuery(conn, "select * from customers where country = 'USA'")
df2 <- dbGetQuery(conn, "select * from customers where country = 'United Kingdom'")

# 3. close connection
dbDisconnect(conn)
# ถ้าพยายามดึงข้อมูลจาก conn หลังจาก close แล้วจะขึ้น error -- ต้อง connect ใหม่

################################################################################

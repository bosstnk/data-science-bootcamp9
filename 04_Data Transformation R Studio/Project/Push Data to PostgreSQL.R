## connect to PostgreSQL server
library(RPostgreSQL)
library(tidyverse)

## create connection
con <- dbConnect(
  PostgreSQL(),
  host = "floppy.db.elephantsql.com",
  dbname = "zksmmgsd",
  user = "zksmmgsd",
  password = "o1DGbiCnNAwJ4EJhCSowxtYccfLv-eJu",
  port = 5432
)

## db List Tables
dbListTables(con)

## Create Table
customers <- tribble(
  ~customer_id, ~customer_name, ~customer_age, ~customer_gender, ~customer_email,
  1, 'Amiri', 25, 'Female','amiri@gmail.com',
  2, 'Akash', 30, 'Male','akash@gmail.com',
  3, 'Colter', 20, 'Male', 'colter@gmail.com',
  4, 'James', 35, 'Male', 'james@gmail.com',
  5, 'Jane', 22, 'Female', 'jane@gmail.com',
  6, 'Jack', 30, 'Male', 'jack@gmail.com',
  7, 'Jill', 28, 'Female', 'jill@gmail.com',
  8, 'Joe', 29, 'Male', 'joe@gmail.com',
  9, 'Judy', 40, 'Female', 'judy@gmail.com',
  10, 'Loyal', 25, 'Male', 'loyal@gmail.com',
  11, 'Mary', 27, 'Female', 'mary@gmail.com',
  12, 'Mike', 34, 'Male', 'mike@gmail.com'
)
orders <- tribble(
  ~order_id, ~customer_name, ~order_date, ~menu_id,
  1, 'Amiri', '2023-01-01', 1,
  2, 'Akash', '2023-01-01', 2,
  3, 'James', '2023-01-02', 2,
  4, 'Jack', '2023-01-02', 1,
  5, 'Colter', '2023-01-02', 3,
  6, 'Jill', '2023-01-03', 1,
  7, 'Joe', '2023-01-03', 4,
  8, 'Jane', '2023-01-03', 4,
  9, 'Judy', '2023-01-03', 1,
  10, 'Loyal', '2023-01-03', 3,
  11, 'Jack', '2023-01-03', 3,
  12, 'Mike', '2023-01-04', 2,
  13, 'Mary', '2023-01-04', 1
)
menus <- tribble(
  ~menu_id, ~menu_name, ~menu_price,
  1, 'Hawaiian', 10.35,
  2, 'Cheese', 11.5,
  3, 'Pepperoni', 10.75,
  4, 'Meat Lovers', 12.00
)

## write table to database
dbWriteTable(con, "customers", customers, row.names = FALSE)
dbWriteTable(con, "orders", orders, row.names = FALSE)
dbWriteTable(con, "menus", menus, row.names = FALSE)

## db List Tables/Fields
dbListTables(con)
dbListFields(con, "customers")
dbListFields(con, "orders")
dbListFields(con, "menus")

## remove table if you want can use this code
dbRemoveTable(con,"customers")
dbRemoveTable(con,"orders")
dbRemoveTable(con,"menus")

## get data
## Question1 : Total pizza sales
df <- dbGetQuery(con,"SELECT menu_name, SUM(menu_price)
											FROM orders
											JOIN menus
											ON orders.menu_id = menus.menu_id
											GROUP BY menu_name
											ORDER BY SUM(menu_price) DESC")
print(df)

## Question2 : Who has the most order?
Best_Seller <- dbGetQuery(con, "SELECT orders.customer_name, sum(menu_price) AS total_sale
                 FROM orders
                 JOIN menus
                 ON orders.menu_id = menus.menu_id
                 GROUP BY 1
                 ORDER BY 2 DESC")
print(Best_Seller)

## close connection
dbDisconnect(con)

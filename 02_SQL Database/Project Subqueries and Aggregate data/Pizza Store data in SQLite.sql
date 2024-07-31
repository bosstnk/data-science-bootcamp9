-- table customers
CREATE TABLE customers(
  customerId int,
  firstname text,
  lastname text,
  email text,
  birth_date DATE
);
  
INSERT INTO customers values
  (1, 'John', 'Smith', 'John.s@example.com','2000-12-05'),
  (2, 'Kim', 'Lee', 'Kim.l@example.com', '2004-05-17'),
  (3, 'Romeo', 'Evans', 'Romeo.e@example.com','2002-01-10'),
  (4, 'James', 'Thomas', 'James.t@example.com','1999-04-07'),
  (5, 'Robert', 'Brown', 'Robert.b@example.com','1995-02-12');

-- table menu
CREATE TABLE menus(
  menuId int,
  menuName text,
  price real
);

INSERT INTO menus values
  (1, 'Pepperoni Pizza', 14),
  (2, 'Hawaiian Pizza', 15),
  (3, 'Cheese Pizza', 12),
  (4, 'Spaghetti', 9),
  (5, 'French Fries', 5),
  (6, 'Coke', 3);

-- table order
CREATE TABLE orders(
  orderId int,
  customerId int,
  menuId int,
  orderDate DATE
);

INSERT INTO orders values
  (1, 1, 1, '2024-01-05'),
  (2, 1, 6, '2024-01-05'),
  (3, 2, 4, '2024-01-05'),
  (4, 5, 3, '2024-01-05'),
  (5, 5, 4, '2024-01-05'),
  (6, 5, 6, '2024-01-05'),
  (7, 3, 2, '2024-01-07'),
  (8, 3, 5, '2024-01-07'),
  (9, 4, 5, '2024-01-08'),
  (10, 4, 6, '2024-01-08'),
  (11, 1, 2, '2024-01-08'),
  (12, 3, 4, '2024-01-10'),
  (13, 3, 6, '2024-01-10'),
  (14, 5, 2, '2024-01-11'),
  (15, 4, 2, '2024-01-11');
  
.mode box -- Make result show in the table

Select * from customers;
select * from orders;
select * from menus;

-- Determining the customer who made the most purchases and calculating their total spending.

with top_spending_customer as (
  select
    customerId,
    count(*) AS count_order,
    sum(menus.price) AS total_spending
    from orders, menus
    where menus.menuId = orders.menuId
    group by 1
)
  
select
  customers.firstname,
  customers.lastname,
  tsc.count_order,
  tsc.total_spending
  from customers, top_spending_customer tsc
  where tsc.customerId = customers.customerId 
order by 4 desc
limit 1 ;

-- Determining the most popular menu and the number of times it was ordered.
select 
  menus.menuName, 
  count(*) AS count_order 
  from orders 
  join menus on orders.menuId = menus.menuId
  group by 1
  order by 2 desc;

-- Pattern Machting LIKE
SELECT firstname, lastname, country, email FROM customers
WHERE email LIKE '%@gmail.com'

SELECT firstname, lastname, country, email FROM customers
WHERE email LIKE '%@gmail.com' AND country = 'USA';

-- Find customers with phone number include 99
SELECT firstname, lastname, country, phone FROM customers
WHERE phone LIKE '%99%';

-- Pattern Machting NOT LIKE
SELECT firstname, lastname, country, email FROM customers
WHERE email NOT LIKE '%@gmail.com'

SELECT firstname, lastname, country, email FROM customers
WHERE NOT(email LIKE '%@gmail.com' AND country = 'USA');

-- Find customers firstname like 'John' etc.
SELECT * FROM customers
WHERE firstname LIKE 'J_hn';

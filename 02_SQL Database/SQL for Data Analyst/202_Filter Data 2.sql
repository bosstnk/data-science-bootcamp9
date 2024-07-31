-- OR
SELECT * FROM customers
WHERE country = 'USA' OR country = 'Canada' OR country = 'Belgium';

-- IN operator
SELECT * FROM customers
WHERE country IN ('USA', 'Canada', 'Belgium');

-- IN operator
SELECT * FROM customers
WHERE country NOT IN ('USA', 'Canada', 'Belgium');

-- BETWEEN AND
SELECT * FROM customers
WHERE customerID BETWEEN 5 AND 10; -- inclusive

--ALTERNATIVE OF BETWEEN AND
SELECT * FROM customers 
WHERE customerID >= 5 AND customerID <= 10;

-- BETWEEN AND with DATE TIME column
SELECT * FROM invoices
WHERE invoicedate BETWEEN '2009-01-01 00:00:00' AND '2009-01-31 20:00:00';

-- NULL
SELECT * FROM customers
WHERE company IS NULL;

-- NOT NULL
SELECT * FROM customers
WHERE company IS NOT NULL;

-- Don't use
/*
SELECT * FROM customer
WHERE company = NULL;
*/

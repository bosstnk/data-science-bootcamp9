SELECT * FROM customers
WHERE firstname = 'John';

SELECT * FROM customers
WHERE country = 'USA';

SELECT * FROM customers
WHERE LOWER(country) = 'usa';

SELECT * FROM customers
WHERE country = 'USA' AND state = 'CA';

SELECT * FROM customers
WHERE country = 'USA' OR country = 'Canada';

SELECT * FROM customers
WHERE NOT (country = 'USA' OR country = 'Canada');

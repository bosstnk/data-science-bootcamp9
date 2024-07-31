--show unique value 
SELECT DISTINCT country FROM customers;

--count unique value
SELECT COUNT(DISTINCT country) FROM customers;

--compare COUNT vs COUNT DISTINCT
SELECT COUNT(DISTINCT country), COUNT(*) FROM customers;

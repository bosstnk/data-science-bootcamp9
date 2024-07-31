-- SELECT FROM
SELECT * FROM customers;

SELECT 
	firstname, 
	lastname, 
	company 
FROM customers;

-------------------------------------------------------

-- Create new column and AS

SELECT 
	firstname, 
	lastname, 
	firstname || ' ' || lastname AS SingleQuote,
	firstname || " " || lastname AS DoubleQuote,
	100,
	"DataRockie"
FROM customers;

SELECT 
	firstname, 
	lastname, 
	firstname || ' ' || lastname AS "Single Quote",
	firstname || " " || lastname AS "Double Quote",
	100,
	"DataRockie"
FROM customers;

SELECT
	invoicedate,
	billingaddress,
	total,
	total + (total * 0.07) AS total_incl_vat,
	(100+2)*5 AS answer
FROM invoices

-------------------------------------------------------

-- ROUND
SELECT
	invoicedate,
	billingaddress,
	total,
	ROUND(total + (total * 0.07), 2) AS total_incl_vat,
	(100+2)*5 AS answer
FROM invoices

-------------------------------------------------------

-- STRFTIME - Formatting Datetime
SELECT
	invoicedate,
	STRFTIME("%Y", invoicedate) AS year
	STRFTIME("%m", invoicedate) AS month
	STRFTIME("%d", invoicedate) AS day
	STRFTIME("%Y-%m", invoicedate) AS monthid -- year combine with month
FROM invoices
WHERE monthid = "2009-10"

-------------------------------------------------------

-- WHERE - filter table
SELECT firstname, country, email
FROM customers
WHERE LOWER(country) = "UNITED KINGDOM";

SELECT 
	name, 
	composer, 
	bytes/(1024*1024) AS mb
FROM tracks
WHERE bytes/(1024*1024) >= 8 AND composer LIKE 'S%';


-------------------------------------------------------

-- OR and IN operator
SELECT firstname, country, email
FROM customers
WHERE country = "USA" OR country = "Brazil" OR country = "Belgium";

SELECT firstname, country, email
FROM customers
WHERE country IN ("USA", "Brazil", "Belgium");

-------------------------------------------------------

-- IS NOT
SELECT 
	name, 
	composer, 
	bytes/(1024*1024) AS mb
FROM tracks
WHERE composer IS NOT NULL;

-------------------------------------------------------

-- COALESCE — Replace NULL
SELECT
	company,
	COALESCE(company, "B2C") AS clean_company
FROM customers;

-------------------------------------------------------

-- Case When — Create new column by condition.
SELECT 
	company, 
  COALESCE(company, "B2C") AS clean_company,
  CASE 
    WHEN company IS NULL THEN "B2C" 
    ELSE "B2B" 
  END AS segment
FROM customers;

-------------------------------------------------------

-- BETWEEN
SELECT 
	name, 
	composer, 
	bytes/(1024*1024) AS mb
FROM tracks
WHERE bytes/(1024*1024) BETWEEN 7 AND 10;

-------------------------------------------------------

-- Create table from SELECT.
CREATE TABLE eu_customers AS
	SELECT firstname, country, email
	FROM customers
	WHERE country IN ("Belgium", "France", "Italy");

-------------------------------------------------------

-- Drop Table
DROP TABLE eu_customers;

-------------------------------------------------------

-- LIMIT — Query top rows
SELECT 
	name, 
	composer, 
	bytes/(1024*1024) AS mb
FROM tracks
LIMIT 5

-------------------------------------------------------

-- Aggregate function
SELECT
	COUNT(*),
	COUNT(name),
	COUNT(composer)
FROM tracks;

-------------------------------------------------------

-- GROUP BY with CASE WHEN
SELECT 
  CASE 
    WHEN company IS NULL THEN "B2C" 
    ELSE "B2B" 
  END AS segment,
	country
	COUNT(*) AS num_customers
FROM customers
GROUP BY 1, 2;

-------------------------------------------------------

-- HAVING — Filter after GROUP BY and WHERE.

SELECT 
  CASE 
    WHEN company IS NULL THEN "B2C" 
    ELSE "B2B" 
  END AS segment,
	country
	COUNT(*) AS num_customers
FROM customers
GROUP BY 1, 2
HAVING country IN ("Belgium", "France", "Italy");

SELECT 
  CASE 
    WHEN company IS NULL THEN "B2C" 
    ELSE "B2B" 
  END AS segment,
	country
	COUNT(*) AS num_customers
FROM customers
WHERE country IN ("Belgium", "France", "Italy")
GROUP BY 1, 2;

SELECT 
    CASE 
    	WHEN company IS NULL THEN "B2C" 
    	ELSE "B2B" 
    END AS segment,
    country,
    COUNT(*) AS num_customers
FROM customers
WHERE country IN ("Belgium", "France", "Italy")
GROUP BY 1,2
HAVING num_customers > 1

-------------------------------------------------------

-- ORDER BY — Sort data
SELECT
	name,
	ROUND(milliseconds / 60000.0, 2) AS minute
FROM tracks
ORDER BY minute DESC
LIMIT 5

-------------------------------------------------------

-- JOIN / INNER JOIN

SELECT *
FROM artists
JOIN albums
ON artists.artistid = albums.artistid;

SELECT *
FROM artists AS ar
INNER JOIN albums AS al
ON ar.artistid = al.artistid;

SELECT 
	ar.name AS artist_name,
	al.title AS album_name,
	tr.name AS track_name,
	ge.name AS genre,
	tr.milliseconds,
	tr.bytes,
	tr.unitprices
FROM artists AS ar
INNER JOIN albums AS al
	ON ar.artistid = al.artistid -- PK = FK
INNER JOIN tracks AS tr
	ON tr.albumid = al.albumid
INNER JOIN genres AS ge
	ON ge.genreid = tr.genreid;

-------------------------------------------------------

-- Example: Aggregate + JOIN 4 tables
SELECT 
	ge,name,
	COUNT(*) AS count_tracks,
	AVG(milliseconds) AS avg_milliseconds
FROM artists AS ar
	INNER JOIN albums AS al ON ar.artistid = al.artistid -- PK = FK
	INNER JOIN tracks AS tr ON tr.albumid = al.albumid
	INNER JOIN genres AS ge ON ge.genreid = tr.genreid
GROUP BY 1
ORDER BY 3 DESC
LIMIT 5;

-------------------------------------------------------

-- CREATE VIEW and DROP VIEW — Virtual table

CREATE VIEW genre_stats AS
	SELECT 
		ge,name,
		COUNT(*) AS count_tracks,
		AVG(milliseconds) AS avg_milliseconds
	FROM artists AS ar
		INNER JOIN albums AS al ON ar.artistid = al.artistid -- PK = FK
		INNER JOIN tracks AS tr ON tr.albumid = al.albumid
		INNER JOIN genres AS ge ON ge.genreid = tr.genreid
	GROUP BY 1
	ORDER BY 3 DESC
	LIMIT 5;

SELECT * FROM genre_stats ;

DROP VIEW genre_stats;

-------------------------------------------------------

-- Subqueries and WITH — SELECT within SELECT 

-- subqueries
SELECT firstname, country 
FROM (SELECT * FROM customers) AS sub
WHERE country = 'United Kingdom';

-- WITH : common table expression
WITH sub AS (
	SELECT * FROM customers
)
SELECT firstname, country 
FROM sub
WHERE country = 'United Kingdom';

-------------------------------------------------------

-- Example: Subqueries and apply SQL knowledge

-- basic query
SELECT
	firstname,
	lastname,
	email,
  COUNT(*) count_order -- อยากรู้ว่าลูกค้าแต่ละคนสั่งไปแล้วกี่ order
FROM customers c
JOIN invoices i ON c.customerid = i.customerid
WHERE c.country = 'USA' AND STRFTIME("%Y-%m",i.invoicedate) = "2009-10"
GROUP BY 1,2,3;

-- With Clause
WITH usa_customers AS (
	SELECT * FROM customers
	WHERE country = 'USA'
), invoice_2009 AS (
	SELECT * FROM invoices
	WHERE STRFTIME("%Y-%m",invoicedate) = "2009-10"
)

SELECT firstname, lastname, email, COUNT(*)
FROM usa_customers t1
JOIN invoice_2009  t2
ON t1.customerid = t2.customerid
GROUP BY 1,2,3;

-- Standard Subqueries
SELECT firstname, lastname, email, COUNT(*)
FROM  (
	SELECT * FROM customers
	WHERE country = 'USA'
) AS t1
JOIN (
	SELECT * FROM invoices
	WHERE STRFTIME("%Y-%m",invoicedate) = "2009-10"
) AS t2
ON t1.customerid = t2.customerid
GROUP BY 1,2,3;

-------------------------------------------------------

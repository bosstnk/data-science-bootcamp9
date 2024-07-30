-- STRFTIME is a specific function for SQLite
SELECT 
	invoicedate,
	STRFTIME('%Y', invoicedate) AS year,
	STRFTIME('%m', invoicedate) AS month,
	STRFTIME('%d', invoicedate) AS day,
  STRFTIME('%Y-%m', invoicedate) AS year_month
FROM invoices;

--CAST เปลี่ยน Data type
SELECT 
	invoicedate,
	CAST(STRFTIME('%Y', invoicedate) As INT) AS year,
FROM invoices
WHERE year = 2010;

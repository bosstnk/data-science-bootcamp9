SELECT 
  firstname, 
	lastname,
  firstname || ' ' || lastname AS fullnamme,
  LOWER(firstname) || '@company.com' AS email
	firstname || SUBSTR(lastname,1,1) || '@company.com' AS email_new
FROM customers;

-- round ประมาณค่าต่อเมื่อผลลัพธ์มีทศนิยทจึงใส่ .0
SELECT 
	name, 
	round(Milliseconds / 60000.0, 2) AS minute, 
	round(Bytes / (1024*1024.0), 2) AS mb
FROM tracks;

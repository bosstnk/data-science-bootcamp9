-- replace NULL with desired values
SELECT 
  company,
  COALESCE(company, 'End Customer') AS 'Clean Company'
FROM customers;

-- replace NULL with desired values by Case When
SELECT 
  company,
  CASE WHEN company IS NULL THEN 'End Customer'
       ELSE 'Corporate'
  END AS segment
FROM customers;

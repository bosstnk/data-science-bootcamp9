-- CASE is like IF-ELSE in Google Sheets
-- WHEN คือ เงื่อนไข (Condition)
-- THEN คือ ผลลัพธ์ (Value)
-- ELSE คือ เงื่อนไขอื่นๆ นอกเหนือจากที่กำหนด

SELECT 
  company,
  CASE
    WHEN company IS NOT NULL THEN 'Corperate'
	ELSE 'End Customer'
  END AS segment
FROM customers;

-- Case มากกว่า 1 เงื่อนไข
SELECT 
  country,
  CASE
    WHEN country IN ('Canada', 'USA') THEN 'America'
    WHEN country IN ('Belgium', 'France', 'Italy') THEN 'Europe'
    ELSE 'Other'
  END AS region
FROM customers

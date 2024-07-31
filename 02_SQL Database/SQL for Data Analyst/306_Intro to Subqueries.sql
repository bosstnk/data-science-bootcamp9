--Find the longest song.
--NOT subqueries in WHERE clause
SELECT MAX(milliseconds) from tracks;
SELECT * from tracks WHERE milliseconds >= 5286953;

--subqueries in WHERE clause
SELECT * FROM tracks 
WHERE milliseconds = (SELECT max(milliseconds) FROM tracks);

---------------------------------------------------------

--Count the number of songs that are longer than the average length of all the songs.
--NOT subqueries in WHERE clause
SELECT AVG(milliseconds) from tracks;
SELECT COUNT(*) from tracks WHERE milliseconds >= 393599.2121039109;

--subqueries in WHERE clause
SELECT COUNT(*) FROM tracks 
WHERE milliseconds >= (SELECT AVG(milliseconds) FROM tracks);

---------------------------------------------------------

--Show the first name, last name, and email of customers located in the USA.
--NOT subqueries example in FROM clause
SELECT firstname, lastname, email FROM customers
WHERE country = 'USA'

--subqueries example in FROM clause
SELECT firstname, lastname, email
FROM (SELECT * FROM customers WHERE country = 'USA');

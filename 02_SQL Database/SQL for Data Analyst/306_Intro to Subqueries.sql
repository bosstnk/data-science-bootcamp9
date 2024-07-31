--Find the longest song.
--NOT subqueries in WHERE clause
SELECT MAX(milliseconds) from tracks;
SELECT * from tracks WHERE milliseconds >= 5286953;

--subqueries in WHERE clause
SELECT * FROM tracks 
WHERE milliseconds = (SELECT max(milliseconds) FROM tracks);


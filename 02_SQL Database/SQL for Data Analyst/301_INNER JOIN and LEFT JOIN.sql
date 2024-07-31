-- create two tables
CREATE TABLE book_shop (
	id INT,
  name TEXT,
  release_year INT
);
  
CREATE TABLE favourite_book (
  id INT, 
  author TEXT,
  reviews REAL
);

INSERT INTO book_shop VALUES
  (1, 'Think Like A Freak', 2014),
  (2, 'Ultralearning', 2019),
  (3, 'Blue Ocean Strategy', 2015),
  (4, 'The Power of Habit', 2012),
  (5, 'Outliers', 2008);

INSERT INTO favourite_book VALUES
  (1, 'Steven D. Levitt, Stephen J. Dubner', 1904),
  (4, 'Charles Duhigg', 12007),
  (5, 'Malcolm Gladwell', 12063);

SELECT * from book_shop;
SELECT * from favourite_book;

---------------------------------------------------------

-- INNER JOIN
SELECT * FROM book_shop A
INNER JOIN favourite_book B ON A.id = B.id; 

-- LEFT JOIN
SELECT * FROM book_shop A
LEFT JOIN favourite_book B ON A.id = B.id;

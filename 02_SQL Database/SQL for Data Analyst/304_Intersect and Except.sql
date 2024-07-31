-- From book database (301_INER JOIN and LEFT JOIN) 
-- intersect = which books are in both tables
SELECT id FROM book_shop
INTERSECT
SELECT id FROM favourite_book;

-- except = which books are in the left table, but not in the right tables
SELECT id FROM book_shop
EXCEPT
SELECT id FROM favourite_book;

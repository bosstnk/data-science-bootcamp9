-- create a new employee table
CREATE TABLE employee (
    id INT,
    name TEXT,
    level TEXT,
    manager_id INT 
);

INSERT INTO employee VALUES 
    (1, 'David', 'CEO', NULL),
    (2, 'John', 'SVP', 1),
    (3, 'Mary', 'VP', 2),
    (4, 'Adam', 'VP', 2),
    (5, 'Scott', 'Manager', 3),
    (6, 'Louise', 'Manager', 3),
    (7, 'Kevin', 'Manager', 4),
    (8, 'Takeshi', 'Manager', 4),
    (9, 'Joe', 'AM', 6),
    (10, 'Anna', 'AM', 7);

---------------------------------------------------------

--SELF JOIN for a table that has a relationship with itself.
SELECT 
	t1.id, 
    t1.name AS employeeName, 
    t1.level AS employeeLevel,
    t2.name AS managerName,
    t2.level AS managerLevel,
    t1.name || ' report to ' || t2.name AS comment -- make it easy to read
FROM employee t1, employee t2 --main point ตั้งชื่อให้ table เป็น 2 ชื่อแล้วจึง join มัน
WHERE t1.manager_id = t2.id;

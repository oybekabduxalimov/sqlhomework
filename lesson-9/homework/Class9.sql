CREATE TABLE Employees
(
    EmployeeID  INTEGER PRIMARY KEY,
    ManagerID   INTEGER NULL,
    JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
    (1001, NULL, 'President'),
    (2002, 1001, 'Director'),
    (3003, 1001, 'Office Manager'),
    (4004, 2002, 'Engineer'),
    (5005, 2002, 'Engineer'),
    (6006, 2002, 'Engineer');


--task1
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT EmployeeID, ManagerID, JobTitle, 0 AS Depth
    FROM Employees
    WHERE ManagerID IS NULL
    
    UNION ALL
    
    SELECT e.EmployeeID, e.ManagerID, e.JobTitle, eh.Depth + 1
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT EmployeeID, ManagerID, JobTitle, Depth
FROM EmployeeHierarchy
ORDER BY EmployeeID;


--task2
WITH RECURSIVE Factorials AS (
    SELECT 1 AS Num, CAST(1 AS BIGINT) AS Factorial
    
    UNION ALL
    SELECT f.Num + 1, f.Factorial * (f.Num + 1)
    FROM Factorials f
    WHERE f.Num < 10
)
SELECT Num, Factorial
FROM Factorials
ORDER BY Num;


--task3
WITH RECURSIVE Fibonacci AS (
    SELECT 1 AS n, 1 AS Fibonacci_Number
    UNION ALL
    SELECT 2 AS n, 1 AS Fibonacci_Number
    
    UNION ALL
    SELECT f.n + 1, 
           (SELECT Fibonacci_Number FROM Fibonacci WHERE n = f.n) + 
           (SELECT Fibonacci_Number FROM Fibonacci WHERE n = f.n - 1)
    FROM Fibonacci f
    WHERE f.n < 10
)
SELECT n, Fibonacci_Number
FROM Fibonacci
ORDER BY n;
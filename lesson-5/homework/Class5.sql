DROP TABLE IF EXISTS Employees;

CREATE Table Employees(
      EmployeeID INT IDENTITY(1, 1),
      Name VARCHAR(50),
      Department VARCHAR(50),
      Salary Decimal(10, 2),
      HireDate DATE
)

INSERT INTO Employees(Name, Department, Salary, HireDate)
VALUES
('Alice Johnson', 'HR', 55000, '2018-06-15'),
('Bob Smith', 'HR', 55000, '2017-09-10'),
('Charlie Brown', 'IT', 55000, '2019-03-05'),
('David Wilson', 'IT', 82000, '2021-07-22'),
('Eve Adams', 'Finance',82000, '2016-11-30'),
('Frank Miller', 'Finance', 78000, '2019-12-25'),
('Grace Lee', 'Marketing', 67000, '2015-05-14'),
('Hank White', 'Marketing', 78000, '2018-10-08'),
('Ivy Green', 'IT', 67000, '2022-01-12'),
('Jack Black', 'HR', 53000, '2020-03-29'),
('Karen Hall', 'Finance', 82000, '2018-08-21'),
('Leo Turner', 'IT', 77000, '2017-04-30'),
('Mona Evans', 'HR', 58000, '2016-12-11'),
('Nathan Scott', 'Marketing', 71000, '2019-06-18'),
('Olivia Young', 'Finance', 97000, '2015-10-07'),
('Peter Parker', 'IT', 88000, '2020-02-22'),
('Quinn Taylor', 'HR', 54000, '2021-05-05'),
('Rachel Carter', 'Marketing', 68000, '2017-11-19'),
('Steve Rogers', 'Finance', 95000, '2014-03-27'),
('Tony Stark', 'IT', 99000, '2013-09-15');

--task1
SELECT *,
        ROW_NUMBER() OVER(ORDER BY Salary) as UniqueNum
FROM Employees;

--task2
SELECT Ranking, Salary, COUNT(*) AS EmployeeCount
FROM (
    SELECT *, RANK() OVER(ORDER BY Salary) AS Ranking 
    FROM Employees
) AS RankedEmployees
GROUP BY Ranking, Salary
HAVING COUNT(*) > 1;

--task3
SELECT * FROM (SELECT *,
        DENSE_RANK() OVER(PARTITION BY Department ORDER BY SALARY DESC) as Ranking
		FROM Employees) AS Tablem
WHERE Ranking <= 2;

--task4
SELECT * FROM(SELECT *,
        DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary ASC) as Ranking
		FROM Employees) AS Tablem2
WHERE Ranking = 1;

--task5
SELECT *,
        SUM(Salary) OVER(Partition BY Department ORDER BY EmployeeID) as RunningTotal
FROM Employees;

--task6
SELECT *,
       SUM(Salary) OVER(Partition BY Department) as DepartmentSUM
FROM Employees;

--task7
SELECT *,
       CAST(AVG(Salary) OVER(Partition BY Department) AS INT) as DepartmentAVG
FROM Employees;

--task8
SELECT *,
        CAST(Salary - AVG(Salary) OVER(Partition By Department) AS INT) as SALDIFFAVG
FROM Employees;

--task9
SELECT *,
        CAST((AVG(Salary) OVER(ORDER BY SALARY ROWS BETWEEN 1 preceding and 1 following)) as INT) as MovingAVG
FROM Employees;

--task10
SELECT SUM(Salary) FROM(
             SELECT *,
                     DENSE_RANK() OVER(ORDER BY HireDate DESC) as HiringRank
                     FROM Employees) AS Tablim
WHERE HiringRank <= 3;

--task11
SELECT *,
        CAST(AVG(Salary) OVER(ORDER BY SALARY) as INT) as RunningAVG
FROM Employees;

--task12
SELECT *,
        MAX(Salary) OVER(ORDER BY Salary ROWS BETWEEN 2 preceding and 2 following) AS BEFOREAFTERMAX2
FROM Employees;

--task13
SELECT *,
       CAST(100 * Salary/SUM(Salary) OVER(PARTITION By Department) as decimal(10, 2)) as ContofEmp
FROM Employees;
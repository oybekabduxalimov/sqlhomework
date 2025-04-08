--task1
DROP table Employees;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    Salary INT
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary) VALUES
(1, 'Alice', 'HR', 5000),
(2, 'Bob', 'IT', 7000),
(3, 'Charlie', 'Sales', 6000),
(4, 'David', 'HR', 5500),
(5, 'Emma', 'IT', 7200);

SELECT * into #Employees1
from Employees;

UPDATE #Employees1
SET Department = 
    CASE 
        WHEN Department = 'HR' THEN 'IT'
        WHEN Department = 'IT' THEN 'Sales'
        WHEN Department = 'Sales' THEN 'HR'
        ELSE Department -- Keep the existing department if no condition matches
    END;



select * from #Employees1;


--task2
-- Table 1: Orders
DROP TABLE IF exists Orders_1B;
CREATE TABLE Orders_1B (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT
);

INSERT INTO Orders_1B (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);

-- Table 2: Orders_DB2 (Backup System)
CREATE TABLE Orders_DB2 (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT
);

INSERT INTO Orders_DB2 (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);


Declare @MissingOrders Table(
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT
)

INSERT INTO @MissingOrders
Select * From Orders_1B
Where Orders_1B.OrderID not in (select OrderID from Orders_DB2)

Select * from @MissingOrders;

--task3
CREATE VIEW vw_MonthlyWorkSummary AS
SELECT EmployeeID, EmployeeName, Department, SUM(HoursWorked) AS TotalHoursWorked
FROM WorkLog
GROUP BY EmployeeID, EmployeeName, Department

UNION ALL
SELECT NULL AS EmployeeID, NULL AS EmployeeName, Department, SUM(HoursWorked) AS TotalHoursDepartment
FROM WorkLog
GROUP BY Department

UNION ALL
SELECT NULL AS EmployeeID, NULL AS EmployeeName, Department, AVG(HoursWorked) AS AvgHoursDepartment
FROM WorkLog
GROUP BY Department;


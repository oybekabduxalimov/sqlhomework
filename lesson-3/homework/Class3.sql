DROP TABLE Employees;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

DROP TABLE Orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);
DROP TABLE Products;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate) VALUES
(1, 'John', 'Doe', 'IT', 75000.00, '2020-03-15'),
(2, 'Jane', 'Smith', 'HR', 65000.00, '2019-07-22'),
(3, 'Michael', 'Brown', 'Finance', 72000.00, '2018-09-10'),
(4, 'Emily', 'Johnson', 'Marketing', 68000.00, '2021-01-05'),
(5, 'Daniel', 'Williams', 'IT', 80000.00, '2017-11-30'),
(6, 'Sarah', 'Davis', 'Sales', 55000.00, '2022-05-18'),
(7, 'David', 'Wilson', 'Finance', 78000.00, '2016-06-21'),
(8, 'Laura', 'Martinez', 'HR', 62000.00, '2020-12-10'),
(9, 'James', 'Anderson', 'Marketing', 71000.00, '2019-03-25'),
(10, 'Sophia', 'Thomas', 'IT', 79000.00, '2023-02-14');

INSERT INTO Orders (OrderID, CustomerName, OrderDate, TotalAmount, Status) VALUES
(101, 'Alice Johnson', '2024-03-01', 150.75, 'Shipped'),
(102, 'Bob Smith', '2024-03-02', 200.00, 'Pending'),
(103, 'Charlie Brown', '2024-03-03', 75.50, 'Delivered'),
(104, 'David Wilson', '2024-03-04', 180.20, 'Cancelled'),
(105, 'Emma Davis', '2024-03-05', 95.00, 'Shipped'),
(106, 'Frank Miller', '2024-03-06', 250.30, 'Pending'),
(107, 'Grace Hall', '2024-03-07', 120.99, 'Delivered'),
(108, 'Henry Adams', '2024-03-08', 300.40, 'Shipped'),
(109, 'Ivy Carter', '2024-03-09', 175.75, 'Pending'),
(110, 'Jack Turner', '2024-03-10', 400.60, 'Delivered');


INSERT INTO Products (ProductID, ProductName, Category, Price, Stock) VALUES
(201, 'Laptop', 'Electronics', 1200.99, 1),
(202, 'Smartphone', 'Electronics', 899.99, 30),
(203, 'Desk Chair', 'Furniture', 150.75, 25),
(204, 'Bluetooth Speaker', 'Electronics', 79.99, 50),
(205, 'Office Desk', 'Furniture', 250.50, 10),
(206, 'LED Monitor', 'Electronics', 199.99, 2),
(207, 'Backpack', 'Accessories', 45.99, 100),
(208, 'Wireless Mouse', 'Accessories', 29.99, 8),
(209, 'Coffee Maker', 'Appliances', 59.99, 40),
(210, 'Yoga Mat', 'Fitness', 35.99, 60);

--task1
SELECT * FROM Employees;

--task1.1
SELECT TOP 10 PERCENT *
FROM Employees
ORDER BY Salary DESC;

--task1.2
SELECT Department, AVG(Salary) as AverageSalary
FROM Employees
GROUP BY Department;

--task1.3
SELECT EmployeeID, FirstName, Salary,
       IIF(Salary >= 80000, 'High', 
	       IIF(Salary >= 50000 and Salary < 80000, 'Medium', 'Low')) AS Classify
FROM Employees;

--task1.4
SELECT Department, AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Department
ORDER BY AverageSalary DESC;

--task1.5
SELECT Department, AVG(Salary) as AvarageSalary
FROM Employees
GROUP BY Department
ORDER BY AvarageSalary DESC
OFFSET 2 ROW FETCH NEXT 5 ROWS ONLY;

--task2
SELECT * FROM Orders;

--task2.1
SELECT OrderID, CustomerName, OrderDate
FROM Orders
WHERE OrderDate BETWEEN '2024-03-01' and '2024-03-05';

--task2.2
SELECT [Status],
      IIF([Status] = 'Shipped', 'Completed', IIF([Status] = 'Pending', 'Pending', 'Cancelled')) as OrderStatus
FROM Orders

--task2.3
SELECT [Status], 
       COUNT(*) AS TotalOrders,  
       SUM(TotalAmount) AS MoneyAmount  
FROM Orders  
GROUP BY [Status];

--task2.4
SELECT [Status],
       COUNT(*) AS TotalOrders,
	   SUM(TotalAmount) AS MoneyAmount
FROM Orders
GROUP BY [Status]
HAVING SUM(TotalAmount) > 500;

--task2.5
SELECT [Status],
       SUM(TotalAmount) AS MoneyAmount
FROM Orders
GROUP BY [Status]
ORDER BY SUM(TotalAmount) DESC;

--task3
SELECT * FROM Products;

--task3.1
SELECT DISTINCT Category
FROM Products;

--task3.2
SELECT Category, MAX(Price) as Expensivest
FROM Products
GROUP BY Category;

--task3.3
SELECT ProductName,
     IIF(Stock > 10, 'In Stock', IIF(Stock > 1, 'Low Stock', 'Out of Stock')) as StockStatus
From Products;

--task3.4
SELECT ProductName, Price
FROM Products
ORDER BY Price DESC
OFFSET 5 ROWS FETCH FIRST 10 ROWS Only;


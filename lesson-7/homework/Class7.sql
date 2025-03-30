DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
    CustomerID INT,
    CustomerName VARCHAR(100)
);
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    OrderID INT ,
    CustomerID INT,
    OrderDate DATE
);
DROP TABLE IF EXISTS OrderDetails;
CREATE TABLE OrderDetails (
    OrderDetailID INT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);
DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

-- Insert Customers (Some Customers Have No Orders)
INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Charlie Davis'),
(4, 'Diana White'),
(5, 'Ethan Harris'),
(6, 'Fiona Brown'),
(7, 'George Clark'),
(8, 'Hannah Lee'),
(9, 'Ian Walker'),
(10, 'Julia Adams');

-- Insert Orders (Some Customers Have No Orders, Some Orders Have NULL Dates)
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1, 1, '2024-03-15'),
(2, 1, NULL),  -- Order with NULL date
(3, 1, '2024-02-10'),
(4, 2, '2024-03-20'),
(5, 2, NULL),  -- Order with NULL date
(6, 6, '2024-03-25'),
(7, NULL, '2024-01-10'),  -- Order without a customer
(8, 6, '2024-02-28'),
(9, 6, '2024-02-28'),
(10, NULL, NULL);  -- Completely NULL order

-- Insert Products (Some Products Have NULL Categories)
INSERT INTO Products (ProductID, ProductName, Category) VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Notebook', 'Stationery'),
(3, 'Smartphone', 'Electronics'),
(4, 'Desk Chair', 'Furniture'),
(5, 'Pen', 'Stationery'),
(6, 'Mouse', 'Electronics'),
(7, 'Headphones', NULL),  -- Product with NULL category
(8, 'Tablet', 'Electronics'),
(9, 'Backpack', 'Accessories'),
(10, 'Marker', NULL);  -- Product with NULL category

-- Insert OrderDetails (Some Orders Have No Products, Some Prices Are NULL)
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 2, 1500.00),
(2, 1, 2, 3, 5.50),
(3, 2, 3, 1, NULL),  -- NULL Price
(4, 2, 4, 1, 120.00),
(5, 3, 5, 2, 3.00),
(6, 3, NULL, 1, 50.00),  -- Order with NULL Product
(7, 6, 6, 1, 25.00),
(8, 7, 7, NULL, 60.00),  -- NULL Quantity
(9, 8, 8, 2, 300.00),
(10, 9, 9, 1, NULL);  -- NULL Price


SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM Products;

--task1
SELECT Customers.CustomerName, Orders.OrderID,
       Orders.OrderDate
FROM Customers
LEFT JOIN Orders --provides even customers that aint have order
ON Customers.CustomerID = Orders.CustomerID

--task2
SELECT Customers.CustomerID,
       Customers.CustomerName
FROM Customers
LEFT JOIN Orders
ON Orders.CustomerID = Customers.CustomerID  
WHERE Orders.OrderID iS NULL

--task3
SELECT Products.ProductID, Products.ProductName,
       ISNULL(OrderDetails.Quantity, 0) as Quantity --when quantity null, replaces it with 0
FROM Products
JOIN OrderDetails
ON OrderDetails.ProductID = Products.ProductID

--task4
SELECT Customers.CustomerName,
       COUNT(Orders.OrderID) as CountofOrders
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName
HAVING COUNT(Orders.OrderID) > 1 

--task5
SELECT OrderDetails.OrderID, OrderDetails.ProductID, Products.ProductName,
       Price
FROM OrderDetails
JOIN Products ON Products.ProductID = OrderDetails.ProductID
WHERE Price = (SELECT MAX(Price) 
               FROM OrderDetails OD
			   WHERE OrderDetails.OrderID = OD.OrderID);

--task6
SELECT Customers.CustomerID , Customers.CustomerName,
       ISNULL(CAST(Orders.OrderDate AS VARCHAR), 'No date'), 
       RANK() OVER(ORDER BY Orders.OrderDate DESC) as LatestOrder
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID

--task7
SELECT Customers.CustomerName,
       Orders.OrderID, 
	   OrderDetails.ProductID,
	   Products.ProductName,
	   Products.Category
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails
ON  Orders.OrderID = OrderDetails.OrderID
JOIN Products
ON OrderDetails.ProductID = Products.ProductID 
 WHERE Products.Category = 'Electronics'


 --task8
SELECT Customers.CustomerName,
       Orders.OrderID, 
	   OrderDetails.ProductID,
	   Products.ProductName,
	   Products.Category,
	   COUNT(Distinct Products.ProductID)
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails
ON  Orders.OrderID = OrderDetails.OrderID
JOIN Products
ON OrderDetails.ProductID = Products.ProductID 
WHERE Products.Category = 'Stationery'
GROUP BY Customers.CustomerName,
       Orders.OrderID, 
	   OrderDetails.ProductID,
	   Products.ProductName,
	   Products.Category
HAVING COUNT(Distinct Products.ProductID) >= 1

--task9
SELECT Customers.CustomerName,
       Customers.CustomerID, 
	   SUM(OrderDetails.Quantity * Price) as TotalSpent
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails
ON  Orders.OrderID = OrderDetails.OrderID
GROUP BY Customers.CustomerID, Customers.CustomerName
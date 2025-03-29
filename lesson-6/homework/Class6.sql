--task1
SELECT Employees.EmployeeID, Employees.Name AS EmployeeName, 
       Departments.DepartmentName, Employees.Salary
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;

--task2
SELECT Employees.EmployeeID, Employees.Name AS EmployeeName, 
       COALESCE(Departments.DepartmentName, 'No Department') AS DepartmentName, 
       Employees.Salary
FROM Employees
LEFT JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;

--task3
SELECT COALESCE(Employees.EmployeeID, 'No Employee') AS EmployeeID, 
       COALESCE(Employees.Name, 'No Employee') AS EmployeeName, 
       Departments.DepartmentName
FROM Employees
RIGHT JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;


--task4
SELECT COALESCE(Employees.EmployeeID, 'No Employee') AS EmployeeID, 
       COALESCE(Employees.Name, 'No Employee') AS EmployeeName, 
       COALESCE(Departments.DepartmentName, 'No Department') AS DepartmentName
FROM Employees
FULL OUTER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;

--task5
SELECT Departments.DepartmentName, 
       COALESCE(SUM(Employees.Salary), 0) AS TotalSalaryExpense
FROM Departments
LEFT JOIN Employees ON Employees.DepartmentID = Departments.DepartmentID
GROUP BY Departments.DepartmentName;


--task6
SELECT Departments.DepartmentName, Projects.ProjectName
FROM Departments
CROSS JOIN Projects;

--task7
SELECT Employees.EmployeeID, Employees.Name AS EmployeeName, 
       COALESCE(Departments.DepartmentName, 'No Department') AS DepartmentName, 
       COALESCE(Projects.ProjectName, 'No Project') AS ProjectName
FROM Employees
LEFT JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
LEFT JOIN Projects ON Employees.EmployeeID = Projects.EmployeeID;

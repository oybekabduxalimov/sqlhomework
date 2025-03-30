DROP TABLE IF EXISTS Groupings;

CREATE TABLE Groupings
(
StepNumber  INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NOT NULL,
[Status]    VARCHAR(100) NOT NULL
);
INSERT INTO Groupings (StepNumber, TestCase, [Status]) 
VALUES
(1,'Test Case 1','Passed'),
(2,'Test Case 2','Passed'),
(3,'Test Case 3','Passed'),
(4,'Test Case 4','Passed'),
(5,'Test Case 5','Failed'),
(6,'Test Case 6','Failed'),
(7,'Test Case 7','Failed'),
(8,'Test Case 8','Failed'),
(9,'Test Case 9','Failed'),
(10,'Test Case 10','Passed'),
(11,'Test Case 11','Passed'),
(12,'Test Case 12','Passed');

-----------------------------------------

DROP TABLE IF EXISTS [dbo].[EMPLOYEES_N];

CREATE TABLE [dbo].[EMPLOYEES_N]
(
    [EMPLOYEE_ID] [int] NOT NULL,
    [FIRST_NAME] [varchar](20) NULL,
    [HIRE_DATE] [date] NOT NULL
)
 
INSERT INTO [dbo].[EMPLOYEES_N]
VALUES
	(1001,'Pawan','1975-02-21'),
	(1002,'Ramesh','1976-02-21'),
	(1003,'Avtaar','1977-02-21'),
	(1004,'Marank','1979-02-21'),
	(1008,'Ganesh','1979-02-21'),
	(1007,'Prem','1980-02-21'),
	(1016,'Qaue','1975-02-21'),
	(1155,'Rahil','1975-02-21'),
	(1102,'Suresh','1975-02-21'),
	(1103,'Tisha','1975-02-21'),
	(1104,'Umesh','1972-02-21'),
	(1024,'Veeru','1975-02-21'),
	(1207,'Wahim','1974-02-21'),
	(1046,'Xhera','1980-02-21'),
	(1025,'Wasil','1975-02-21'),
	(1052,'Xerra','1982-02-21'),
	(1073,'Yash','1983-02-21'),
	(1084,'Zahar','1984-02-21'),
	(1094,'Queen','1985-02-21'),
	(1027,'Ernst','1980-02-21'),
	(1116,'Ashish','1990-02-21'),
	(1225,'Bushan','1997-02-21');


--task1
SELECT 
    MIN(StepNumber) AS Min_Step_Number,
    MAX(StepNumber) AS Max_Step_Number,
    Status,
    COUNT(*) AS Consecutive_Count
FROM (
    SELECT 
        G1.StepNumber,
        G1.Status,
        (SELECT COUNT(*) 
         FROM Groupings G2 
         WHERE G2.StepNumber <= G1.StepNumber 
         AND G2.Status <> G1.Status) AS grp
    FROM Groupings G1
) AS Subquery
GROUP BY Status, grp
ORDER BY Min_Step_Number;

--task2
SELECT 
    StartYear, 
    EndYear, 
    CONCAT(StartYear, ' - ', EndYear) AS Years
FROM (
    SELECT 
        Y1.HireYear + 1 AS StartYear,
        (SELECT MIN(Y2.HireYear) - 1 
         FROM (SELECT DISTINCT YEAR(HIRE_DATE) AS HireYear FROM [dbo].[EMPLOYEES_N]) Y2 
         WHERE Y2.HireYear > Y1.HireYear) AS EndYear
    FROM (SELECT DISTINCT YEAR(HIRE_DATE) AS HireYear FROM [dbo].[EMPLOYEES_N]) Y1
) AS Subquery
WHERE StartYear <= EndYear
ORDER BY StartYear;

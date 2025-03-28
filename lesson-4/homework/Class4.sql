--task1
CREATE TABLE [TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
);
GO

INSERT INTO [TestMultipleZero]
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

SELECT A, B, C, D
FROM TestMultipleZero
WHERE A != 0 or B!= 0 or C != 0 or D != 0

--task2
DROP TABLE IF EXISTS TestMax;
CREATE TABLE TestMax
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
);
 
INSERT INTO TestMax 
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91);

SELECT Year1,
     CASE 
	      WHEN (Max1 >= Max2 and Max1 >= Max3) THEN Max1
		  WHEN Max2 >= Max1 and Max2 >= Max3 THEN Max2
		  ELSE Max3
     END AS MaxAcrossColumn
FROM TestMax

--task3
CREATE TABLE EmpBirth
(
    EmpId INT  IDENTITY(1,1) 
    ,EmpName VARCHAR(50) 
    ,BirthDate DATETIME 
);
 
INSERT INTO EmpBirth(EmpName,BirthDate)
SELECT 'Pawan' , '12/04/1983'
UNION ALL
SELECT 'Zuzu' , '11/28/1986'
UNION ALL
SELECT 'Parveen', '05/07/1977'
UNION ALL
SELECT 'Mahesh', '01/13/1983'
UNION ALL
SELECT'Ramesh', '05/09/1983';

SELECT EmpName, BirthDate
FROM EmpBirth
WHERE MONTH(BirthDate) = 5 
AND DAY(BirthDate) BETWEEN 7 AND 15;


--task4
create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');

SELECT *
FROM letters
ORDER BY 
     CASE 
         WHEN letter = 'b' THEN 1
         WHEN letter <> 'b' THEN 2 
         END,
		 letter;

SELECT * FROM letters 
ORDER BY CASE 
    WHEN letter = 'a' THEN 0  -- 'a' comes first
    WHEN letter = 'b' THEN 1  -- 'b' comes second
    ELSE 2  
END, letter;

--task1
DROP TABLE IF EXISTS test_identity;
CREATE TABLE test_identity (
       id INT IDENTITY,
	   name VARCHAR(50)
);

INSERT INTO test_identity(name)
VALUES ('A'), ('B'), ('C'), ('D'); 

SELECT * FROM test_identity;

DELETE FROM test_identity WHERE id > 2;
TRUNCATE TABLE test_identity;
DROP TABLE test_identity;

--task2
DROP TABLE IF EXISTS data_types_demo;
CREATE TABLE data_types_demo(
    id SMALLINT,
	age TINYINT,
	any_number BIGINT
)

INSERT INTO data_types_demo(id, age, any_number)
VALUES (1000, 15, 234512534643)

SELECT * FROM data_types_demo;

--task3
CREATE TABLE photos (
    id INT PRIMARY KEY IDENTITY(1,1),
    image_data VARBINARY(MAX)
);

INSERT INTO photos (image_data)
SELECT * FROM OPENROWSET(BULK 'C:\Users\user\Pictures\cropped_img.jpg', SINGLE_BLOB) AS ImageFile;

--pythoncode
--import pyodbc

--conn = pyodbc.connect("DRIVER={SQL Server};SERVER=your_server;DATABASE=your_db;UID=user;PWD=password")
--cursor = conn.cursor()

--cursor.execute("SELECT image_data FROM photos WHERE id = 1")
--row = cursor.fetchone()

--if row:
--    with open("output.jpg", "wb") as file:
--        file.write(row[0])

--cursor.close()
--conn.close()



--task4
DROP TABLE IF EXISTS student;
CREATE TABLE student (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(50),
    classes INT,
    tuition_per_class DECIMAL(10,2),
    total_tuition AS (classes * tuition_per_class)
);

INSERT INTO student (name, classes, tuition_per_class) VALUES 
('John', 3, 200.50),
('Alice', 4, 150.75),
('Bob', 5, 180.00);

SELECT * FROM student;

--task5
CREATE TABLE worker (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

BULK INSERT worker
FROM ''
WITH (
    FORMAT = 'C:\Users\user\Desktop\Datasets\Presidents\Politicians\allinfo.csv',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

SELECT * FROM worker;


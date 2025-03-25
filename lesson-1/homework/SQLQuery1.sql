use class1;

--task 1 
--without not null constraints
drop table if exists student;

create table student(
     id int,
	 name varchar(50),
	 age int
);

--using alter table
alter table student
alter COLUMN id int NOT NULL;



--task2
--defining product_id as unique inside the table
drop table if exists product
create table product(
     product_id int CONSTRAINT UQ_PRODUCT unique,
	 product_name varchar(50),
	 price decimal(10, 2)
);

--droppping unique constraint
alter table product
drop constraint UQ_PRODUCT;

--adding once again
ALTER TABLE product
ADD CONSTRAINT UQ_PRODUCT unique (product_id);

--combination
ALTER TABLE product
ADD CONSTRAINT UQ_PRODUCT_COMBINED UNIQUE(product_id, product_name);



--task3
--creating table with primary key
CREATE TABLE orders(
       order_id INT CONSTRAINT ORDER_PRIME PRIMARY KEY,
	   customer_name varchar(50),
	   order_date date
);

--dropping and adding constraint
ALTER TABLE orders
DROP CONSTRAINT ORDER_PRIME;
ALTER TABLE orders
ADD CONSTRAINT ORDER_PRIME PRIMARY KEY(order_id);



--task4
create table category(
       category_id INT PRIMARY KEY,
	   category_name varchar(50)
);

create table item(
       item_id INT PRIMARY KEY,
	   item_name varchar(50),
	   category_id INT,
	   CONSTRAINT CT_ITEM_CATEGORY FOREIGN KEY (category_id) REFERENCES category(category_id)
);

alter table item
drop constraint CT_ITEM_CATEGORY;

alter table item
add constraint CT_ITEM_CATEGORY Foreign Key (cateogry_id) REFERENCES category(cateogry_id);



--task5
CREATE TABLE account(
       account_id INT PRIMARY KEY,
	   balance DECIMAL(10, 2) CONSTRAINT checking_bal CHECK (balance >=0),
	   account_type varchar(50) CONSTRAINT checking_type CHECK (account_type IN ('Saving', 'Checking'))
);

--dropping
ALTER TABLE account
DROP CONSTRAINT checking_bal;

ALTER TABLE account
DROP CONSTRAINT checking_Type;

--re-adding
ALTER TABLE account
ADD CONSTRAINT checking_bal CHECK (balance >= 0);

ALTER TABLE account
ADD CONSTRAINT checking_type CHECK (account_type IN ('Saving', 'Checking'));


--task6
CREATE TABLE customer(
       customer_id INT PRIMARY KEY,
	   name varchar(50),
	   city varchar(50) CONSTRAINT default_value DEFAULT 'unknown'
);

ALTER TABLE customer
DROP CONSTRAINT default_value;

ALTER TABLE customer
ADD CONSTRAINT default_value DEFAULT 'unknown' FOR city;


--task7
DROP TABLE IF EXISTS invoice;
CREATE TABLE invoice(
       invoice_id INT IDENTITY(1, 1),
	   amount DECIMAL(10, 2)
);

INSERT INTO invoice
VALUES (1000.12), (1001.12), (1020.12)

SELECT * FROM invoice;


--task8
CREATE TABLE books(
       book_id INT PRIMARY KEY IDENTITY(1, 1),
	   title VARCHAR(50) not null,
	   price DECIMAL(10, 2) CHECK (price > 0),
	   genre VARCHAR(50) DEFAULT 'Unknown'
);

INSERT INTO books(title, price, genre)
VALUES ('Oybek', 12000.12, 'Action'), ('Tenet', 12032.64 , 'Sci-Fi')

SELECT * FROM books

--task9
CREATE TABLE book (
       book_id INT PRIMARY KEY,
       title VARCHAR(50),
	   author VARCHAR(50),
	   published_year INT
);

CREATE TABLE member (
       member_id INT PRIMARY KEY,
	   name VARCHAR(50),
	   email VARCHAR(50),
	   phone_number VARCHAR(50)
);

CREATE TABLE loan (
       loan_id INT PRIMARY KEY,
	   book_id INT FOREIGN KEY REFERENCES book(book_id),
	   member_id INT FOREIGN KEY REFERENCES member(member_id),
	   loan_date DATE,
	   return_date DATE
);

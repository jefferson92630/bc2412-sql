-- this is a comment line
-- MySQLWorkbench is a client side -> connect(id/port/id/password) -> MySQL Server (7x24)

-- MySQL DBMS -> case insensitive

create database bootcamp_2412;

-- Use database
use bootcamp_2412;

-- MySQL Server may contains many databases, one database may contains many tables
-- varchar = String
create table customers (
	id integer,
    first_name varchar(20), -- "20" means the length
    last_name varchar(20),
    email varchar(50),
    dob date
);

-- * means all columns
select*
from customers;

insert into customers(id, first_name, last_name, email, dob)
values (1, 'Vincent', 'Lau', 'vincentlau@gmail.com', '1999-12-31');

insert into customers(id, first_name, last_name, email, dob)
values (2, 'Jefferson', 'Kwong', 'jefferson92630@gmail.com', '1992-06-30');

insert into customers(id, first_name, last_name, email, dob)
values (3, 'Steve', 'Tsang', 'stevetsang@gmail.com', '1993-07-31');

-- delete all data from table
delete from customers;

-- delete data by criteria
delete from customers where last_name = 'Tsang';

-- select specific columns
-- select is to choose columns
select id, first_name, dob from customers;

-- where is to control rows
select id, first_name, dob from customers where dob < '1999-01-01';

-- SELECT doesn't change the data in harddisk. SQL is just using a program to retrieve the data in harddisk
-- INSERT, delete change the data in harddisk

-- More than one criteria
select * from customers where last_name = 'Kwong' and dob > '1992-06-01';
select * from customers where last_name = 'Kwong' or first_name = 'Steve';

-- and has higher priority to execute
select * from customers where last_name = 'Kwong' or first_name = 'Steve'and dob > '1992-06-01';
select * from customers where (last_name = 'Kwong' or first_name = 'Steve') and dob > '1992-06-01';

-- Not equals to
select * from customers where last_name <> 'Kwong';

-- order by (default asc)
select * from customers order by first_name;
-- order by asc
select * from customers order by first_name asc;
-- order by desc
select * from customers order by first_name desc;
select * from customers where dob > '1992-06-01' order by first_name desc; -- stream().filter().sorted()

-- table: orders
-- id, amount, order_date, customer_id
create table orders (
   id integer, 
   amount decimal(13,2), -- the number can have up to 13 digits in total, including 2 digits after the decimal point. 11 is for integer digit, 2 is for decimal places
   order_date datetime, 
   customer_id integer
);

drop table orders; -- delete the whole table

select * from orders;

insert into orders (id, amount, order_date, customer_id)
values(1, 100.9, STR_TO_DATE('2020-12-31 23:10:59', '%Y-%m-%d %H:%i:%s'), 1);

insert into orders (id, amount, order_date, customer_id)
values(2, 999.9, current_time(), 3);

insert into orders (id, amount, order_date, customer_id)
values (3, 1999.2, current_time(), 3);

insert into orders values (4, 9999.9, current_time(), 3);

insert into orders values
	(5, 12000, current_time(), 3),
    (6, 15000, current_time(), 3)
    ;
    
-- sum(), avg(), min(), max(), count() -> aggregate function -> result data structure changed
select sum(amount) from orders;
select avg(amount) from orders;
select min(amount) from orders;
select max(amount) from orders;
select count(amount) from orders;

-- NOT OK
select sum(amount), id from orders;

-- OK
select sum(amount) as total_amt, 
round(avg(amount),2) as avg_amt, 
min(amount) as lowest_amt, 
max(amount) as highest_amt, 
count(amount) as order_count, 
1, 
'hello' 
from orders
where amount > 1000;

-- SQL sequence
-- 1. FROM
-- 2. WHERE
-- 3. GROUP BY (HAVING)
-- 4. ORDER BY
-- 5. SELECT COLUMNS

-- Math
-- o.* will return all columns from the orders table.
select floor(o.amount), o.* from orders o; -- down to nearest integer.
select floor(amount) from orders; -- return floor(amount) column only.

select ceil(o.amount), o.* from orders o; -- up to nearest integer.
select abs(-4), abs(4) from dual; -- absolute value

-- String
select concat(c.first_name, ' ', c.last_name) as full_name, 
length(c.last_name) as length_of_lastname
, upper(c.first_name) as uppercase_firstname
, lower(c.first_name) as lowercase_firstname
, replace(c.email, '@', '$') as new_email
, substring(c.first_name, 1, 1) as first_name_initial -- not related to Java index, so must be start with 1
, left(c.first_name, 2) as left_first_name
, right(c.first_name, 2) as right_first_name
, instr(c.first_name, 'V') as firstname_contains_v1 -- if contains, it will show the position of 'v' existing in the words, and shows the first position only if there are more than one target letters exists.
, instr(c.first_name, 'v') as firstname_contains_v2
, instr(c.first_name, 'V') as firstname_contains_capletter
, instr(c.first_name, 'V') as firstname_contains_smallletter
, c.* 
from customers c;

-- LIKE
-- % means any characters
select *
from customers
where first_name like '%V%';

select *
from customers
where first_name like '%V%T'; -- will search from the first letter of 'v', and then 't'

-- DATE (add)
select o.*, date_add(o.order_date, interval 3 month) as follow_up_date
from orders o;

-- DATE (subtract)
select o.*, date_sub(o.order_date, interval 3 day) as follow_up_date
from orders o;

select o.*, date_add(o.order_date, interval 2 year) as follow_up_date
from orders o;

select o.*, date_sub(o.order_date, interval 3 second) as follow_up_date
from orders o;

-- can add and subtract year, hour, minute, second

-- Separate the data into groups, by a column (customer_id)
-- After group by, you can only select the column that you used for "Group"
select customer_id, count(1) as order_count, avg(amount) as average_order_amount, max(amount), min(amount)
from orders
group by customer_id;

-- from -> where -> group by -> select
select customer_id, sum(amount) as total_order_amt, count(1) as order_count
from orders
where amount < 5000
group by customer_id;

select count(2) -- count the no. of rows that has the count
from orders o;

-- Database Type: Ralational DB (Structure -> schema -> row x column)
-- INNER JOIN (customers x orders)
-- 1. Find order count by customer, show customer ID, first_name, last_name and order_count
select *
from customers c inner join orders o on o.customer_id = c.id;

-- 3 customers x 6 orders
-- use on
select c.id as customer_id, c.first_name, c.last_name, count(1) as order_count -- c.*, o.*
from customers c inner join orders o on o.customer_id = c.id
group by c.id, c.first_name, c.last_name;

-- use where
select c.id as customer_id, c.first_name, c.last_name, count(1) as order_count
from customers c inner join orders o on o.customer_id = c.id -- "on" -> before join
where o.amount < 5000 -- "where" after join, but before group
group by c.id, c.first_name, c.last_name;

-- Another way to express (more common)
select c.id, c.first_name, c.last_name, count(1) as order_count
from customers c, orders o
where c.id = o.customer_id
and o.amount < 5000
group by c.id, c.first_name, c.last_name;

-- group by + having
select c.id, c.first_name, c.last_name, count(1) as order_count
from customers c, orders o
where c.id = o.customer_id
and o.amount < 5000 -- filter record (rows)
group by c.id, c.first_name, c.last_name
having count(1) > 1 -- after group by -> filter group
order by c.id;

-- distinct
select distinct customer_id -- not relate to the no.of count of specific customer id
from orders;

select distinct last_name
from customers;

insert into customers(id, first_name, last_name, email, dob) -- distinct will not show the duplicated input, only show one
values (4, 'Steve', 'Tsang', 'stevetsang2@gmail.com', '1993-08-31');

select distinct last_name, first_name, count(1)
from customers
group by last_name, first_name; -- group by go first, then distinct

select distinct last_name
from customers
group by last_name, first_name;

-- Distinct column should exist in "group by", because "group by" change the data presentation, but others OK, such as "where"

-- select distinct id
-- from customers
-- group by last_name, first_name;

-- LEFT JOIN (Show all records of the left table)
-- Find all customers with his orders
select c.*, o.*
from customers c left join orders o on c.id = o.customer_id;

select o.*, c.*
from orders o left join customers c on c.id = o.customer_id;

-- RIGHT JOIN (theory same as LEFT JOIN)
select c.*, o.*
from customers c right join orders o on c.id = o.customer_id;

select o.*, c.*
from orders o right join customers c on c.id = o.customer_id;

-- Find the customer who didn't place order
-- left join + where
select c.*, o.*
from customers c left join orders o on c.id = o.customer_id
where o.id is null;

select *
from orders;

-- Add Primary Key for customers, orders
ALTER TABLE customers ADD CONSTRAINT pk_customer_id PRIMARY KEY (id);
ALTER TABLE orders ADD CONSTRAINT pk_order_id PRIMARY KEY (id);

-- Add Foreign Key for orders
ALTER TABLE orders ADD CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customers(id);

-- Not allowed. FK fail.
-- insert into orders values (7, 400.0, current_time(), 99);

-- Many to Many Table Design
CREATE TABLE STUDENTS (
	ID INT PRIMARY KEY AUTO_INCREMENT, -- NOT NULL, UNIQUE, INDEX
    NAME VARCHAR(50) NOT NULL,
    EMAIL VARCHAR(50) UNIQUE
);

CREATE TABLE SUBJECTS (
	ID INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(30) NOT NULL
);

CREATE TABLE STUDENT_SUBJECTS (
	ID INT NOT NULL UNIQUE,
    STUDENT_ID INT,
    SUBJECT_ID INT,
    PRIMARY KEY (STUDENT_ID, SUBJECT_ID),
    FOREIGN KEY (STUDENT_ID) REFERENCES STUDENTS(ID), -- FK CAN BE NULL
    FOREIGN KEY (SUBJECT_ID) REFERENCES SUBJECTS(ID) -- FK CAN BE NULL
);


drop table STUDENT_SUBJECTS; -- you have to drop the table with FK first
drop table STUDENTS;
drop table SUBJECTS;

insert into students (name, email) values ('Jeff', 'jeff@gmail.com');
insert into students (name, email) values ('Steven', 'steven@gmail,com');

select * from students;

insert into subjects (name) values ('Physics');
insert into subjects (name) values ('Chemistry');
insert into subjects (name) values ('Biology');

insert into student_subjects (id, student_id, subject_id) value (1, 1, 3);
insert into student_subjects (id, student_id, subject_id) value (2, 1, 2);
insert into student_subjects (id, student_id, subject_id) value (3, 2, 1);
insert into student_subjects (id, student_id, subject_id) value (4, 2, 2);

-- Join 3 tables
select s.name, b.name
from student_subjects ss, students s, subjects b
where ss.student_id = s.id
and ss.subject_id = b.id;

-- SELECT s.name, b.name
-- FROM student_subjects ss
-- INNER JOIN students s ON ss.student_id = s.id
-- INNER JOIN subjects b ON ss.subject_id = b.id;

create or replace view vcustomers_orders
as
select c.id as customer_id, c.first_name, c.last_name, c.email, o.amount, o.order_date, o.id as order_id
from customers c inner join orders o on c.id = o.customer_id
;

-- View:
-- 1. Real time execution from the SQL behind the view.
-- 2. When you modify the SQL behind the view, you have to re-compile view to take effective
-- 3. View has its own access right (select), so that we can manage access right of table across accounts.
select * from vcustomers_orders;

alter table customers add order_count int;

select * from customers;

select * from orders;

insert into orders (id, amount, order_date, customer_id)
values (9, 120.1, current_time(), 1);

drop TRIGGER update_order_count;

DELIMITER //

CREATE TRIGGER update_order_count
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    -- TRIGGER CUSTOMER'S TRIGGER
    UPDATE customers
    SET order_count = order_count + 1
    WHERE id = NEW.customer_id;
END;
//

DELIMITER ;

create table table_logs (
id int primary key auto_increment,
table_name varchar(50),
column_name varchar(50),
old_value varchar(50),
new_value varchar(50)
);

select * from table_logs;

update customers set dob = '2000-01-10' where id = 1;

DELIMITER //

CREATE TRIGGER update_customer_data
AFTER UPDATE ON customers
FOR EACH ROW
BEGIN
  IF (OLD.dob <> NEW.dob) THEN
	insert into table_logs (table_name, column_name, old_value, new_value)
    values ('CUSTOMERS', 'DOB', OLD.dob, NEW.dob);
    END IF;
END;
//

DELIMITER ;

 


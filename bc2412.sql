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
-- insert, delete change the data in harddisk

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
select * from customers where dob > '1992-06-01' order by first_name desc; -- stream.filter().sorted()

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
select floor(o.amount), o.* from orders o; -- down to nearest integer.
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
where first_name like '%V%T';

-- DATE (add)
select o.*, date_add(o.order_date, interval 3 month) as follow_up_date
from orders o

-- DATE (subtract)
select o.*, date_sub(o.order_date, interval 3 month) as back__date
from orders o


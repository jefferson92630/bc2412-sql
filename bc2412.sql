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
   id bigint, 
   amount Integer, 
   order_date date, 
   customer_id Integer
);


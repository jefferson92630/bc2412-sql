create database org;
show databases;

use org;

create table WORKER(
WORKER_ID INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
FIRST_NAME CHAR(25),
LAST_NAME CHAR(25),
SALARY NUMERIC(15),
JOINING_DATE DATETIME,
DEPARTMENT CHAR(25)
);

INSERT INTO WORKER (FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) values 
('Monika', 'Arora', 100000, '21-02-20 09:00:00', 'HR'),
('Niharika', 'Verma', 80000, '21-06-11 09:00:00', 'Admin'),
('Vishal', 'Singhal', 300000, '21-02-20 09:00:00', 'HR'),
('Monika', 'Sarah', 300000, '12-03-19 09:00:00', 'Admin'),
('Amitabh', 'Singh', 500000, '21-02-20 09:00:00', 'Admin'),
('Vivek', 'Bhati', 490000, '21-06-11 09:00:00', 'Admin'),
('Vipul', 'Diwan', 200000, '21-06-11 09:00:00', 'Account'),
('Satish', 'Kumar', 75000, '21-01-20 09:00:00', 'Account'),
('Geetika', 'Chauhan', 90000, '21-04-11 09:00:00', 'Admin');

select * from worker;

create table BONUS (
WORKER_REF_ID INTEGER,
BONUS_AMOUNT NUMERIC(10),
BONUS_DATE DATETIME,
FOREIGN KEY (WORKER_REF_ID) REFERENCES Worker(WORKER_ID)
);

insert into bonus (worker_ref_id, bonus_amount, bonus_date) values
(6, 32000, '21-11-02'),
(6, 20000, '22-11-02'),
(5, 21000, '21-11-02'),
(9, 30000, '21-11-02'),
(8, 4500, '22-11-02');

select * from bonus;

select max(salary) as second_max_salary
from worker
where salary < (select max(salary) from worker);

select max(salary) as highest_salary, department
from worker
group by department;


with same_salary as (
select salary
from worker
group by salary
having count(salary) > 1
)
select w.first_name, w.last_name, w.salary
from worker w inner join same_salary sa on w.salary = sa.salary;

select w.first_name, w.last_name
from worker w inner join bonus b on w.worker_id = b.worker_ref_id
where year(b.bonus_date) = 2021;



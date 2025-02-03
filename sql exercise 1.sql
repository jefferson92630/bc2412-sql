create database sql_exercise_1;

use sql_exercise_1;

CREATE TABLE REGIONS (
REGION_ID INT PRIMARY KEY,
REGION_NAME VARCHAR(20) NOT NULL
);

insert into regions (region_id, region_name) values (1, 'Europe');
insert into regions (region_id, region_name) values (2, 'America');
insert into regions (region_id, region_name) values (3, 'Asia');


CREATE TABLE COUNTRIES (
COUNTRY_ID CHAR(2) PRIMARY KEY,
COUNTRY_NAME VARCHAR(20) NOT NULL,
REGION_ID INT,
FOREIGN KEY (REGION_ID) REFERENCES REGIONS (REGION_ID)
);

insert into countries (country_id, country_name, region_id) values
('DE', 'Germany', 1);
insert into countries (country_id, country_name, region_id) values
('IT', 'Italy', 1);
insert into countries (country_id, country_name, region_id) values
('JP', 'Japan', 2);
insert into countries (country_id, country_name, region_id) values
('US', 'United States', 3);

select * from countries;

CREATE TABLE LOCATIONS (
LOCATION_ID INT PRIMARY KEY,
STREET_ADDRESS VARCHAR(25) NOT NULL,
POSTAL_CODE VARCHAR(12) NOT NULL,
CITY VARCHAR (30) NOT NULL,
STATE_PROVINCE VARCHAR(12),
COUNTRY_ID CHAR(2),
FOREIGN KEY (COUNTRY_ID) REFERENCES COUNTRIES (COUNTRY_ID)
);

insert into locations (location_id, street_address, postal_code, city, country_id)
values (1000, '1297 Via Cola di Rie', '989', 'Roma', 'IT');

insert into locations (location_id, street_address, postal_code, city, country_id)
values (1100, '93901 Calle della Te', '10934', 'Venice', 'IT');

insert into locations (location_id, street_address, postal_code, city, state_province, country_id)
values (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo', 'JP');

insert into locations (location_id, street_address, postal_code, city, state_province, country_id)
values (1400, '2014 Jabberwocky Rd', '26192', 'SouthLake', 'Texas', 'US');

select * from locations;

CREATE TABLE DEPARTMENTS (
DEPARTMENT_ID INT PRIMARY KEY,
DEPARTMENT_NAME VARCHAR(30),
MANAGER_ID INT,
LOCATION_ID INT,
FOREIGN KEY (LOCATION_ID) REFERENCES LOCATIONS (LOCATION_ID)
);

insert into departments (department_id, department_name, manager_id, location_id)
values (10, 'Administration', 200, 1100);

insert into departments (department_id, department_name, manager_id, location_id)
values (20, 'Marketing', 201, 1200);

insert into departments (department_id, department_name, manager_id, location_id)
values (30, 'Purchasing', 202, 1400);

select * from departments;

CREATE TABLE JOBS (
JOB_ID VARCHAR(10) PRIMARY KEY,
JOB_TITLE VARCHAR(25),
MIN_SALARY INT,
MAX_SALARY INT
);

insert into jobs (job_id, job_title, min_salary, max_salary)
values ('ST_CLERK', 'Admin Clerk', 18000.00, 25000.00);

insert into jobs (job_id, job_title, min_salary, max_salary)
values ('MK_REP', 'Marketing Representative', 9000.00, 20000.00);

insert into jobs (job_id, job_title, min_salary, max_salary)
values ('IT_PROG', 'Programmer', 17000.00, 19000.00);

CREATE TABLE EMPLOYEES (
EMPLOYEE_ID INT PRIMARY KEY,
FIRST_NAME VARCHAR(20) NOT NULL,
LAST_NAME VARCHAR(25) NOT NULL,
EMAIL VARCHAR(25) UNIQUE,
PHONE_NUMBER VARCHAR(20),
HIRE_DATE DATE,
JOB_ID VARCHAR(10),
FOREIGN KEY (JOB_ID) REFERENCES JOBS (JOB_ID),
SALARY INT,
COMMISSION_PCT INT,
MANAGER_ID INT,
DEPARTMENT_ID INT,
FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS (DEPARTMENT_ID)
);


insert into employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
values (100, 'Steven', 'King', 'sking@gmail.com', '515-1234567', '1987-06-17', 'ST_CLERK', 24000.00, 0.00, 109, 10);

insert into employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
values (101, 'Neena', 'Kochhar', 'nkochhar@gmail.com', '515-1234568', '1987-06-18', 'MK_REP', 17000.00, 0.00, 103, 20);

insert into employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
values (102, 'Lex', 'De Haan', 'ldehaan@gmail.com', '515-1234569', '1987-06-19', 'IT_PROG', 17000.00, 0.00, 108, 30);

insert into employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
values (103, 'Alexander', 'Hurold', 'ahurold@gmail.com', '590-4234567', '1987-06-20','MK_REP', 9000.00, 0.00, 105, 20);

select * from employees;

CREATE TABLE JOB_HISTORY (
EMPLOYEE_ID INT,
FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES (EMPLOYEE_ID),
START_DATE DATE,
PRIMARY KEY (EMPLOYEE_ID, START_DATE),
END_DATE DATE,
JOB_ID VARCHAR(10),
FOREIGN KEY (JOB_ID) REFERENCES JOBS (JOB_ID)
);

insert into job_history (employee_id, start_date, end_date, job_id)
values (102, '1993-01-13', '1998-07-24', 'IT_PROG');

insert into job_history (employee_id, start_date, end_date, job_id)
values (101, '1989-09-21', '1993-10-27', 'MK_REP');

insert into job_history (employee_id, start_date, end_date, job_id)
values (101, '1993-10-28', '1997-03-15', 'IT_PROG');

insert into job_history (employee_id, start_date, end_date, job_id)
values (100, '1996-02-17', '1999-12-19', 'ST_CLERK');

insert into job_history (employee_id, start_date, end_date, job_id)
values (103, '1998-03-24', '1999-12-31', 'MK_REP');

select l.location_id, l.street_address, l.city, l.state_province, c.country_name
from countries c inner join locations l on c.country_id = l.country_id;

select first_name, last_name, department_id
from employees;

with department_employee as (
select d.department_id as dep_id, e.*
from departments d inner join employees e on d.department_id = e.department_id
), country_location as (
select c.country_id, c.country_name, l.*
from countries c inner join locations l on c.country_id = l.country_id
)
select de.first_name, de.last_name, de.job_id, de.dep_id
from department_employee de inner join country_location cl on de.location_id = cl.location_id




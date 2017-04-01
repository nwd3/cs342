--Homework 7
--Nathanael Dick
--1
drop view DeptView;

create or replace view DeptView
As SELECT e.employee_id, e.first_name, e.last_name, e.email, e.hire_date, d.department_name
from employees e, departments d
where d.department_id = e.department_id;

--a
select distinct first_name, last_name, employee_id
from DeptView
where hire_date in (select max(e.hire_date) from employees e, departments d where e.department_id
							=d.department_id and d.department_name='Executive');



						
--b
--ORA-01779: cannot modify a column which maps to a non key-preserved table.  You can't update a deparment beacuse the 
--view doesn't give you the option to update the department id which is the key for the table
UPDATE DeptView
SET department_name = 'Bean Counting'
WHERE department_name = 'Administration';

--c
--this works fine no key preserved tables
UPDATE DeptView
SET first_name = 'Manuel'
WHERE first_name = 'Jose Manuel' ;

--d
--oracle does not allow you to insert into two base tables that are joined at the same time
--this failed because you can't insert into a view that has two tables joined because oracle doesn't allow you to do it.
insert into DeptView 
Values(9000, 'Lance', 'Hilkensien', 'lande@gmail.com', '01-OCT-1997','01-OCT-1997');
drop view DeptView;

--2

							
drop MATERIALIZED VIEW DeptView2;	

CREATE MATERIALIZED VIEW DeptView2
  BUILD Immediate
  REFRESH COMPLETE
  AS
 SELECT e.employee_id, e.first_name, e.last_name, e.email, e.hire_date, d.department_name
from employees e, departments d
where d.department_id = e.department_id;


--a
select distinct first_name, last_name, employee_id
from DeptView2
where hire_date in (select max(e.hire_date) from employees e, departments d where e.department_id
							=d.department_id and d.department_name='Executive');

--b
--ORA-01779: cannot modify a column which maps to a non key-preserved table
UPDATE DeptView2
SET department_name = 'Administration'
WHERE department_name = 'Bean Counting';

--c
--you can't insert/update a materialized views
Update DeptView2
SET first_name = 'Manuel'
WHERE first_name = 'Jose Manuel' ;		


--d can't do this because you can't insert into a materialized table
insert into DeptView2 
Values(9000, 'Lance', 'Hilkensien', 'lande@gmail.com', '01-OCT-1997','01-OCT-1997');


							
							
							
							
							
							
							
							
							

--Homework 7
--Nathanael Dick
--1
drop view allEmpView;
create or replace view allEmpView
As SELECT e.employee_id, e.first_name, e.last_name, e.email, e.hire_date, d.department_name
from employees e, departments d
where d.department_id = e.department_id;

--a
select distinct a.first_name, a.last_name, a.employee_id
from allEmpView a, allEmpView b
where a.HIRE_DATE in (select max(e.hire_date) from employees e, departments d where e.department_id
							=d.department_id and d.department_name='Executive');



						
--b
--ORA-01779: cannot modify a column which maps to a non key-preserved table
UPDATE allEmpView
SET department_name = 'Administration'
WHERE department_name = 'Bean Counting';

--c
UPDATE allEmpView
SET first_name = 'Manuel'
WHERE first_name = 'Jose Manuel' ;

--d
--oracle does not allow you to insert into two base tables that are joined at the same time
--this failed
insert into allEmpView 
Values(9000, 'Lance', 'Hilkensien', 'lande@gmail.com', '01-OCT-1997','01-OCT-1997');
drop view allEmpView;

--2

							
drop MATERIALIZED VIEW sv;	

CREATE MATERIALIZED VIEW sv
  BUILD Immediate
  REFRESH COMPLETE
  AS
 SELECT e.employee_id, e.first_name, e.last_name, e.email, e.hire_date, d.department_name
from employees e, departments d
where d.department_id = e.department_id;


--a
select distinct sv.first_name, sv.last_name, sv.employee_id
from sv
where sv.HIRE_DATE in (select max(e.hire_date) from employees e, departments d where e.department_id
							=d.department_id and d.department_name='Executive');


--b
--ORA-01779: cannot modify a column which maps to a non key-preserved table
UPDATE sv
SET department_name = 'Administration'
WHERE department_name = 'Bean Counting';

--c
--you can't insert into materialized views
Update sv
SET first_name = 'Manuel'
WHERE first_name = 'Jose Manuel' ;		


--d can't do this because you can't insert into a materialized table
insert into sv 
Values(9000, 'Lance', 'Hilkensien', 'lande@gmail.com', '01-OCT-1997','01-OCT-1997');


							
							
							
							
							
							
							
							
							

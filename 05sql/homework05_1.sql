--Homework 5
--Nathanael Dick
--1
--a
select Unique e.first_name,e.last_name,e.employee_id
from employees e, job_history j
	where j.end_date is not null
	and j.employee_id=e.employee_id;

--b
select e.first_name||' '|| e.last_name||' '||e2.first_name||' '||e2.last_name
from employees e,employees e2
	where e.manager_id=e2.employee_id
	and e.hire_date < e2.hire_date
	and e.department_id=e2.department_id
	and not exists(select j.job_id from job_history j
									where j.department_id!=e2.department_id
									and e.employee_id=j.employee_id);

--c
--I think the join query is more elagant and pain free than the nested subquery.  It 
--doesn't require as much effort to write
--nested subquery way
select country_name 
from countries
	where country_id in(select DISTINCT country_id 
							from locations, departments
							where departments.location_id=locations.location_id);

--join way
select DISTINCT countries.country_name 
from countries
	JOIN locations
on locations.country_id=countries.country_id
	JOIN 
departments on departments.location_id=locations.location_id;

--or I found a third way to do it but very unelegant
/* 
select DISTINCT locations.country_id ,countries.country_name from locations, departments,countries
where locations.location_id=departments.location_id and locations.country_id=countries.country_id;
 */
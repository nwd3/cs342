--Homework 6
--a
select e2.employee_id,count(e2.employee_id) as t,e2.first_name,e2.last_name
from employees e,employees e2
	where e.manager_id=e2.employee_id
	group by e2.employee_id,e2.first_name,e2.last_name
	limit 2
	order by t desc;
--b
select Distinct d.department_name,count(e1.department_id) as t, Sum(e1.salary)
	from departments d, employees e1, locations l, countries c
	where d.location_id = l.location_id
	and l.country_id = c.country_id
	and d.department_id = e1.department_id
	group by e1.department_id, d.department_name, c.country_name
	having count(e1.department_id) <100 and c.country_name!='United States of America';
--c
select d.department_name|| ' '|| e.first_name||' '|| e.last_name||' '|| j.job_title "Department Managers"
	from departments d
		left outer join employees e on d.manager_id=e.employee_id
		left outer join jobs j on e.job_id=j.job_id;
--d
select d.department_name, avg(e.salary)
	from departments d
	left outer join employees e on e.department_id=d.department_id
	group by d.department_name
	order by avg(e.salary) desc;
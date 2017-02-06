--Description: Lab that works to familiarize a user with sql by
--using basic sql commands,help from andrew with formatting code and commands etc.
--Name: Nathanael Dick
--Lab: Lab1
--Class: CS 342
--Professor: Keith Vander Linden

--Exercise 1.1
--a. list all the rows of the departments table.
SELECT * FROM DEPARTMENTS;


--b.find the number of employees in the database
SELECT COUNT(employee_id) FROM EMPLOYEES;

--c part i.
SELECT * FROM EMPLOYEES
WHERE salary > 15000 ;

--c part ii.
SELECT * FROM EMPLOYEES 
WHERE hire_date BETWEEN '01%Jan%02'AND '01%Jan%04' ; 

--c part iii.
SELECT * FROM EMPLOYEES
WHERE phone_number NOT LIKE '515%';


--d list the names of the employees who are in the finance department
SELECT (first_name||last_name) 
FROM EMPLOYEES, DEPARTMENTS
  WHERE ( department_name ='finance');

--e list the city,state and country name foar all locations in the Asian region
SELECT * FROM LOCATIONS, COUNTRIES,REGIONS
WHERE
LOCATIONS.country_id = COUNTRIES.country_id AND COUNTRIES.region_id =REGIONS.region_id AND (region_name = 'ASIAN');


--f list the locations that have no state or province specified in the database
SELECT (location_id) FROM LOCATIONS
WHERE
state_province is NULL;
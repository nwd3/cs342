--Lab5
--Nathanael Dick

--Exercise 5.1
--a.
select *
from person,household;
--optional challenge
select count(*)
from person,household;
--b
select firstname, lastname from person
    where birthdate is not Null
    Order by TO_CHAR(birthdate,'DDD') asc;

	 


--Exercise 7.2
drop materialized view birthday_czar8;
create Materialized view birthday_czar8
	build immediate
	refresh force
	on demand
As SELECT firstName, lastName, birthdate, id, title, membershipStatus
	From person;
--7.2a

 select firstName
from birthday_czar8
where birthdate between '01-JAN-61' and '31-DEC-75';

--7.2b

UPDATE Person
SET birthdate = NULL
WHERE id =0;

--This still displays Keith Vanderlinden in the select from materialized view even though 
--I just updated the record.  This is because a materialized view only refreshes from the base table when you want it to refresh
 select firstName
from birthday_czar8
where birthdate between '01-JAN-61' and '31-DEC-75';

--c
-- can't do this because you can't insert into a materialized table
--oracle won't allow you to do this unless you 
--create a log etc
--ORA-01732:data manipulation operation not legal on this view
insert into birthday_czar8 
Values( 'Lance', 'Hilkensien', '01-OCT-1997',1111,'manager','m');


--d
--dropping the materialized view refreshes the materialized view and eliminates Keith Vanderlinden
--from displaying

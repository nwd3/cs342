--Exercise 7.2

create Materialized view birthday_czar7 (a,b,c,d,e,f)
	build immediate
	refresh force
	on demand
As SELECT p.firstName, p.lastName, p.birthdate, p.id, p.title, p.membershipStatus
	From person p;
--7.2a

 select bc.a
from birthday_czar7 bc
where bc.c between '01-JAN-61' and '31-DEC-75';


UPDATE Person
SET birthdate = NULL
WHERE id = 144;

commit;

 select bc.a
from birthday_czar7 bc
where bc.c between '01-JAN-61' and '31-DEC-75';
drop materialized view birthday_czar7;
--A materialized view makes a copy of the existing table and then refreshes the view 
--thus anything written to the existing table will be overwritten
--Even If I drop the view It does not update the output for example the select statement above
--these comments does not update the records
--Thus For example Cindy is displayed even though I changed her birthdate to null
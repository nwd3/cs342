--Nathanael Dick
--Lab 7 Exercise 7.1
 --d see below for explanation
 drop view birthday_czar2;

--create view
 create or replace view birthday_czar (a,b,c,d)
As SELECT p.firstName, p.lastName, TRUNC((months_between(SYSDATE,p.birthdate)/12),-1) "age" , p.birthdate
	From person p;

--7.1.a
 select bc.d, bc.a
from birthday_czar bc
where bc.d between '01-JAN-61' and '31-DEC-75'; 
	
--7.1.b when i updated the row it updated the view and the view did not display Keith VanderLinden who I gave a Null Birthdate

UPDATE Person
SET birthdate = NULL
WHERE id = 0;

 select bc.d, bc.a
from birthday_czar bc
where bc.d between '01-JAN-61' and '31-DEC-75';  



--c 
 --I had to get rid of the age in this view so I could insert into the view
create or replace view birthday_czar2 (a,b,c,d,e,f)
As SELECT p.firstName, p.lastName, p.birthdate, p.id, p.title, p.membershipStatus
	From person p;
	

--after I inserted it it updated the view with Cindy's name so it when I select * the birthday_czar2 view
INSERT INTO birthday_czar2
 VALUES ('cindy', 'angder', '21-DEC-75', 144, 'mr.', 'm');


 select bc.a
from birthday_czar2 bc
where bc.c between '01-JAN-61' and '31-DEC-75'; 


--d. not visually I did not see any other changes.  Note I dropped the view above





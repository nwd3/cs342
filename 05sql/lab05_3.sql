--Excercise 5.3
--Nathanael Dick
--Exercise 5.3
--a
select p1.lastName||' , '||p1.firstName||' and '||p2.firstname||' - '||h1.phoneNumber||' - '||h1.street "Phonebook"from person p1, person p2, household h1
	where p1.householdId=p2.householdId
	and p1.id<p2.id
	and p1.householdID=h1.ID
	and p1.householdRole='husband'
	and p2.householdRole='wife'
;  

--b

select p1.lastName||' , '||p1.firstName||' and '||p2.firstname||' '||p2.lastName||' - '||h1.phoneNumber||' - '||h1.street "Phonebook"
from person p1, person p2, household h1
	where p1.householdId=p2.householdId
	and p1.id<p2.id
	and p1.householdID=h1.ID
	and p1.householdRole='husband'
	and p2.householdRole='wife'
; 
 

--c
select  p1.lastName||' , '||p1.firstName||' and '||p2.firstname||' '||p2.lastName||' - '||h1.phoneNumber||' - '||h1.street "Phonebook"
from person p1, person p2, household h1
	where p1.householdId=p2.householdId
	and p1.id<p2.id
	and p1.householdID=h1.ID
	and p1.householdRole='husband'
	and p2.householdRole='wife'
Union
select  p3.lastName||' , '||p3.firstName||' - '||h2.phoneNumber||' - '||h2.street
from person p3, household h2
	where p3.householdID=h2.ID
	and p3.householdRole='single'
;
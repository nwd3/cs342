--Exercise 6.2
--john from class and others helped on b and c
--a. yes this is doing a grouping of all the dates between the sysdate and the birthdate and then applying the aggregate 
--function average on them
select avg(TRUNC((months_between(SYSDATE,p.birthdate)/12),-1)) "average age"
	from person p;

--b.--john and others helped on b and c
select p.householdID, count(p.householdID) as t  --john helped me on this one and suggested I do it this way
	from person p, household h
		where p.householdID=h.id
		and h.city='Grand Rapids'
		group by householdID
		having count(p.householdID)>=2
		order by t desc;

--c
select p.householdID,h.phoneNumber, count(p.householdID) as t --john suggested I do it this way
	from person p, household h
		where p.householdID=h.id
		and h.city='Grand Rapids'
		group by p.householdID,h.phoneNumber
		having count(p.householdID)>=2
		order by t desc;

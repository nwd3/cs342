--Lab5
--Nathanael Dick

--Exercise 5.2
--a.
--rownum
 select * from (select firstname, lastname from person
where birthdate is not Null
order by birthdate desc)
where ROWNUM =1;

--without rownum
select firstname, lastname
from person
where birthdate in (select max(birthdate) from person);
--not correlated 

--some extra testing values
/*  INSERT INTO Person VALUES (19,'mr.','Keith','VanderLinden','m','m','07-FEB-1961',0,'husband',0,'member');

INSERT INTO Person VALUES (20,'mr.','Keith','VanderLinden','m','m','07-FEB-1961',0,'husband',0,'member');

INSERT INTO Person VALUES (220,'mr.','Keith','VanderLinden','m','m','07-FEB-1961',0,'husband',0,'member');

INSERT INTO Person VALUES (420,'mr.','Keith','VanderLinden','m','m','07-FEB-1961',0,'husband',0,'member'); */
--INSERT INTO Person VALUES (16,'mr.','f','sdfg','m','m','07-FEB-1961',0,'husband',1,'member');
--INSERT INTO PersonTeam VALUES (16,'Music','fd',NULL); */

--b.
--you may have some conflicts I am not sure
select Distinct one.id, one.firstname, one.lastname, two.id, two.firstname,two.lastname,three.id, three.firstname,three.lastname
from person one, person two, person three
where one.firstname=two.firstname 
and two.firstname=three.firstname 
and one.firstname=three.firstname 
and rownum <=3 and one.id !=two.id 
and two.id!=three.id 
and one.id!=three.id;

--c
--subselect query
SELECT p.firstname 
FROM personteam t, person p
WHERE t.personid=p.id
and t.teamname='Music'
 AND NOT EXISTS (SELECT *
                 FROM homegroup hg
                 WHERE hg.name='Byl'
				 and p.homegroupid = hg.id);
--This is correlated i am using p's id in the inner query which has to match up with the
--id in the outer query

				 
--set operations query				 
select p.firstname
from personteam t, person p
WHERE t.personid=p.id
and t.teamname = 'Music'
Minus
select pp.firstname
FROM homegroup hg, person pp
WHERE hg.name='Byl'
and pp.homegroupid = hg.id;
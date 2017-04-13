--homework 9
--Performance

CLEAR SCREEN;
SET AUTOTRACE ON;
SET SERVEROUTPUT ON;
SET TIMING ON;
SET WRAP OFF;
--Start of Query 1
/*  select m.name, m.id 
from Movie m, Director d, MovieDirector md
where d.lastName='Eastwood'
and d.firstName = 'Clint'
and md.DirectorId = d.id 
and m.id = md.movieId; */
--Explanation for query 1:
--1.
--I could have done it the using a subselect or by choosing the first name first in the
--where clause but not using the subselect is faster because you don't do two select 
--statements. Specifying the lastName first I believe may speed up the implementation because
--there are more people with Clint as the first name then with eastwood as the lastName.
	--my alternate implementations
--select m.name, m.id 
--from Movie m,Director d
--where d.lastName='Eastwood'
--and d.firstName = 'Clint'
--and m.id in (select MovieId from MovieDirector where 
		--		d.id = directorId);
 --select m.name, m.id 
--from Movie m, Director d, MovieDirector md
--where d.firstName = 'Clint'
--and d.lastName='Eastwood'
--and md.DirectorId = d.id 
--and m.id = md.movieId;
--2 
--The indexes my query used was the rowid for movie.  I think that was definitely the 
--right joice as you are getting the table with the most entries for the index.
--This alternate implementation does not use an index but of course than I do not include the name of the movie which I felt
--was necessary for this specific query
-- select md.movieId 
--from Director d, MovieDirector md
--where d.lastName='Eastwood'
--and  d.firstName = 'Clint'
--and md.DirectorId = d.id;
--3
--I made sure that my query had no superfluos data and that the selects were done in 
--such a way to ensure that the query was performed in the most efficient way.  For example
--I made sure that the lastName was selected first which limits directors by quite a bit.

--Start of Query 2
/* CREATE MATERIALIZED VIEW testview
  BUILD Immediate
  REFRESH COMPLETE
  AS
  select count(1), d.firstName, d.lastName
from movieDirector md, director d 
where md.directorId = d.id
group by d.firstName, d.lastName having count(md.movieId)>200;
select * from testview; */

--Explanation for query 2

--1.
-- I could have used several alternate implementation forms for example the one shown below.
--I chose to create a materialized view and then select from the materialized view because although the initial
--creation of the view takes some time the access from it is very efficient compared to querying it every time.
--I thought of using some of these alternate implementations
--alternate 2a
/* select count(1), d.firstName, d.lastName
from movieDirector md, director d 
where md.directorId = d.id
group by d.firstName, d.lastName having count(md.movieId)>0; */
--alternate 2b
/* select count(md.movieId), d.firstName, d.lastName
from movieDirector md, director d 
where md.directorId = d.id
group by d.firstName, d.lastName having count(md.movieId)>200; */

--2.
--The view I chose does not use any indexes because it is make a full access to the the materialized view.  This makes sense because of how
--my select statement is set up.

--3
--I attempted to ensure the accesses were eliminated for example the materialized view allows me to only have two accesses compared to 
--5 operations with the alternate query implementation.  This allows me to be much more efficient in how I access the database.

--Start of Query 3

SET AUTOTRACE TraceOnly;
select a.firstName, a.lastName, count(m.id)
from  movie m, role r, actor a
where m.rank > 8.5 
and m.id = r.movieId 
and a.id = r.actorId
group by a.firstName, a.lastName having count(m.id) >= 10;
--1.
--I felt like the query I chose was the best out of all the possible implementations because it had the most consistent gets 
--as you can see the difference between the query I chose is that in the from clause I have actor the order of the tables changed 
--this seems to make a difference and I have the order of the conditions in the where clause changed this seems to elimiante records earlier so that 
--I don not have to access them.
--I could have made a materialized view for this one and this may have been the way to go if you consistently use this query.

--Alternate implementation query 3a
select a.firstName, a.lastName, count(m.id)
from actor a, movie m, role r 
where a.id = r.actorId
and m.id = r.movieId 
and m.rank > 8.5
group by a.firstName, a.lastName having count(m.id) >= 10;
--I could have changed the operation to check if the movie count is 

--Alternate implementation query 3b

select a.firstName, a.lastName, count(m.id)
from actor a join role r on r.actorId = a.id 
join movie m on m.id =r.movieId 
and m.rank > 8.5
group by a.firstName, a.lastName having count(m.id) >= 10;

--2.
--No indexes were used for the query.  It did a hash join of the of the tables.  This seems to be what sql does when tables are being joined

--3 
--I made sure that I eliminated records early on that limit the number of records being accessed.  I limitied the rank right away and also
--how the tables were joined.

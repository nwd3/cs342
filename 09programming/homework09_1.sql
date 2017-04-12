--homework 9
CLEAR SCREEN;
SET AUTOTRACE ON;
SET SERVEROUTPUT ON;
SET TIMING ON;
SET WRAP OFF;

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
--Interesting if I just get the movie id from director(shown in the following query) a full access is used for director
--and movie director where you may think it would have been better to use an index
-- select md.movieId 
--from Director d, MovieDirector md
--where d.lastName='Eastwood'
--and  d.firstName = 'Clint'
--and md.DirectorId = d.id;
--3
--I made sure that my query had no superfluos data and that the selects were done in 
--such a way to ensure that the query was performed in the most efficient way.  For example
--I made sure that the lastName was selected first which limits directors by quite a bit.

/* select count(md.movieId), d.firstName, d.lastName
from movieDirector md, director d 
where md.directorId = d.id
group by d.firstName, d.lastName having count(md.movieId)>0; */

select count(1), d.firstName, d.lastName
from movieDirector md, director d 
where md.directorId = d.id
group by d.firstName, d.lastName having count(md.movieId)>0;
/* SET AUTOTRACE TraceOnly;
select a.firstName, a.lastName, count(m.id)
from actor a, movie m, role r 
where a.id = r.actorId
and m.id = r.movieId 
--and m.rank > 8.5
group by a.firstName, a.lastName having count(m.id) >= 0; */

/* SET AUTOTRACE TraceOnly;

select a.firstName, a.lastName, count(m.id)
from actor a, movie m, role r 
where a.id = r.actorId
and m.id = r.movieId 
--and m.rank > 8.5
group by a.firstName, a.lastName having count(m.id) between 0 and 10; */

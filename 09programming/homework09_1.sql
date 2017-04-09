--homework 9

select m.name, m.id 
from Movie m, Director d, MovieDirector md
where d.firstName = 'Clint'
and d.lastName='Eastwood'
and md.DirectorId = d.id 
and m.id = md.movieId;


select count(md.movieId), d.firstName, d.lastName
from movieDirector md, director d 
where md.directorId = d.id
group by d.firstName, d.lastName having count(md.movieId)>0;

select a.firstName, a.lastName, count(m.id)
from actor a, movie m, role r 
where a.id = r.actorId
and m.id = r.movieId 
and m.rank > 8.5
group by a.firstName, a.lastName having count(m.id) >= 10;
 --Exercise 6.1
 --a.
 --consider chair during join

select distinct t.name, t.mandate, p.id
	from team t
		left outer join PersonTeam
		on t.name = personTeam.teamName and PersonTeam.role = 'chair'
		LEFT JOIN person p on p.id = personTeam.personID;

--b

select distinct t.name, t.mandate, p.id, p.firstName,p.lastName
from team t
	left outer join PersonTeam
	on t.name = personTeam.teamName and PersonTeam.role = 'chair'
	LEFT Outer JOIN person p on p.id = personTeam.personID;

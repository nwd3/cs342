/* Exercise 4.1
	a. The relation is not well designed because every time you have to input more about someone like what team they are on  you have to input all this other unnecessary data that could be easily accessed via a foreign key referencing another table.  The worst part of the  design seems to be in the fact that the table could be easily split up into many relations where it would be easy to access the data.
	Formally: 1. Too many Null values. 
		      2. Redundant Information needs to be inputted every time you add something to the record.
		     3. You can't easily describe AltPerson(Is it a person a team a team person what is it?)
	
	b. I would do the following
		Person(ID, name, status, mentorId, mentorName )
		Team(ID, teamName, teamRole, teamTime)
		Mentor(ID, mentorName, mentorStatus)
		
Exercise 4.2

	a. The relations are in BCNF
		The functional Dependencies for Person Team are 
		personName,teamName--->
		The functional Dependencies for PersonVisit are
		personName, personVisit --->
		The relations are in 4NF as well the multivalued dependencies all have the superkey on the left hand side satisfying the definition of 4th NF
	b. The relations are in BCNF 

The relations are in 4NF because you need to have all parts of the relation to specify the key and thus you have a multivalued dependency on the left hand side with the super key

This means that they are not equally appropriate the view creates a better description of the data. */


-- This command file loads an experimental person relation.
-- The data conforms to the following assumptions:
--     * Person IDs and team IDs are unique for people and teams respectively.
--     * People can have at most one mentor.
--     * People can be on many teams, but only have one role per team.
--     * Teams meet at only one time.
--
-- CS 342
-- Spring, 2017
-- kvlinden

drop table Person;
drop table AltPerson;
drop table Mentor;

CREATE TABLE AltPerson (
	personId integer,
	name varchar(10),
	status char(1),
	mentorId integer,
	mentorName varchar(10),
	mentorStatus char(1),
    teamName varchar(10),
    teamRole varchar(10),
    teamTime varchar(10)
	);
	create table Mentor(
	mentorId integer primary key,
	mentorName varchar(10),
	mentorStatus char(1)
	);
Create table Person(
	personId integer primary key,
	name varchar(10),
	status char(1),
	mentorId integer,
	foreign key (mentorID) references Mentor(mentorId) on Delete Cascade
);



INSERT INTO AltPerson VALUES (0, 'Ramez', 'v', 1, 'Shamkant', 'm', 'elders', 'trainee', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'elders', 'chair', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'executive', 'protem', 'Wednesday');
INSERT INTO AltPerson VALUES (2, 'Jennifer', 'v', 3, 'Jeff', 'm', 'deacons', 'treasurer', 'Tuesday');
INSERT INTO AltPerson VALUES (3, 'Jeff', 'm', NULL, NULL, NULL, 'deacons', 'chair', 'Tuesday');
-- Query a combined "view" of the data of the form View(name, team, visit).
SELECT pt.personName, pt.teamName, pv.personVisit
FROM PersonTeam pt, PersonVisit pv
WHERE pt.personName = pv.personName;
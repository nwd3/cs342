-- lab 3.
-- Nathanael Dick
-- CS 342, Spring, 2017
-- kvlinden

--drop tables
DROP TABLE TeamRole;
DROP TABLE teams;
DROP TABLE Person;
DROP TABLE HouseHold;
DROP TABLE homegroups;

CREATE TABLE HouseHold(
	ID integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	state varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);
	
	--homegroup has a pretty basic structure I could add more details if it was necessary
CREATE TABLE homegroups(
	ID integer primary key,
	name varchar(45) NOT NULL --I want to have some name required	
	);
	
	--person has much of the attributes referenced and declared here
CREATE TABLE Person (
	ID integer PRIMARY KEY,
	h_id integer,  --refers to the homegroup id
	title varchar(4),
	firstName varchar(15),
	lastName varchar(15),
	mentee_id integer,
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c')),
	role varchar(13),
	hg_id integer,		--the homegroup id
	FOREIGN KEY (mentee_id) REFERENCES Person(id) ON DELETE SET NULL,  --here I SET null because you don't have to be a mentor or a mentee
	FOREIGN KEY (h_id) REFERENCES Household(ID) ON DELETE CASCADE,	   --here I SET cascade delete because you have to belong to at least one household
	FOREIGN KEY (hg_id) REFERENCES homegroups(ID) ON DELETE SET NULL   --here I SET null because you don't have to be in a homegroup
	);
	
	--teams REFERENCES person Id
CREATE TABLE teams(
	ID integer primary key,
	name varchar(10)
	);
	
	--here I decide to insist you have to have some role in a team even if it is null
	--team role allows the person to have a role in a team
CREATE TABLE TeamRole (
	role varchar(19),
	p_ID integer,
	team_id integer,
	start_Date date,
	end_Date date,
	FOREIGN KEY (p_ID) REFERENCES Person(ID) ON DELETE CASCADE,
	FOREIGN KEY (team_id) REFERENCES teams(ID) ON DELETE CASCADE
	);


--creating two households
INSERT INTO Household VALUES (10,'2347 Oxford Dr. SE','Grand Rapids','MI','49506','616-243-5680');
INSERT INTO Household VALUES (11,'3456 Wisco Dr. NE','Grand Rapids','MI','49525','616-436-4554');

--creating two seperate homegroups
INSERT INTO homegroups VALUES(100,'bibleclass');
INSERT INTO homegroups VALUES(101,'cooking group');

--creating several people
INSERT INTO Person VALUES (0,10,'mr.','Keith','VanderLinden','','m','elder',101);
INSERT INTO Person VALUES (1,10,'mrs.','Brenda','VanderLinden','','m','greeter',100);
INSERT INTO Person VALUES (2,11,'mr.','Jel','Java',0,'c','elder',100);
INSERT INTO Person VALUES (3,11,'mrs.','Sarah','Java',1,'c','greeter','');

--creating a couple of teams 
INSERT INTO teams values (13,'bibleclass');
--INSERT INTO teams values (13,'bibleclass');
INSERT INTO teams values (12,'happyhour');

--this is how i insert people into a team going off the idea that all members have a role even if it is null
INSERT INTO TeamRole values('treasurer',0,13,'12-FEB-1999','15,Jan-2016');
INSERT INTO TeamRole values('vice-treasurer',1,13,'12-FEB-1999','15,Jan-2016');
INSERT INTO TeamRole values('secretary',1,12,'12-FEB-1999','15,Jan-2016');
INSERT INTO TeamRole values('',0,12,'12-FEB-1999','15,Jan-2016');
INSERT INTO TeamRole values('',0,12,'12-FEB-1999','15,Jan-2016');
INSERT INTO TeamRole values('',1,12,'12-FEB-1999','15,Jan-2016');
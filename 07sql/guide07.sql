-- Sample version of the Movies database for guide 7 (copied from unit 6)
--
-- CS 342, Spring, 2017
-- kvlinden

-- Drop current database
DROP TABLE Casting;
DROP TABLE Movie;
DROP TABLE Performer;

-- Create database schema
CREATE TABLE Movie (
	id integer,
	title varchar(70) NOT NULL,
	year decimal(4),
	score float,
	votes integer,
	PRIMARY KEY (id),
	CHECK (year > 1900)
	);

CREATE TABLE Performer (
	id integer,
	firstName varchar(20),
	lastName varchar(25),
	PRIMARY KEY (id)
	);

CREATE TABLE Casting (
	movieId integer,
	performerId integer,
	status varchar(6),
	FOREIGN KEY (movieId) REFERENCES Movie(Id) ON DELETE CASCADE,
	FOREIGN KEY (performerId) REFERENCES Performer(Id) ON DELETE SET NULL,
	CHECK (status in ('star', 'costar', 'extra'))
	);

-- Load sample data
INSERT INTO Movie VALUES (1,'Star Wars',1977,8.9, 2000);
INSERT INTO Movie VALUES (2,'Blade Runner',1982,8.6, 1500);

INSERT INTO Performer VALUES (1,'Harrison', 'Ford');
INSERT INTO Performer VALUES (2,'Rutger', 'Hauer');
INSERT INTO Performer VALUES (3,'Chewbacca', NULL);
INSERT INTO Performer VALUES (4,'Rachael', NULL);
INSERT INTO Performer VALUES (5,'Rex', 'Harrison');

INSERT INTO Casting VALUES (1,1,'star');
INSERT INTO Casting VALUES (1,3,'extra');
INSERT INTO Casting VALUES (2,1,'star');
INSERT INTO Casting VALUES (2,2,'costar');
INSERT INTO Casting VALUES (2,4,'costar');
--1.
--a.
create view SimpleView
As SELECT id, firstName
	From Performer
	where lastName!='Ford';
	
	
--from docs.oracle.com and book	
--Base Tables:
--"previously defined views"

--Join Views:
--"specify more than one base table or view in the from clause"

--Updateable Join Views:
"(also referred to as a modifiable join view) is a view that contains more than one table in the top-level 
FROM clause of the SELECT statement, and is not restricted by the WITH READ ONLY clause."


--Key-Preserved Tables
--"A table is key-preserved if every key of the table can also be a key of the result of the join. 
--So, a key-preserved table has its keys preserved through a join."
---You Would want to use materialized views because you may:
--"Ease Network Loads
--Create a Mass Deployment Environment
--Enable Data Subsetting
--Enable Disconnected Computing"
--and this may be faster and more efficient than using a query updating system

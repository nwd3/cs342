-- This command file loads a simple movies database, dropping any existing tables
-- with the same names, rebuilding the schema and loading the data fresh.
-- lab02_1 updated some code
-- Name Nathanael Dick
-- February 10, 2017
-- CS 342, Spring, 2015
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
	votes float,
	PRIMARY KEY (id),
	CONSTRAINT Con1 CHECK ((year > 1900) AND (votes >1000 AND score IS NOT NULL))
	);


CREATE TABLE Performer (
	id integer,
	name varchar(35),
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
INSERT INTO Movie VALUES (1,'Star Wars',1977,8.9,1001.0);
INSERT INTO Movie VALUES (2,'Blade Runner',1982,8.6,1001.0);

--for exerciese 2.2 shows check constraint violated
--INSERT INTO Movie VALUES (6,'d d',1982,NULL,1001.0);


INSERT INTO Performer VALUES (1,'Harrison Ford');

INSERT INTO Performer VALUES (2,'Rutger Hauer');
INSERT INTO Performer VALUES (3,'The Mighty Chewbacca');
INSERT INTO Performer VALUES (4,'Rachael');

INSERT INTO Casting VALUES (1,1,'star');
INSERT INTO Casting VALUES (1,3,'extra');
INSERT INTO Casting VALUES (2,1,'star');
INSERT INTO Casting VALUES (2,2,'costar');
INSERT INTO Casting VALUES (2,4,'costar');


--Exercise 2.1
--a

--i.
--INSERT INTO Performer VALUES (4,'Nate');
--recieved error message
--ORA-00001: unique constraint (NWD3.SYS_C007007) violated
--this happens because you can't have another id value the same as another primary key because that violates what 
--a primary key is

--ii.
--INSERT INTO Performer VALUES (NULL,'Nate');
--reccived error message
--ORA-01400: cannot insert NULL into ("NWD3"."PERFORMER"."ID")
--this occurs because a primary key value has to have some entry in order to be a primary key value

--iii.
--INSERT INTO Movie VALUES (1,'Star Wars',1800,8.9);
--ORA-02290: check constraint (NWD3.SYS_C007033) violated
--this is because I inserted a value before 1800 which caused the constraint that the year
--of the movie had to be greater than 1900 to be violated

--iv.
--INSERT INTO Performer VALUES ('datatypeconstraintviolated','The Mighty Chewbacca');
--not inserting an integer

--v.
--INSERT INTO Movie VALUES (1,'Star Wars',1977,-8.9);
--ORA-00001: unique constraint (NWD3.SYS_C007048) violated
--violates constraint that the score be positive


--b.
--i.
INSERT INTO Movie VALUES (NULL,'Star Wars',1977,8.9);
--gives error ORA-01400: cannot insert NULL into ("NWD3"."MOVIE"."ID")
--can't insert a null value into a foreign key because the tables then
--are unable to talk to each other using that key

--ii.
--INSERT INTO Casting VALUES (10,1,'star');
--gives error: ORA-02291: integrity constraint (NWD3.SYS_C007065) violated - parent key not found
--not surprisingly because no movie id 10 exists so the table is looking for something that
--does not exist and gives an error

--iii.
--INSERT INTO Casting VALUES (2,4,'costar',23);
--ORA-00913: too many values
--not surprisingly you can't insert values that do not exist


--c.
--i
--DELETE FROM Movie
--WHERE id=2;
--INSERT INTO Casting VALUES (2,5,'hello');
--gives error: ORA-02290: check constraint (NWD3.SYS_C007176) violated
--this makes sense there is no id for that movie

--ii.
--DELETE FROM Casting
--WHERE Movieid=2;
--no error message unsurprisingly this deletes a reference but no other other record
--is dependent on this for its addition so it is allowed to be deleted

--iii.
--UPDATE MOVIE SET id=4
--WHERE id=2;
--INSERT INTO Casting VALUES (2,4,'costar');
--error: ORA-02291: integrity constraint (NWD3.SYS_C007212) violated - parent key not
--found

--there seems to be a variety of opinions about whether to use update cascade or not there does
--seem to be valid times when to use it or not though as discussed in toms article
--From what I learned in the article you should never do it because as he says
--"Primary keys are supposed to be imutable, never changing, constant. 
--It is an excessively bad practice to have to update them ever. If there 
--is a 0.00001% chance you will have to update a primary key -- then it is not a primary key, 
--its a surrogate key and you need to find the true primary key (even if you have to make it up
-- via a sequence) "


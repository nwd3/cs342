-- This command file loads a simple movies database, dropping any existing tables
-- with the same names, rebuilding the schema and loading the data fresh.

-- CS 342, Spring, 2015
-- kvlinden
--Nathan
--Nathanael Dick
--Exercise 2.4

--Exercise 2.4
--a. Not necessarily but you would have to know how many movies you have created to determine how much of the sequence has been
--used to know what values are being used in order to reference them as a performer.

--b. Yes because you don't know what values are being sequenced when you reference them in the command file there is no indication of where you have started
--the sequence or how many entities you have entered in order to access entities or insert entities.


--used online
--https://chartio.com/resources/tutorials/how-to-define-an-auto-increment-primary-key-in-oracle/
--http://stackoverflow.com/questions/11296361/how-to-create-id-with-auto-increment-on-oracle
--https://docs.oracle.com/database/121/RPTUG/tut_library.htm#RPTUG20400
--http://stackoverflow.com/questions/9733085/auto-increment-for-oracle
--http://www.datanamic.com/support/autoinc-oracle.html
--https://docs.oracle.com/cd/B28359_01/appdev.111/b28370/triggers.htm#BABGHACJ
--https://asktom.oracle.com/pls/apex/f?p=100:11:0::::P11_QUESTION_ID:6575961912937
--https://docs.oracle.com/database/121/RPTUG/tut_library.htm#RPTUG41562
--etc...

-- Drop current database
DROP TABLE Casting;
DROP TABLE Movie;
DROP TABLE Performer;
DROP SEQUENCE iddformovie_sequence;
-- Create database schema
CREATE TABLE Movie (
	id number(10),
	title varchar(70) NOT NULL, 
	year decimal(4), 
	score float,
	votes integer,
	PRIMARY KEY (id),
	CHECK (year > 1900)
	);
	

CREATE TABLE Performer (
	id integer,
	name varchar(35),
	PRIMARY KEY (id)
	);

CREATE TABLE Casting (
	movieId number,
	performerId integer,
	status varchar(6),
	FOREIGN KEY (movieId) REFERENCES Movie(Id) ON DELETE CASCADE,
	FOREIGN KEY (performerId) REFERENCES Performer(Id) ON DELETE SET NULL,
	CHECK (status in ('star', 'costar', 'extra'))
	);
	
CREATE SEQUENCE iddformovie_sequence 
	START WITH 1
	INCREMENT BY 1;



-- Load sample data
 INSERT INTO Movie VALUES (iddformovie_sequence.nextval,'Star Wars',1977,8.9, 2000);
INSERT INTO Movie VALUES (iddformovie_sequence.nextval,'Blade Runner',1982,8.6, 1500);

INSERT INTO Performer VALUES (1,'Harrison Ford');

INSERT INTO Performer VALUES (2,'Rutger Hauer');
INSERT INTO Performer VALUES (3,'The Mighty Chewbacca');
INSERT INTO Performer VALUES (4,'Rachael');

INSERT INTO Casting VALUES (1,1,'star');
INSERT INTO Casting VALUES (2,1,'star');
INSERT INTO Casting VALUES (2,1,'star');
INSERT INTO Casting VALUES (2,2,'costar');
INSERT INTO Casting VALUES (2,4,'costar');

--Exercise 2.3
--In oracle enum is not supported in mysql you can use enum
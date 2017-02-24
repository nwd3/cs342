
/* Exercise 4.2
	a. The relations are in BCNF
		The functional Dependencies for Person Team are 
		personName,teamName--->
		The functional Dependencies for PersonVisit are
		personName, personVisit --->
		The relations are in 4NF as well the multivalued dependencies all have the superkey on the left hand side(there are no multivalued dependencies) satisfying the definition of 4th NF
	b. The relations are in BCNF there are no functional dependencies so by the definition of functional dependencies the canidate key is on the left and the 
relation is in BCNF. 	

The relations are not in 4NF because you need to have all parts of the relation to specify the key and you create a relation with a no canidate key on the left for the multivalued dependency.
If he visits on April 5 then you would have to update the elders and the executive records.  In this case only 2 records but the list could grow if he attends church more often.
Formal: The multivalued dependencies are taht the date, person --> team  
The problem is that date and person is not a superkey thus the table is not in 4NF by the definition of 4NF.
This means that they are not equally appropriate the view creates a better description of the data.
	
	c.  The views are not as equally appropriate because you are creating a multivalued dependency problem for the view table.  In the previous table you did not have to update the 
	previous relations every time you added a visit while in the view table you do so this does not work well if you want to add many visits.  Consequently the part a schematia is better.
	The choice does depend on the context for example if everyone notes that he attends and the table is updated appropriately.
 */




-- This command file loads an experimental person database.

-- The data conforms to the following assumptions:

--     * People can have 0 or many team assignments.

--     * People can have 0 or many visit dates.

--     * Teams and visits don't affect one another.

--

-- CS 342, Spring, 2017

-- kvlinden



DROP TABLE PersonTeam;
DROP TABLE PersonVisit;



CREATE TABLE PersonTeam (
	personName varchar(10),
    teamName varchar(10)
	);


CREATE TABLE PersonVisit (
	personName varchar(10),
    personVisit date
	);



-- Load records for two team memberships and two visits for Shamkant.

INSERT INTO PersonTeam VALUES ('Shamkant', 'elders');
INSERT INTO PersonTeam VALUES ('Shamkant', 'executive');
INSERT INTO PersonVisit VALUES ('Shamkant', '22-FEB-2015');
INSERT INTO PersonVisit VALUES ('Shamkant', '1-MAR-2015');

-- Query a combined "view" of the data of the form View(name, team, visit).

SELECT pt.personName, pt.teamName, pv.personVisit
FROM PersonTeam pt, PersonVisit pv
WHERE pt.personName = pv.personName;
--Exercise 10.4
--Nathanael Dick

select rank from Movie where id =238071;
Set transaction read write;
CREATE OR REPLACE PROCEDURE incrementRank
	(movieIdIn IN Movie.id%type, 
	 deltaIn IN integer
    ) AS
	x Movie.rank%type;
BEGIN
	FOR i IN 1..50000 LOOP
LOCK TABLE movie
   IN EXCLUSIVE MODE;
		SELECT rank INTO x FROM Movie WHERE id=movieIdIn;
		UPDATE Movie SET rank=x+deltaIn WHERE id=movieIdIn;
			dbms_output.put_line( 'This is x ' || x);
		COMMIT;
	END LOOP;
END;
/


select rank from Movie where id =238071;
 EXECUTE incrementRank(238071, 1);
 
 --Explanation
 --I was able to lock the table every time an update was change and both tables were allowed
-- to update their data without any problem
--I locked the tables exclusively so they write to each other exclusively
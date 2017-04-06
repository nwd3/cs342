--Homework08_2
--Nathanael Dick
--Calculates the Bacon Number based on a given actor	
	
drop table BaconTable;

create table BaconTable(
actorId integer,
BaconNumber integer
);

--this function gets the current number of actors
CREATE or replace FUNCTION countit RETURN INTEGER AS
counter integer;
BEGIN
  select count(id) into counter from actor;
  return counter + 2;
END countit;
/

--this procedure drives the procedure that inserts the 
--actors and their bacon numbers into the baconTable
CREATE OR REPLACE PROCEDURE BaconNumber3 (actorIDIn IN actor.id%type, currentBacNumber in integer) as
	counter integer;
Begin
	select count(id) into counter from actor;
	if currentBacNumber = 0 then
		insert into BaconTable values(actorIDIn, 0);
	end if;
	if currentBacNumber < countit() then
		for get2 in (select actorID from baconTable where baconnumber = currentBacNumber) loop
			BaconNumber4(get2.actorID, currentBacNumber + 1);
		end loop;
	BaconNumber3(actorIDIn, currentBacNumber + 1);
	end if;
END;
/

--this function inserts the actors with their bacon numbers based on the current bacon number
--and the specific actor gotten from procedure BaconNumber4
CREATE OR REPLACE PROCEDURE BaconNumber4 (actorIDIn IN actor.id%type, currentBaconNumber in integer) as
Begin
	for get2 in (select * from role where actorIDIn = actorID) loop
		for get3 in (select * from role where actorID not in (select actorID from BaconTable)) loop
			if get3.movieId = get2.movieId then
				insert into BaconTable values(get3.actorID, currentBaconNumber);
			end if;
		end loop;
	end loop;
END;
/


--Kevin Bacon's Bacon Number
  BEGIN  BaconNumber3(22591, 0);  END;
/


--Works for any actorID
 --BEGIN  BaconNumber3(801698);  END;
-- / 

--outputs results
select * from BaconTable;
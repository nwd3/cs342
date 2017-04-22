--Reference for count part https://asktom.oracle.com/pls/asktom/f?p=100:11:0::::P11_QUESTION_ID:3069487275935
--Homework10
select rank from movie where id =176711;
select rank from movie where id =176712;
CREATE OR REPLACE PROCEDURE transferRank(srcID in movie.id%type, destID in movie.id%type, trRank in movie.rank%type)
as
	except1 EXCEPTION;
	except2 EXCEPTION;
	except3 EXCEPTION;
	rankTransferValid integer;
	checkIfSrcEx integer;
	checkIfDestIdEx integer;
BEGIN

--set variables
	select rank into rankTransferValid from movie where id = srcID;
	
	select COUNT(*) INTO checkIfSrcEx FROM Movie
		WHERE srcID = id;
		
	select COUNT(*) INTO checkIfDestIdEx FROM Movie
		WHERE destID = id;
		
	--checks the rank is valid
	if rankTransferValid <=trRank then 
		RAISE except1;
	end if;
	
	--checks if the srcID movie in the Movie Table
 	if checkIfSrcEx <= 0 then 
		raise except2;
	end if;
	
		--checks if the destID movie in the Movie Table
 	if checkIfDestIdEx <= 0 then 
		raise except3;
	end if;
	
	--update the movies transferRank
	update movie
		set rank = rank - trRank
		where id = srcID;
	select rank into rankTransferValid from movie where id = destID;
	
	
	--checks the rank is valid
	if rankTransferValid <=trRank then 
		RAISE except1;
	end if;
	
	--transferRank rank to the dest movie
	update movie 
		set rank = rank + trRank
		where id = destID;
		
		--EXCEPTIONs
		EXCEPTION
			WHEN except1 THEN	--exception checks to see if you can subtract rank from the movie validly			
		rollback;
			WHEN except2 THEN	--exception checks to see if srcID MOVIE exists
		 RAISE_APPLICATION_ERROR(-20001, 'srcID ' || srcID ||
    	' is not in the Movie Table ');
			WHEN except3 THEN	--exception checks to see if srcID MOVIE exists
		 RAISE_APPLICATION_ERROR(-20001, 'destID ' || destID ||
    	' is not in the Movie Table ');
		
		
END;
/


BEGIN
	FOR i IN 1..10000 LOOP
		transferRank(176712, 176711, .1);
		COMMIT;
		transferRank(176711, 176712, .1);
		COMMIT;
	END LOOP;
END;
/
select rank from movie where id =176711;
select rank from movie where id =176712;

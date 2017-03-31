--I did have an implementation of the procedure without a trigger but I heard 
--someone saying it would be better to do it with a trigger so I did the 
--checking with the trigger 
--Lab08
--8.1
--Nathanael Dick
--March 31

 CREATE or replace TRIGGER badInsert BEFORE INSERT ON Role FOR each row
DECLARE
  counter INTEGER;
  cantinsert EXCEPTION;
BEGIN
  SELECT COUNT(*) INTO counter FROM Role
    WHERE actorID = :new.actorID
	and movieID = :new.movieID
	and role = :new.role;
  dbms_output.put_line('Checking IF Record Exists');
  IF counter >=1 THEN
	raise cantinsert;
  END IF;
EXCEPTION
  WHEN cantinsert THEN
    RAISE_APPLICATION_ERROR(-20001,'cant insert: '||:new.movieid ||', '|| :new.actorID ||', ' || :new.role ||' -> the record already exists');
END;
/

 CREATE or replace PROCEDURE casting2
(actorIdIn IN actor.ID%type,movieIDIN IN movie.ID%type, roleIn In Role.role%type) AS
  counter INTEGER;
BEGIN
  INSERT INTO Role(actorID, movieID, role)
  	VALUES (actorIdIn, movieIDIN, roleIn);
  dbms_output.put_line('actor ' || actorIdIn ||
  	' was cast into ' || movieIDIN || ' as ' || roleIn);
END;
/

Begin casting2(89558, 238072, 'Danny Ocean'); End;
/

Begin casting2(89558, 238073, 'Danny Ocean'); End;
/

Begin casting2(89558, 167324, 'Danny Ocean'); End;
/
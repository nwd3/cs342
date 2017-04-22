--Project 4 triggers


--this checks before the insert of a customer if the customer already exists
CREATE or replace TRIGGER badInsert BEFORE INSERT ON Customer FOR each row
DECLARE
  counter INTEGER;
  cantinsert EXCEPTION;
BEGIN
  SELECT COUNT(*) INTO counter FROM Customer
    WHERE cust_num = :new.cust_num;
  dbms_output.put_line('Checking IF Record Exists');
  IF counter >=1 THEN
	raise cantinsert;
  END IF;
EXCEPTION
  WHEN cantinsert THEN
    RAISE_APPLICATION_ERROR(-20001,'cant insert: '||:new.cust_num ||' -> the record already exists');
END;
/

--order more parts
CREATE or replace TRIGGER orderMoreParts BEFORE update of quanity ON part FOR each row
DECLARE
  quanityIn INTEGER;
  orderMoreParts EXCEPTION;
BEGIN
select quanity into quanityIn from parts;
if new:quanity <=5
  dbms_output.put_line('Checking if there is enough parts');
  	raise orderMoreParts;
  END IF;
EXCEPTION
  WHEN orderMoreParts THEN
    RAISE_APPLICATION_ERROR(-20001,'cant order this part because you only have: '|| quanityIn || ' parts left');
	END;
/
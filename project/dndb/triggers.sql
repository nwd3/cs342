--Project 4 triggers
--these can be useful to updating the records on the database

--this checks before the insert of a customer if there already exists a customer with the exact
--same first and last name in order to update their address is needed.
CREATE or replace TRIGGER badInsert BEFORE INSERT ON Customer FOR each row
DECLARE
  counter INTEGER;
  cn integer;
  cantinsert EXCEPTION;
BEGIN
  SELECT COUNT(*) INTO counter FROM Customer
    WHERE firstname = :new.firstname
	and lastname = :new.lastname;
  dbms_output.put_line('Checking IF Record Exists');
  select cust_num into cn from customer 
	where firstname=:new.firstname
	and lastname=:new.lastname;
  IF counter >=1 THEN
	raise cantinsert;
  END IF;
EXCEPTION
  WHEN cantinsert THEN
    RAISE_APPLICATION_ERROR(-20001,'Note: '||new:firstname||' '||:new.lastname|| ' A customer with that name already exists make sure that this customers address is up to date'||
	'the customer with that same customer number is: '||cn);
END;
/

--order more parts
--if the number of parts becomes to low I cause a error message to be displayed that tells us to order more parts
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

--ensures when the review is low we take a good look at it
CREATE or replace TRIGGER ReviewResolved BEFORE INSERT ON reviews FOR each row
DECLARE
  revNum INTEGER;
  customerNumber integer;
  takeCareOfBadReview EXCEPTION;
BEGIN
	select star_review into revNum from parts;
	select o.cust_num into customerNumber from parts p, orders o 
		where p.order_num = o.order_num;
	if new:revNum <3
		raise orderMoreParts;
  END IF;
EXCEPTION
  WHEN takeCareOfBadReview THEN
    RAISE_APPLICATION_ERROR(-20001,'You need to make sure this customer'||customerNumber|| 'is satisfied because the review is under 3 stars'|| revNum);
	END;
/


--Procedures Project 4 Application
--this procedure drives the procedure that inserts the 
--actors and their bacon numbers into the baconTable
--my idea is to create a transaction procedure
--I tried to make the queries complex as possible but I mostly focused on making them useful
--Which I believe I accomplished.  Now inserting customers etc into the database is vastly easier
--and the procedure does all the work
--Note I tested these procedures on the bottom
--Note I locked the whole tables because I thought this would be a good solution for the my implementation

--these are all helper functions
CREATE or replace FUNCTION nextCN RETURN INTEGER AS
counter integer;
BEGIN
Lock table customer;
  select max(cust_num) into counter from customer;
  return counter + 1;
END nextCN;
/
CREATE or replace FUNCTION nextON RETURN INTEGER AS
counter integer;
BEGIN
  Lock table orders;
  select max(order_num) into counter from orders;
  return counter + 1;
END nextON;
/
CREATE OR REPLACE Function getPartId(partnameIN in part.part_name%type)
return integer
as
PartId integer;
Begin
	Lock table part;
	select * into PartId from(select part_num from part where part_name = partnameIN) where rownum =1;
	return PartId;
End;
/

CREATE OR REPLACE function getOpenEmployee
return integer
as
empNumber integer;
Begin
	Lock Table Employee;
	select employee_number into empNumber from empOpView where rownum =1;
	return empNumber;
End;
/

--Here are my procedures

--this procedure allows me to add to the order parts 
--it alsow updates the part database
--note see triggers to see that the parts available are checked to see if we need to order more parts
CREATE OR REPLACE PROCEDURE AddToOrder(nextONR in integer, partnameIn in part.part_name%type,quanityIn in integer)
as 
	PartId integer;
	custNUM integer;
begin 
--added this part
	Lock table customer;
	select cust_num into custNUM from orders where nextONR = order_num;
	insert into partorder values (PartId,nextONR,quanityIn);
	updatePartTableOnOrder(getPartId(partnameIN),quanityIn);
	
	commit customer;
	dbms_output.put_line( 'You have added to order number: ' || nextONR || 'for customer ' || custNUM || 'To add more to this order you can run the AddToOrder Procedure again.' );

end;
/

--updates the part table on an order so the quanity is subtracted 
--very helpful to keep the part table up to date
CREATE OR REPLACE PROCEDURE updatePartTableOnOrder(partId in part.part_num%type, quanityIn in part.quantity%type)
as
Begin
--added this part
	Lock table part;
	update part
		set quantity = quantity - quanityIn
		where part_num = PartId;
	commit;
End;
/

--this updates the part table when a new shipment of parts has arrived
CREATE OR REPLACE PROCEDURE updatePartTableOnNew(partId in part.part_num%type, quanityIn in part.quantity%type)
as
Begin
	Lock table part;
	update part
		set quantity = quantity + quanityIn
		where part_num = PartId;
	commit;
End;
/

--this allows me to add a customer and an order at the same time
--I did this together because most of the time when we add a customer
--we also add a order at the same time
CREATE OR REPLACE PROCEDURE ADDCUSTOMERAndOrder(firstNameIN in customer.firstName%type,
	lastnameIn in  customer.lastname%type,
	email_addressIn customer.email_address%type,
	shipping_AddressIn in customer.shipping_Address%type,
	genderIn in  customer.gender%type,
	phone_numberIn in customer.phone_number%type,
	streetIn in customer.street%type,
	cityIn in customer.city%type,
	stateIn in customer.state%type,
	zipcodeIn in customer.zipcode%type,
	transactionNY in integer,
	partnameIN in part.part_name%type,
	num_of_products in part.quantity%type) as
	nextONR integer;
	nextCNR integer;
	pid integer;
	
Begin
	--added this part
	lock table customer;
	nextCNR := nextCN();
	INSERT INTO customer
				VALUES (nextCNR,firstNameIn, lastnameIn,
				email_addressIn,
				shipping_AddressIn,
				genderIn,
				phone_numberIn,
				streetIn,
				cityIn,
				stateIn,
				zipcodeIn);
	--this checks to see if a transaction was desired by the person that inserted the customer
	
	if transactionNY = 1 then
		nextONR := nextON();
		insert into orders values (nextONR,sysdate,sysdate + 120/24,'',getOpenEmployee(),nextCNR,num_of_products,8253);
		commit;
		updatePartTableOnOrder(getPartId(partnameIN), num_of_products);
		--output an informative message
		dbms_output.put_line( 'You have created orderNumber: ' || nextONR || 'for customer ' || nextCNR || 'To add more to this order you can run the AddToOrder Procedure');
		commit;
	end if;
	commit;
END;
/

---This is our other alternative we have a scenario where we just input a 
--customer that we get without any orders
CREATE OR REPLACE PROCEDURE ADDCUSTOMER(firstNameIN in customer.firstName%type,
	lastnameIn in  customer.lastname%type,
	email_addressIn customer.email_address%type,
	shipping_AddressIn in customer.shipping_Address%type,
	genderIn in  customer.gender%type,
	phone_numberIn in customer.phone_number%type,
	streetIn in customer.street%type,
	cityIn in customer.city%type,
	stateIn in customer.state%type,
	zipcodeIn in customer.zipcode%type) as
	nextONR integer;
	nextCNR integer;
	pid integer;
Begin
	Lock table customer;
	nextCNR := nextCN();
	INSERT INTO customer
				VALUES (nextCNR,firstNameIn, lastnameIn,
				email_addressIn,
				shipping_AddressIn,
				genderIn,
				phone_numberIn,
				streetIn,
				cityIn,
				stateIn,
				zipcodeIn);
	commit;
END;
/

--this allows us to update the expected ship date ect
CREATE OR REPLACE PROCEDURE shipped(orderNumIn in orders.order_num%type)
as
Begin
	Lock table orders;
	update orders
		set act_ship_date=sysdate
		where order_num = orderNumIn;
	commit;
End;
/


--testing these procedures

BEGIN ADDCUSTOMERAndOrder('Nissim','Deleon','dictum.eu@odioNam.co.uk','Duis ac',
'm','(624) 503-3443','Ap #206-9428 Diam St.','Charny','QC','40517',1,'boltaction pen',3); END;
/

BEGIN ADDCUSTOMER('Nissim','Deleon','dictum.eu@odioNam.co.uk','Duis ac',
'm','(624) 503-3443','Ap #206-9428 Diam St.','Charny','QC','40517'); END;
/

BEGIN shipped(128); END;
/

Begin updatePartTableOnNew(1, 14); END;
/

--most of the rest are used in the above procedures

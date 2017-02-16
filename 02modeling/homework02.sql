-- CS 342, Spring, 2017
--Nathanael Dick
--Homework2 
1.Exercise 5.14
see code below

2. Exercise 5.20. a & c
I would suggest to CIT that they leave the surrogate id numbers in place for the following reasons.
First: If they changed identification to say numbers describing date of birth several people may have been born on the same day.
Second: The formatting of surrogate id numbers is controlled by CIT and CIT can format and add id numbers as they desire.

3. See code below

--references more were also used
--http://stackoverflow.com/questions/278392/should-i-use-the-cascade-delete-rule
--http://stackoverflow.com/questions/59297/when-why-to-use-cascading-in-sql-server
--https://www.w3schools.com/sql/sql_dates.asp
--saw this for not null part
--https://www.techonthenet.com/oracle/isnotnull.php
--http://stackoverflow.com/questions/208493/search-all-fields-in-all-tables-for-a-specific-value-oracle

-- Drop current database
DROP TABLE SHIPMENT;


DROP Table Order_Item;
DROP TABLE Item;
DROP TABLE Orders;
DROP TABLE CUSTOMER;
Drop TABLE warehouse;
CREATE TABLE CUSTOMER(
	cust_id integer primary key,
	f_name varchar(100) Not NULL,--I want to require that the customers have a name
	l_name varchar(100) Not NULL,
	city varchar(100),
	CHECK (cust_id > 0)--my desired naming convention
);

CREATE TABLE Orders(
	order_num integer primary key,
	Odate date,
	cust_id integer,
	Ord_amt float,
	Check (Ord_amt > 0),
	Check (order_num > 0),--I want to have positve order_num values
--I use delete cascade here because if the customer is deleted i just want to delete the entire record
	foreign key (cust_id) references CUSTOMER(cust_id) On DELETE CASCADE
);


CREATE TABLE Item(
	item_num integer primary key,
	Unit_price integer NOT NULL, --I want some price even if it is zero		
	item_name varchar(100) Not NULL  --I want to require a name for my item
);

Create Table Order_Item(
	order_num integer,
	item_num integer,
	Qty integer,
	Check (Qty >0), --The quantity had better be something
--same thing as above when I delete order_num I am most likely deleting the entire order so I just delete on cascade
	foreign key (order_num) references Orders(order_num)On DELETE CASCADE,
--here I want to add the option to change the item number
	foreign key (item_num) references Item(item_num) ON DELETE CASCADE
);

Create table warehouse(
	warehouse_num integer primary key,
	city varchar(100)
);

CREATE TABLE SHIPMENT(
	order_num integer,
	warehouse_num integer,
	ship_date date,
--same thing as above when I delete order_num I am most likely deleting the entire order so I just delete on cascade
	foreign key (order_num) references Orders(order_num) On DELETE CASCADE,
	--I am deciding that item doesnot have to be in the warehouse so I set it to null on delete
	foreign key (warehouse_num) references warehouse(warehouse_num) ON DELETE SET NULL
);




INSERT INTO CUSTOMER VALUES (1,'Nathanael','Dick','Grand Rapids');
INSERT INTO CUSTOMER VALUES (2,'Case','Hasen','Louiville');
INSERT INTO CUSTOMER VALUES (3,'Luke','Tenier','Boston');
INSERT INTO CUSTOMER VALUES (4,'Frank','Palmesn','Miami');
INSERT INTO CUSTOMER VALUES (5,'Frances','Saterne','Detroit');

INSERT INTO Orders VALUES (1,'01-JAN-2016' , 1, 23.2);
INSERT INTO Orders VALUES (2, '01-JAN-2017', 2, 2325);
INSERT INTO Orders VALUES (3, '31-JAN-2017', 2, 32);
INSERT INTO Orders VALUES (4, '11-Feb-2017', 2, 32);
INSERT INTO Orders VALUES (7,'01-JAN-2017', 4, 239);
INSERT INTO Orders VALUES (8, '01-JAN-2017', 3, 873.23);
INSERT INTO Orders VALUES (5, '01-JAN-2017', 5, 65);

INSERT into item VALUES(1, 24, 'book');
INSERT into item VALUES(12, 243, 'hat');
INSERT into item VALUES(9, 23, 'toothbrush');

INSERT INTO ORDER_Item VALUES(1,1,4);
INSERT INTO ORDER_Item VALUES(1,12,4);
INSERT INTO ORDER_Item VALUES(2,9,4);
INSERT INTO ORDER_Item VALUES(2,1,4);

Insert into Warehouse VALUES (145,'West Las');
Insert into Warehouse VALUES (146,'Grand Rapids');
Insert into Warehouse VALUES (148,'Lansing');

Insert into SHIPMENT VALUES (1,145,'01-JAN-98');
Insert into SHIPMENT VALUES (2,146,'01-JAN-1998');
Insert into SHIPMENT VALUES (3,146,'01-JAN-1998');
Insert into SHIPMENT VALUES (4,148,'01-JAN-1998');


--hw2 question 3a.
select Odate,Ord_amt from Orders,Customer
	where Customer.f_name like 'Case' AND 
	Customer.l_name like 'Hasen' And
	Customer.cust_id=Orders.cust_id
	Order By Odate DESC;

--hw2 question 3 b.
select DISTINCT Orders.cust_id from Orders
	Join CUSTOMER ON	
	Orders.cust_id=Customer.cust_id
	Order By cust_id ASC;
	
	
--hw2 question 3 c.
select customer.cust_id, customer.f_name, customer.l_name 
	from orders, customer, order_item, item 
	where customer.cust_id=orders.cust_id 
	And orders.order_num = Order_item.order_num
	And Order_item.item_num=Item.item_num 
	And Item.item_name like 'toothbrush';

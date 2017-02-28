-- Drop current database
--http://stackoverflow.com/questions/278392/should-i-use-the-cascade-delete-rule
--http://stackoverflow.com/questions/59297/when-why-to-use-cascading-in-sql-server
--https://www.w3schools.com/sql/sql_dates.asp
--saw this for not null part
--https://www.techonthenet.com/oracle/isnotnull.php
--http://stackoverflow.com/questions/208493/search-all-fields-in-all-tables-for-a-specific-value-oracle
Drop TABLE warehouse;
DROP TABLE SHIPMENT;
DROP TABLE Item;
DROP Table Order_Item;
DROP TABLE Orders;
DROP TABLE CUSTOMER;

CREATE TABLE CUSTOMER(
Cust# integer primary key,
f_name varchar(100) Not NULL,
l_name varchar(100) Not NULL,
City varchar(100),
CHECK (Cust# > 0)
);

CREATE TABLE Orders(
Order# integer primary key,
Odate date,
cust# integer,
Ord_amt float,
Check (Ord_amt > 0),
--I use delete cascade here because if the customer is deleted i just want to delete the entire record
foreign key (cust#) references CUSTOMER(Cust#) On DELETE CASCADE 
);

Create Table Order_Item(
Order# integer UNIQUE,
Item# integer primary key,
Qty integer,
Check (Qty >0),
--same thing as above when I delete order# I am most likely deleting the entire order so I just delete on cascade
foreign key (order#) references Orders(Order#)On DELETE CASCADE 
);

CREATE TABLE Item(
item# integer primary key,
Unit_price integer,
item_name varchar(100) Not NULL,
--I use the set null deltete here because the item# could be deleted but attributes of the item still exist
foreign key (item#) references Order_Item(Item#) ON DELETE SET NULL
);

CREATE TABLE SHIPMENT(
order# integer UNIQUE,
warehouse# integer primary key,
ship_date varchar(10),
--same thing as above when I delete order# I am most likely deleting the entire order so I just delete on cascade
foreign key (order#) references Orders(Order#) On DELETE CASCADE 
);

Create table warehouse(
warehouse# integer primary key,
City varchar(100),
--here the warehouse number could be deleted and the warehouse still exist
foreign key(warehouse#) references SHIPMENT(warehouse#) ON Delete set null
);
INSERT INTO CUSTOMER VALUES (1,'Nathanael','Dick','Grand Rapids');
INSERT INTO CUSTOMER VALUES (2,'Case','Hasen','Louiville');
INSERT INTO CUSTOMER VALUES (3,'Luke','Tenier','Boston');
INSERT INTO CUSTOMER VALUES (4,'Frank','Palmesn','Miami');
INSERT INTO CUSTOMER VALUES (5,'Frances','Saterne','Detroit');

INSERT INTO Orders VALUES (1,'01-JAN-98' , 1, 23.2);




--hw2 question 3a.
select Odate,Ord_amt from Orders
Order By Odate DESC;

--hw2 question 3 b.
select Orders.Cust#,Customer.f_name,Customer.l_name, from Orders, Customer
Where Orders.cust# like Customer.Cust#;

--hw2 question 3 c.
select cust#, f_name from orders, item
where item_name is not null;

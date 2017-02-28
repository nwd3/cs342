DROP TABLE Customer;
DROP TABLE Orders;
--DROP TABLE ORDER_o;
--DROP TABLE Order_Item;
--DROP TABLE ITEM;
--DROP TABLE SHIPMENT;
--ROP TABLE Warehouse;
-- Create database schema
CREATE TABLE Customer(
	Custaa integer,
	Cname varchar(70) NOT NULL, 
	City varchar(70),
	--PRIMARY KEY (Custaa)
	);
CREATE TABLE Orders(
Order_number integer,
Odate varchar(70),
Cust_number integer,
Ord_amt float,
--PRIMARY KEY(Order_number),
FOREIGN KEY(Order_number)REFERENCES Customer(Custaa)ON DELETE CASCADE
);
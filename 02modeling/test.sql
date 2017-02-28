-- This command file loads a simple Orderss database, dropping any existing tables
-- with the same names, rebuilding the schema and loading the data fresh.
--
-- CS 342, Spring, 2015
-- kvlinden

-- Drop current database
DROP TABLE Customer;
DROP TABLE Orders;
DROP TABLE Order_o;

-- Create database schema
CREATE TABLE Orders (
	id integer,
	title varchar(70) NOT NULL, 
	year decimal(4), 
	score float,
	votes integer,
	PRIMARY KEY (id),
	CHECK (year > 1900)
	);

CREATE TABLE Order_o (
	id integer,
	name varchar(35),
	PRIMARY KEY (id)
	);

CREATE TABLE Customer (
	OrdersId integer,
	Order_oId integer,
	status varchar(6),
	FOREIGN KEY (OrdersId) REFERENCES Orders(Id) ON DELETE CASCADE,
	FOREIGN KEY (Order_oId) REFERENCES Order_o(Id) ON DELETE SET NULL);
--CHECK (status in ('star', 'costar', 'extra'))

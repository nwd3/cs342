-- homework 3.
-- Nathanael Dick
-- CS 342, Spring, 2017
-- kvlinden
 drop table partorder;
 drop table orders;
 drop table employees;
 drop table part;
 drop table customer;
 
create table employees(
	employee_number integer primary key,
	firstName varchar(14),
	lastname varchar(13),
	zip integer
);

create table part(
	part_num integer primary key,
	quantity integer,
	part_name varchar(10),
	price float
);
 create table customer(
	cust_num integer primary key,
	firstName varchar(10),
	lastname varchar (10),
	zip integer
); 


create table orders(
	order_num integer primary key,
	date_ordered date,
	exp_ship_date date,
	act_ship_date date,
	part_num integer,
	employee_number integer, --specifications say assign to an employee
	cust_num integer,
	quantity integer Check (quantity >0),  --note specifications call for at least one part to be purchased
	
	--these foreign keys reference the part22 table I delete set null because if you delete a part you don't delete a order necessarily
	foreign key (part_num) references part(part_num) on delete set null,
	
	--these foreign keys reference the employee table this is set to delete on null because if you delete an employee record you don't delete a order necessarily
	foreign key (employee_number) references employees(employee_number) on delete set null,
	--these foreign keys reference the customer table I delete set null because if you delete then you better delete the order
	foreign key (cust_num) references customer(cust_num) on delete set null
);

--I decided to create a parorder table so I could enter multiple values into an order
--I did this because the specifications call for a unique order number to be enforced and
--it seems easier to add parts to an order.
create table partorder(
part_num integer,
order_num integer,
quantity integer,
foreign key (part_num) references part(part_num) on Delete Cascade,
foreign key (order_num) references orders(order_num) on Delete Cascade
);

insert into employees values(1,'jack','davins',3423);
insert into employees values(2,'jack','davins',3423);
insert into employees values(3,'jack','davins',3423);

insert into part values(1001,11,'wrench',10.01);
insert into part values(1221,11,'wrench',10.01);
insert into part values(1231,11,'wrench',10.01);

insert into customer values(100,'Bill','Harris',2323);
insert into customer values(101,'Bill','Harris',2323);
insert into customer values(102,'Bill','Harris',2323);

insert into orders values(0,'12-FEB-1999','22-FEB-1999','15-FEB-1999',1001,1,100,1);
insert into partorder values(1001,0,2);
insert into partorder values(1001,0,23);
insert into orders values(1,'16-FEB-1999','22-FEB-1999','17-FEB-1999',1221,1,100,12);
insert into orders values(2,'19-FEB-1999','22-FEB-1999','24-FEB-1999',1221,1,100,1);

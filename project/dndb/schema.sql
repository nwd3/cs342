create table employees(
	employee_number integer primary key,
	firstName varchar(1400),
	lastname varchar(1300),
	email_address varchar(1500)
);

create table part(
	part_num integer primary key,
	type varchar2(500),  --a pen, a winestopper
	quantity integer,
	part_name varchar(1002),
	part_Desc varchar(1002),
	price float
);
	
 create table customer(
	cust_num integer primary key,
	firstName varchar(1002),
	lastname varchar (1002),
	email_address varchar(2000),
	shipping_Address varchar(2000),
	gender varchar(2000),
	phone_number varchar(2000),
	street varchar(300),
	city varchar(2000),
	state varchar(2000),
	zipcode char(2000)
); 

create table orders(
	order_num integer primary key,
	date_ordered date,
	exp_ship_date date,
	act_ship_date date,
	--part_num integer,
	employee_number integer,
	cust_num integer,
	quantity integer,
	total_order_value integer,
	--foreign key (part_num) references part(part_num) on delete set null,
	foreign key (employee_number) references employees(employee_number) on delete set null,
	foreign key (cust_num) references customer(cust_num) on delete set null
);

create table partorder(
	part_num integer,
	order_num integer,
	quantity integer check (quantity>0),
	foreign key (part_num) references part(part_num) on Delete Cascade,
	foreign key (order_num) references orders(order_num) on Delete Cascade
);

create table Feedback(
	feedback_id integer primary key,
	order_num integer,
	cust_num integer,
	feedback varchar(2000),
	foreign key (order_num) references orders(order_num) on Delete set null,
	foreign key (cust_num) references customer(cust_num) on delete set null
);

create table reviews(
	review_id integer primary key,
	order_num integer,
	star_review integer,
	feedback varchar(100),
	foreign key (order_num) references orders(order_num) on Delete set null
);
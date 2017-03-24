--Nathanael Dick
--Project 3 on DNDB database
--Note: I updated the database, vision statement, erd, added a lot more data, added constraints, and addressed comments you made 
--when grading project 2.

--this query gets information about the feedback based on the partnumber
--and the employee
--this can be valuable to determine what feedback I might get on a part
--and employee
--I could have used other join methods but I wanted to inner join the specific tables
select distinct e.firstName, c.firstName, c.lastName, o.order_num, po.part_num, f.feedback
from employees e
	inner join orders o 
		on o.employee_number=e.employee_number 
		and e.firstName='Nathanael'
	inner join partorder po 
		on po.order_num=o.order_num
	inner join customer c 
		on o.cust_num = c.cust_num
	 join feedback f 
		on f.cust_num=c.cust_num;
		
	--these queries can help me get more info about the shipping address and update the shipping address
	--based on the fact you need a correct zipcode to ship and it cannot be null
select c.firstName, c.lastName, c.shipping_Address, phone_number
	from customer c
		where c.zipcode is not NULL;
select c.firstName, c.lastName, c.shipping_Address, phone_number
	from customer c
		where c.zipcode is NULL;
		
	--This query finds all the customer feedback for a specific employee_number
	--This is useful when evaluating ways in which each employee can do better to enhance customer's experience
select distinct e.firstName, f.feedback
	from employees e, feedback f, orders o
		where e.firstName='Nathanael'
		and o.employee_number=e.employee_number
		and f.order_num=o.order_num;
	
	
--This shows the number of orders per employee it also demonstrates my knowledge of 
--left outer join/null values because Paul does not have any orders but I am joining him with a left outer join
select  e.firstName||' '||e.lastName||' id: '||e.employee_number||' #of employees '||count(o.order_num) "Number Of Orders Per Employee"
	from employees e
		left outer join	orders o 
		on e.employee_number=o.employee_number
		group by e.firstName, e.lastName, e.employee_number
		order by count(o.order_num) desc;
		 
--this shows how many orders each customer has made	and it also includes customers
--who have 0 orders saying they have 0 orders if I did not include the left outer join
--it would have not shown my customers with no orders
select count(o.order_num), c.firstName
	from customer c
		left outer join orders o
		on c.cust_num=o.cust_num
		group by c.firstName;

--can be useful in determining order dates for other parts
--select all the employees who are not working with all the parts except this one
--and check their expected shipping date
SELECT e.firstname||' '|| o.order_num||' '||o.exp_ship_date "Fubline Pen Order Information"
	FROM employees e,  orders o, partorder po
		WHERE e.employee_number=o.employee_number
		and po.order_num=o.order_num
		AND NOT EXISTS 
		(SELECT *
                 FROM part p
                 WHERE p.part_name='funline_pens'
				 and po.part_num = p.part_num);
				 
--this is the opposite of the previous query looking for all orders with a funline pen				 
--Note: I could have joined the tables but I thought this was a good place to use 
-- a nested query it worked well with the part table
SELECT e.firstname||' '|| o.order_num||' '||o.exp_ship_date "Get Funline Pen order information"
	FROM employees e,  orders o, partorder po
		WHERE e.employee_number=o.employee_number
		and po.order_num=o.order_num
		AND EXISTS 
		(SELECT *
                 FROM part p
                 WHERE p.part_name='funline_pens'
				 and po.part_num = p.part_num);	
				 
--gets all the customers that have given a feedback
--Note: I could have done this by joining the FEEDBACK table without
-- a nested query but I decided to use a nested query to demonstrate knowledge of a nested query
select o.order_num, c.firstName, c.lastName, c.cust_num
from orders o, customer c
					where o.cust_num = c.cust_num
					and o.cust_num in (Select cust_num from feedback);
					
--gets the amount of orders each customer had if they submitted a feedback	
--Note: I could have done this by joining the FEEDBACK table without
-- a nested query but I decided to use a nested query to demonstrate knowledge of a nested query				
select c.cust_num, count(c.cust_num)
from orders o, customer c
					where o.cust_num = c.cust_num
					and o.cust_num in (Select cust_num from feedback)
					group by c.cust_num
					order by desc;
					
--This determine how many orders were made if the review the customer made was a 5 star_review
--This is important to determining how many sales can be made based on the review
--Note: I could have done this by joining the review table without
-- a nested query but I decided to use a nested query to demonstrate knowledge of a nested query
select c.cust_num, count(c.cust_num)
from orders o, customer c
					where o.cust_num = c.cust_num
					and o.order_num in (Select order_num
											from reviews
												where star_review = 5)
					group by c.cust_num;
					
--this gets all the parts that are needed to ship out by march 3 very valuable
--for day to day fulfillment of our orders in our company
select e.firstName||' '||e.lastName||' '||' '||p.part_Desc||' quantity: '||po.quantity "parts needed to ship out"
from employees e, partorder po, part p, orders o
	where o.employee_number=e.employee_number
	and o.order_num=po.order_num
	and po.part_num=p.part_num
	and o.exp_ship_date='03-MAR-2017';
	
--parts needed to ship out today(very useful)
	select e.firstName||' '||e.lastName||' '||' '||p.part_Desc||' quantity: '||po.quantity "parts needed to ship out"
from employees e, partorder po, part p, orders o
	where o.employee_number=e.employee_number
	and o.order_num=po.order_num
	and po.part_num=p.part_num
	and o.exp_ship_date=sysdate;
	
	
--a self-join We want to figure out what family relations has to do with order referrals this can be handy	
select Distinct c1.firstName||' and '||c2.firstName||' ' || c1.lastName "customers: same lastName"
	from customer c1, customer c2
		where c1.lastName=c2.lastName
		and c1.cust_num<c2.cust_num;

--max valued order
select max(total_order_value)||' cust num: '||c.cust_num||' '||c.firstName||' '||c.email_address "highest value order"
	from orders o, customer c
	where o.cust_num=c.cust_num
	group by c.cust_num, c.firstName, c.email_address;
	
--average value order
select trunc(avg(total_order_value),2)||' cust num: '||c.cust_num||' '||c.firstName||' '||c.email_address "average value order"
	from orders o, customer c
	where o.cust_num=c.cust_num
	group by c.cust_num, c.firstName, c.email_address;
	
--Get the Feedback where shipping is involved
select f.feedback, f.order_num, f.cust_num, c.firstName, c.lastName
	from feedback f, orders o, customer c
		where f.order_num = o.order_num
		and o.cust_num = c.cust_num
		and f.feedback like '%ship%';

--I made this view for the person that updates the orders
--The employee can now only change the status of the actual ship
--date when the other employee ships that order
--I chose a non-materialized view because I wanted the employee to be able to update the actual ship date of 
--the order
drop view shipview;	

create or replace view shipview 
	as select distinct o.order_num, o.act_ship_date  "Shipping" 
	from orders o
	where o.act_ship_date is NULL
	order by o.order_num desc;
	
select * from shipview;

--I made this view specific for the employee that does the packaging another employee takes care
	--of updating the shipping status and I  add that view as a non-materialized view as seen above
--Thus I do not want data to be changed and also I want the table to be linked to base table
--so I chose materialized view
drop materialized view shipview2;
 
 create materialized view shipview2 
  BUILD Immediate
  REFRESH COMPLETE
	as select distinct o.order_num, o.exp_ship_date, po.quantity, p.part_Desc, c.shipping_Address, c.firstName  "Shipping" 
	from orders o, partorder po, part p, customer c
	where o.cust_num = c.cust_num
	and o.order_num = po.order_num
	and po.part_num = p.part_num
	and o.act_ship_date is NULL
	order by o.order_num desc; 
	
select * from shipview2;

--This view would be helpful to the person that orders the parts 
--The employee does not have acess to customer info but can see the part quantity and 
--update the quantity.  I chose a non-materialized view because I wanted the employee to be able to update the quantity of the part
drop view PartsInStock;

create or replace view PartsInStock
	As 
	select * from part;
	
select * from PartsInStock;


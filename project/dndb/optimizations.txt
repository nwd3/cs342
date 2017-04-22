--optimizations
SET AUTOTRACE ON;
SET SERVEROUTPUT ON;
SET TIMING ON;
SET WRAP OFF;
  create index index1 on partorder (part_num, order_num);
  
  
  create index index4 on orders(order_num,cust_num);
drop index index1;

--this was my original query 
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
		--this project I optimized it the following way
drop index index11;
  create index index1 on partorder (part_num, order_num);  
		create index index11 on feedback ( cust_num);
		create index index13 on employees(employee_number, firstName);
		create index index14 on orders(order_num,cust_num, employee_number);
	
		select distinct e.firstName, c.firstName, c.lastName, o.order_num, po.part_num, f.feedback
from employees e, orders o, partorder po, feedback f,customer c 
	where e.firstName = 'Nathanael'
		and e.employee_number = o.employee_number
		and o.order_num = po.order_num
		and o.cust_num = c.cust_num
		and f.cust_num=o.cust_num;

Execution Plan
----------------------------------------------------------
Plan hash value: 2457800816

--------------------------------------------------------------------------------
| Id  | Operation                       | Name         | Rows  | Bytes | Cost (%
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                |              |     1 |  2814 |     5
|   1 |  HASH UNIQUE                    |              |     1 |  2814 |     5
|   2 |   NESTED LOOPS                  |              |     1 |  2814 |     4
|   3 |    NESTED LOOPS                 |              |     1 |  2788 |     3
|   4 |     NESTED LOOPS                |              |     1 |  1769 |     2
|   5 |      NESTED LOOPS               |              |    27 | 20358 |     1
|*  6 |       INDEX FULL SCAN           | INDEX14      |   109 |  4251 |     1
|*  7 |       INDEX RANGE SCAN          | INDEX13      |     1 |   715 |     0
|   8 |      TABLE ACCESS BY INDEX ROWID| FEEDBACK     |     1 |  1015 |     1
|*  9 |       INDEX RANGE SCAN          | INDEX11      |     1 |       |     0
|  10 |     TABLE ACCESS BY INDEX ROWID | CUSTOMER     |     1 |  1019 |     1
|* 11 |      INDEX UNIQUE SCAN          | SYS_C0013938 |     1 |       |     0
|* 12 |    INDEX FULL SCAN              | INDEX1       |     1 |    26 |     1
--------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   6 - access("O"."EMPLOYEE_NUMBER">0)
       filter("O"."EMPLOYEE_NUMBER">0)
   7 - access("E"."EMPLOYEE_NUMBER"="O"."EMPLOYEE_NUMBER" AND
              "E"."FIRSTNAME"='Nathanael')
   9 - access("F"."CUST_NUM"="O"."CUST_NUM")
  11 - access("O"."CUST_NUM"="C"."CUST_NUM")
  12 - access("O"."ORDER_NUM"="PO"."ORDER_NUM")
       filter("O"."ORDER_NUM"="PO"."ORDER_NUM")

Note
-----
   - dynamic sampling used for this statement (level=2)

   
 Analysis of the Execution Plan Etc:
 Execution Plan:
 Using Indexes on the query
	Originally the execution plan showed an access to the order table with one of the most expensive operations a full access.  This 
 reads every row on the table.  I created an index for the order table to rid the database from having to do
 a full access for the order table.(index14)  
	Further because of how I access the different tables it is probably necessary to check each order for the correct employee_number. 
 I created an index to access the partorder table(index1) this created a way for the database
 to access the partorder table.  This allows me to optimize accessing the part table with my created index.  I also use a feedback index(index11).  I did not think this 
 would make a differece but it seems to speed up the process considerably. 
  
		The execution also uses the SYS_C0013938 index which checks fro the uniqueness in the inedex.  
 The other accesses how it joins the table and the loops are as efficient as I could think of making them.  Adding the indexes lessened some of the operations on the database.
   
   Ways I optimized the query 
	I changed the query from the original one by accessing the tables in such a way that I attempted to force the database to only access data it needed for the result.  FOR
  example I specified the employees firstName right away to rid any unecessary accesse to the employee table.  I also changed 	the last line 'and f.cust_num=c.cust_num;' to 	'and f.cust_num=o.cust_num;'
  this made use of the already accesed order number.
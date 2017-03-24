--I added some constraints 3/24/17
ALTER TABLE Orders
   Add ( CONSTRAINT positiveQuanity
        Check (quantity >0)
       );
 ALTER TABLE employees
   Add ( CONSTRAINT employee_id_constraint
Check (employee_number >0) 
      );
 ALTER TABLE part
   Add ( CONSTRAINT part_constraint
Check (part_name is not Null) 
      );
 ALTER TABLE customer
   Add ( CONSTRAINT part_constraint
Check (gender in ('m', 'f')) 
      );	  
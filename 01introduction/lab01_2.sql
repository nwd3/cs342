--Exercise 1.2 source: https://en.wikipedia.org/wiki/DUAL_table (used this source throughout some information

--that was copied was not quoted)

--"The DUAL table is a special one-row, one-column table present by default 

--in Oracle and other database installations. In Oracle, the table has a single 

--VARCHAR2(1) column called DUMMY that has a value of 'X'. 

--It is suitable for use in selecting a pseudo column such as SYSDATE or USER."

--example dual commands (note all from wikipiedia article)

SELECT 1+1

from dual;



SELECT 1 

from dual;



SELECT USER 

from dual;



SELECT SYSDATE 

from dual;



SELECT * 

from dual;



--DUAL was used to allow the user to join to the dual table and "create two rows in the result 

--for every one row in your table. Then by using GROUP BY, the resulting join could

--be summarized to show the amount of storage for the DATA extent and for the INDEX extent(s)"

--basically dual allows a user  to create "a pair of rows from just one."

--could be used if you wanted to show as said above the amount of storage for the data and index extents and

--also gives the user more choices
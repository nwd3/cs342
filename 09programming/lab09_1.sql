
--Lab09
--Nathanael Dick
--Lab9
--Lab09_1.sql


CLEAR SCREEN;
SET AUTOTRACE ON;
SET SERVEROUTPUT ON;
SET TIMING ON;
SET WRAP OFF;



-- 9.1.aBEGIN
--here are the queries

SELECT count(1) from movie;
SELECT count(*) from movie;
SELECT sum(1) from movie;

--Explanation of A;
--1.There is no significant differences between the count queries->Elapsed: 00:00:00.01(both count queries are this way)
--2.but the sum aggregate funcition takes a longer time -> Elapsed: 00:00:00.02
--the longer length of count(1) than the count queries must be due to how sum is implemented
--in this particular instance

--Further Testing: I tride runnning it on a different table to see if that would make a difference
--and it came back with something different count(1) elapsed in 0 time 
--count(*) and sum(1) both took some time
--Thus there may be some benefit from using count(1) than any of the other count methods
SELECT count(1) from director;
SELECT count(*) from director;
SELECT sum(1) from director;

--9.1.b
--The query below
--Elapsed Time: 2.70 s
--select statemnt 837 cpu cost, join 837
--1775497 rows selected.
 SET AUTOTRACE TRACEONLY;
select genre from DIRECTORGENRE dr, MovieDirector md 
where md.directorId = dr.directorId;

--the query below I moved the Movie Directory to be first but the results
--showed no notible changes
--took 2.73 seconds select statemnt 837 cpu cost, join 837
SET AUTOTRACE TRACEONLY;
select genre from MovieDirector md, DIRECTORGENRE dr 
where md.directorId = dr.directorId; 

--RESULTS Of B
--1.There does not seem to be any change in how the order of tables are listed in the from clause

--Further Testing this next experiment I tested whether adding more into the select clause changed anything

--took 2.69-2.79 seconds 
/ SET AUTOTRACE TRACEONLY;
select genre, md.movieID from DIRECTORGENRE dr, MovieDirector md 
where md.directorId on dr.directorId;

--Thus adding more items in the select clause does not change anything in perfromance


--9.1.c
/*This is the result of using no + join 
156562 rows selected.
Elapsed: 00:00:16.71
Execution Plan
----------------------------------------------------------
Plan hash value: 3586146000
--------------------------------------------------------------------------------
| Id  | Operation          | Name          | Rows  | Bytes |TempSpc| Cost (%CPU)
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |               |   156K|  5657K|       |   557   (1)
|*  1 |  HASH JOIN         |               |   156K|  5657K|  2800K|   557   (1)
|   2 |   TABLE ACCESS FULL| DIRECTOR      | 86880 |  1781K|       |    86   (2)
|   3 |   TABLE ACCESS FULL| DIRECTORGENRE |   156K|  2446K|       |   126   (1)
-------------------------------------------------------------------------------- */
 select * from
director d join directorGenre dr on d.id = dr.directorid;

/* this is the result of using the id+ join
156562 rows selected.
Elapsed: 00:00:16.97
Execution Plan
----------------------------------------------------------
Plan hash value: 3586146000
--------------------------------------------------------------------------------
| Id  | Operation          | Name          | Rows  | Bytes |TempSpc| Cost (%CPU)
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |               |   136M|  4799M|       |   935  (41)
|*  1 |  HASH JOIN         |               |   136M|  4799M|  2800K|   935  (41)
|   2 |   TABLE ACCESS FULL| DIRECTOR      | 86880 |  1781K|       |    86   (2)
|   3 |   TABLE ACCESS FULL| DIRECTORGENRE |   156K|  2446K|       |   126   (1)
--------------------------------------------------------------------------------*/
--with id + operation
 select * from
director d join directorGenre dr on d.id+1 = dr.directorid+1;
--RESULTS of C
--1.Results of these queries show that it may take a little longer to join a table 
--with addition thus it may be preferential to not use addition

--Furhter Testing: I also tried running the command with a different and larger number to see what this would do
--as below
--This took 15.64 seconds and had the same cpu costs as the query that did the addition
--this is not surprising because there were propably fewer records that it had to process
--the query is shown below
select * from
director d join directorGenre dr on d.id+10 = dr.directorid+199; 

--9.1.d
--first time only ran once
/* Elapsed: 00:00:10.76
Execution Plan
------------------------------------------------------------------------------
| Id  | Operation         | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |          | 86880 |  1781K|    86   (2)| 00:00:02 |
|   1 |  TABLE ACCESS FULL| DIRECTOR | 86880 |  1781K|    86   (2)| 00:00:02 |
*/
select * from Director;

--running it multiple times helped significantly by about 3 seconds note the cpu cost 
-- is the same
/* 
Elapsed: 00:00:07.32
------------------------------------------------------------------------------
| Id  | Operation         | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |          | 86880 |  1781K|    86   (2)| 00:00:02 |
|   1 |  TABLE ACCESS FULL| DIRECTOR | 86880 |  1781K|    86   (2)| 00:00:02 |
*/
select * from Director;
select * from Director;
select * from Director;
--RESULTS OF D
--1. It seemed to be the case when the operation is run more times there is a slight improvement in the time the query takes
--when I ran all three together it was much fastrer by 3 seconds than when I ran the query
--by itself note the cpu costs are the same
 
 --Further Testing: I also ran with only auto trace to try another record and runnning the query
 --by itself took .7 seconds with 498 cpu cost
 SET AUTOTRACE TRACEONLY;
select * from Movie;
select * from Movie;
select * from Movie;
select * from Movie;
select * from Movie;
select * from Movie;
select * from Movie;
select * from Movie;
select * from Movie;
select * from Movie;
--At the end of this it only took .68 seconds so a slight improvement
--from the time when I ran it only once


--9.1.e
--Professor Vanderlinden said to paste the error message that creating the index gives
--the error message is shown below
--From online research I gather that creating an index can increase the performance of a table
--Ref:http://sqlmag.com/database-performance-tuning/indexing-dos-and-don-ts

--create index index1 on role (movieID, actorID);
--ALTER INDEX &index1 INVISIBLE;
--gives error message Professor VanderLinden said to paste error message in
--here 
/* create index index1 on role (movieID, actorID)
        --Error Message               *
ERROR at line 1:
ORA-01652: unable to extend temp segment by 128 in tablespace SYSTEM
Elapsed: 00:00:01.98
Enter value for index1: */
/* SET AUTOTRACE TRACEONLY;
BEGIN
select a.firstName from role join actor a on a.id = role.actorID; 
END;
/ */


SET AUTOTRACE OFF;
SET SERVEROUTPUT OFF;
SET TIMING OFF;
SET WRAP ON;

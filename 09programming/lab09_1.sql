--Lab09


CLEAR SCREEN;
SET AUTOTRACE ON;
SET SERVEROUTPUT ON;
SET TIMING ON;
SET WRAP OFF;



-- 9.1.a

SELECT count(1) from movie;

SELECT count(*) from movie;

SELECT sum(1) from movie;

--There is no significant differences between the count queries
--and the sum aggregate function
--Elapsed: 00:00:36.97
/* 380658 rows selected.

Elapsed: 00:00:36.97
select m.id, d.id
from  director d, movie m, movieDirector md
where d.id = md.directorId
and m.id = md.movieId;*/

--seems to be about the same maybe a little faster
--elapsed time Elapsed: 00:00:35.06
/*  select m.id, d.id
from movie m, director d, movieDirector md
where d.id = md.directorId
and m.id = md.movieId;  */
--elapsed time: 

--9.1.c
/* 156562 rows selected.

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
/* select * from
director d join directorGenre dr on d.id = dr.directorid; */
/*
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
-- select * from
--director d join directorGenre dr on d.id+1 = dr.directorid+1;

--first time only ran once
/* Elapsed: 00:00:10.76

Execution Plan
----------------------------------------------------------
Plan hash value: 1451062477

------------------------------------------------------------------------------
| Id  | Operation         | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |          | 86880 |  1781K|    86   (2)| 00:00:02 |
|   1 |  TABLE ACCESS FULL| DIRECTOR | 86880 |  1781K|    86   (2)| 00:00:02 |
------------------------------------------------------------------------------
select * from Director; */

--running it multiple times helped significantly by about 3 seconds
/* 
Elapsed: 00:00:07.32

Execution Plan
----------------------------------------------------------
Plan hash value: 1451062477

------------------------------------------------------------------------------
| Id  | Operation         | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |          | 86880 |  1781K|    86   (2)| 00:00:02 |
|   1 |  TABLE ACCESS FULL| DIRECTOR | 86880 |  1781K|    86   (2)| 00:00:02 |
------------------------------------------------------------------------------
select * from Director;
select * from Director;

--the last one was
select * from Director; */

--d 
-- This single query demonstrates the auto-trace output (with or without the index).
--ALTER INDEX &Actor_Index INVISIBLE;
--ALTER INDEX &ActorOrdinal_Index INVISIBLE;
create index index1 on role (movieID, actorID);
ALTER INDEX &index1 INVISIBLE;

--gives error message
/* create index index1 on role (movieID, actorID)
                       *
ERROR at line 1:
ORA-01652: unable to extend temp segment by 128 in tablespace SYSTEM


Elapsed: 00:00:01.98
Enter value for index1: */
SET AUTOTRACE TRACEONLY;
BEGIN
select a.firstName from role join actor a on a.id = role.actorID; 
END;
/
SET AUTOTRACE OFF;
SET SERVEROUTPUT OFF;
SET TIMING OFF;
SET WRAP ON;
--References
--https://docs.oracle.com/cd/A57673_01/DOC/server/doc/SCN73/ch15.htm
--http://stackoverflow.com/questions/32910610/problema-creating-a-trigger-in-oracle-to-update-other-table
drop table RankLog;

create table RankLog(
userID varchar(90),
dateOfChange date,
originalRank number,
modifiedRank number
);

--note references above pretty detailed in how you implement a column update 
--so i used their examples
 create or replace trigger auditing after update of rank on movie 
	for each row
	BEGIN
	insert into RankLog (userID, dateOfChange, originalRank, modifiedRank)
	values(user, sysdate, :old.rank, :new.rank);
	END auditing;
	/


UPDATE movie
SET rank = 6.9
WHERE id = 238071;	

select * from RankLog;

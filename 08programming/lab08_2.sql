 --Lab08
--Nathanael Dick
--March 31

DROP TABLE SequelsTemp3;

-- Insert your results into this table.
CREATE TABLE SequelsTemp3 (
  id INTEGER,
  name varchar2(100),
  PRIMARY KEY (id)
 );
 
CREATE OR REPLACE PROCEDURE getSequels (movieIdIn IN Movie.id%type) as
	cursor movieIDout is
		select id, sequelid, name
		from movie
		where id=movieIDIn;
Begin
	FOR nOut IN movieIDout LOOP
		if nOut.sequelid is not NULL then
			INSERT INTO SequelsTemp3(id, name)
				VALUES (nout.sequelid, nOut.name);
			getSequels(nOut.sequelid);
		else
			dbms_output.put_line('There are no more seqels for this movie');
		end if;
	END LOOP;
END;
/

-- Get the sequels for Ocean's 12, i.e., 3 of them.
BEGIN  getSequels(238072);  END;
/
SELECT * FROM SequelsTemp3;

-- Get the sequels for Ocean's Fourteen, i.e., none.
BEGIN  getSequels(238075);  END;
/
SELECT * FROM SequelsTemp3;

-- Clean up.
DROP TABLE SequelsTemp3;
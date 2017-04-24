-- Create the user.
DROP USER dndb CASCADE;
CREATE USER dndb 
	IDENTIFIED BY gh
	QUOTA 5M ON System;
GRANT 
	CONNECT,
	CREATE TABLE,
	CREATE SESSION,
	CREATE ANY DIRECTORY,
	DROP ANY DIRECTORY,
	CREATE SEQUENCE,
	CREATE VIEW,
	CREATE MATERIALIZED VIEW,
	CREATE PROCEDURE,
	CREATE TRIGGER,
	PLUSTRACE,
	UNLIMITED TABLESPACE
	TO dndb;

-- Connect to the user's account/schema.

DROP DIRECTORY exp_dir;
CREATE DIRECTORY exp_dir AS 'C:\projects\dndb';
GRANT READ, WRITE ON DIRECTORY exp_dir to dndb;
-- (Re)Create the database.

--@&dndb\load
CONNECT dndb/gh;
 DEFINE dndb=C:\projects\dndb
@&dndb\load
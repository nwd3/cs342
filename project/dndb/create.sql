-- Create the user.
DROP USER dndb CASCADE;
CREATE USER dndb 
	IDENTIFIED BY gh
	QUOTA 5M ON System;
GRANT 
	CONNECT,
	CREATE TABLE,
	CREATE SESSION,
	CREATE SEQUENCE,
	CREATE VIEW,
	CREATE MATERIALIZED VIEW,
	CREATE PROCEDURE,
	CREATE TRIGGER,
	UNLIMITED TABLESPACE
	TO dndb;

-- Connect to the user's account/schema.
CONNECT dndb/gh;

-- (Re)Create the database.
DEFINE dndb=C:\Users\nwd3_000\Documents\Spring2017\CS342\project\dndb
@&dndb\load
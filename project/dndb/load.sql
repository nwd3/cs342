-- Load the grading database. 
-- See ../README.md for details.

-- Drop the previous table declarations.
@&dndb\drop         
commit;
-- Reload the table declarations.
@&dndb\schema
commit;
-- Load the table data.
@&dndb\data
commit;
-- Add constraints that cannot be added before the data.
@&dndb\constraints
commit;

--Add queries
@&dndb\queries
commit;
--note we may want to calculate price via summing all parts
--and add price to order if we don;t
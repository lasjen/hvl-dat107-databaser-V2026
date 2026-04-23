-- create-teacher-table.cql
-- Script to create a keyspace and teacher table for a single-node Cassandra cluster

-- Drop keyspace if it exists (for clean re-runs)
DROP KEYSPACE IF EXISTS hvl_db;

-- Create keyspace with SimpleStrategy for single-node cluster
CREATE KEYSPACE hvl_db
WITH replication = {
    'class': 'SimpleStrategy',
    'replication_factor': 1
}
AND durable_writes = true;

-- Use the keyspace
USE hvl_db;


-- Create teacher table
CREATE TABLE teacher (
    id UUID PRIMARY KEY,
    fornavn TEXT,
    etternavn TEXT
);



-- Insert sample data
INSERT INTO teacher (id, fornavn, etternavn)
VALUES (uuid(), 'Dag', 'Toppe Larsen');

INSERT INTO teacher (id, fornavn, etternavn)
VALUES (uuid(), 'Lars-Petter', 'Helland');

INSERT INTO teacher (id, fornavn, etternavn)
VALUES (uuid(), 'Lasse', 'Jenssen');

-- Update
INSERT INTO teacher (id, fornavn, etternavn)
VALUES (f518acd0-59a5-4509-85b8-c0bab896b558, 'Lars', 'Jenssen');

-- Verify the data
SELECT * FROM teacher;

-- Show table structure
DESCRIBE TABLE teacher;

-- Delete ALL data from the teacher table
--TRUNCATE TABLE teacher;


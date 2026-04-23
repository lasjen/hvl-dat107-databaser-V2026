-- create-event-table.cql
-- Script to create user_events table for a single-node Cassandra cluster
-- Demonstrates partition key and clustering columns

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

drop table if exists user_events;

-- Create user_events table
-- Partition key: user_id (data for samme bruker lagres sammen)
-- Clustering columns: yyyymmdd, event_time (sorterer events kronologisk)
CREATE TABLE user_events (
   user_id text,
   yyyymmdd int,
   event_time timestamp,
   event_type text,
   details text,
   PRIMARY KEY ((user_id), yyyymmdd, event_time)
) WITH CLUSTERING ORDER BY (yyyymmdd DESC, event_time DESC);

-- =====================================================
-- Insert sample data (ca 100 events for 5 brukere)
-- =====================================================

-- User: student001 (20 events)
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260401, '2026-04-01 08:15:30', 'login', 'Logged in from Chrome');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260401, '2026-04-01 08:20:15', 'view_course', 'Viewed DAT107');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260401, '2026-04-01 08:25:00', 'submit_assignment', 'Submitted assignment 1');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260401, '2026-04-01 09:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260402, '2026-04-02 07:45:00', 'login', 'Logged in from Firefox');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260402, '2026-04-02 08:00:00', 'view_course', 'Viewed DAT100');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260402, '2026-04-02 10:30:00', 'download', 'Downloaded lecture notes');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260402, '2026-04-02 11:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260403, '2026-04-03 09:15:00', 'login', 'Logged in from mobile');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260403, '2026-04-03 09:20:00', 'view_grades', 'Checked grades');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260403, '2026-04-03 09:30:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260404, '2026-04-04 13:00:00', 'login', 'Logged in from Chrome');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260404, '2026-04-04 13:15:00', 'forum_post', 'Posted question in forum');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260404, '2026-04-04 14:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260405, '2026-04-05 10:00:00', 'login', 'Logged in from Chrome');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260405, '2026-04-05 10:30:00', 'watch_video', 'Watched lecture video 5');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260405, '2026-04-05 11:45:00', 'submit_assignment', 'Submitted assignment 2');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260405, '2026-04-05 12:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260406, '2026-04-06 08:30:00', 'login', 'Logged in from Chrome');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student001', 20260406, '2026-04-06 09:00:00', 'logout', 'Logged out');

-- User: student002 (20 events)
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260401, '2026-04-01 07:00:00', 'login', 'Logged in from Safari');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260401, '2026-04-01 07:15:00', 'view_course', 'Viewed DAT107');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260401, '2026-04-01 07:30:00', 'download', 'Downloaded assignment');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260401, '2026-04-01 08:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260402, '2026-04-02 09:00:00', 'login', 'Logged in from Chrome');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260402, '2026-04-02 09:30:00', 'watch_video', 'Watched lecture video 3');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260402, '2026-04-02 10:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260403, '2026-04-03 11:00:00', 'login', 'Logged in from Firefox');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260403, '2026-04-03 11:30:00', 'submit_assignment', 'Submitted assignment 1');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260403, '2026-04-03 11:45:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260404, '2026-04-04 08:00:00', 'login', 'Logged in from mobile');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260404, '2026-04-04 08:15:00', 'view_grades', 'Checked grades');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260404, '2026-04-04 08:30:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260405, '2026-04-05 14:00:00', 'login', 'Logged in from Chrome');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260405, '2026-04-05 14:30:00', 'forum_post', 'Posted answer in forum');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260405, '2026-04-05 15:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260406, '2026-04-06 10:00:00', 'login', 'Logged in from Chrome');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260406, '2026-04-06 10:30:00', 'watch_video', 'Watched lecture video 6');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260406, '2026-04-06 11:00:00', 'download', 'Downloaded exercises');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student002', 20260406, '2026-04-06 11:30:00', 'logout', 'Logged out');

-- User: student003 (20 events)
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260401, '2026-04-01 10:00:00', 'login', 'Logged in from Edge');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260401, '2026-04-01 10:15:00', 'view_course', 'Viewed DAT100');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260401, '2026-04-01 10:30:00', 'download', 'Downloaded syllabus');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260401, '2026-04-01 11:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260402, '2026-04-02 12:00:00', 'login', 'Logged in from Chrome');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260402, '2026-04-02 12:30:00', 'watch_video', 'Watched lecture video 1');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260402, '2026-04-02 13:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260403, '2026-04-03 14:00:00', 'login', 'Logged in from mobile');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260403, '2026-04-03 14:30:00', 'view_grades', 'Checked grades');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260403, '2026-04-03 14:45:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260404, '2026-04-04 09:00:00', 'login', 'Logged in from Chrome');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260404, '2026-04-04 09:30:00', 'submit_assignment', 'Submitted assignment 1');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260404, '2026-04-04 10:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260405, '2026-04-05 08:00:00', 'login', 'Logged in from Chrome');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260405, '2026-04-05 08:30:00', 'watch_video', 'Watched lecture video 4');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260405, '2026-04-05 09:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260406, '2026-04-06 15:00:00', 'login', 'Logged in from Safari');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260406, '2026-04-06 15:30:00', 'forum_post', 'Posted question');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260406, '2026-04-06 16:00:00', 'download', 'Downloaded solution');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student003', 20260406, '2026-04-06 16:30:00', 'logout', 'Logged out');

-- User: student004 (20 events)
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260401, '2026-04-01 11:00:00', 'login', 'Logged in from Chrome');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260401, '2026-04-01 11:15:00', 'view_course', 'Viewed DAT107');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260401, '2026-04-01 11:45:00', 'watch_video', 'Watched lecture video 2');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260401, '2026-04-01 12:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260402, '2026-04-02 13:00:00', 'login', 'Logged in from Firefox');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260402, '2026-04-02 13:30:00', 'download', 'Downloaded lecture notes');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260402, '2026-04-02 14:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260403, '2026-04-03 08:00:00', 'login', 'Logged in from mobile');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260403, '2026-04-03 08:15:00', 'view_grades', 'Checked grades');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260403, '2026-04-03 08:30:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260404, '2026-04-04 16:00:00', 'login', 'Logged in from Chrome');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260404, '2026-04-04 16:30:00', 'submit_assignment', 'Submitted assignment 2');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260404, '2026-04-04 17:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260405, '2026-04-05 09:00:00', 'login', 'Logged in from Chrome');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260405, '2026-04-05 09:30:00', 'watch_video', 'Watched lecture video 5');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260405, '2026-04-05 10:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260406, '2026-04-06 12:00:00', 'login', 'Logged in from Safari');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260406, '2026-04-06 12:30:00', 'forum_post', 'Posted comment');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260406, '2026-04-06 13:00:00', 'download', 'Downloaded assignment 3');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student004', 20260406, '2026-04-06 13:30:00', 'logout', 'Logged out');

-- User: student005 (20 events)
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260401, '2026-04-01 12:00:00', 'login', 'Logged in from Opera');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260401, '2026-04-01 12:15:00', 'view_course', 'Viewed DAT100');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260401, '2026-04-01 12:30:00', 'download', 'Downloaded course material');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260401, '2026-04-01 13:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260402, '2026-04-02 14:00:00', 'login', 'Logged in from Chrome');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260402, '2026-04-02 14:30:00', 'watch_video', 'Watched lecture video 1');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260402, '2026-04-02 15:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260403, '2026-04-03 10:00:00', 'login', 'Logged in from mobile');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260403, '2026-04-03 10:30:00', 'view_grades', 'Checked grades');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260403, '2026-04-03 10:45:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260404, '2026-04-04 11:00:00', 'login', 'Logged in from Chrome');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260404, '2026-04-04 11:30:00', 'submit_assignment', 'Submitted assignment 1');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260404, '2026-04-04 12:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260405, '2026-04-05 13:00:00', 'login', 'Logged in from Firefox');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260405, '2026-04-05 13:30:00', 'watch_video', 'Watched lecture video 3');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260405, '2026-04-05 14:00:00', 'logout', 'Logged out');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260406, '2026-04-06 14:00:00', 'login', 'Logged in from Chrome');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260406, '2026-04-06 14:30:00', 'forum_post', 'Posted discussion topic');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260406, '2026-04-06 15:00:00', 'download', 'Downloaded exam info');
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details) VALUES ('student005', 20260406, '2026-04-06 15:30:00', 'logout', 'Logged out');

/*
-- =====================================================
-- QUERIES - Demonstrerer partition key og clustering columns
-- =====================================================

-- 1. Hent alle events for en spesifikk bruker (bruker partition key)
-- Dette er EFFEKTIVT fordi data for samme user_id lagres sammen
SELECT * FROM user_events WHERE user_id = 'student001';

-- 2. Hent events for en bruker på en spesifikk dag (partition key + clustering column)
-- Også EFFEKTIVT fordi vi filtrerer på partition key og første clustering column
SELECT * FROM user_events
WHERE user_id = 'student001'
AND yyyymmdd = 20260401;

-- 3. Hent events for en bruker i et tidsrom (partition key + clustering range)
-- EFFEKTIVT - bruker partition key og clustering column range
SELECT * FROM user_events
WHERE user_id = 'student001'
AND yyyymmdd >= 20260401
AND yyyymmdd <= 20260403;

-- 4. Hent events for en bruker på en dag innenfor et tidspunkt
-- EFFEKTIVT - bruker partition key og begge clustering columns
SELECT * FROM user_events
WHERE user_id = 'student001'
AND yyyymmdd = 20260401
AND event_time >= '2026-04-01 08:00:00'
AND event_time <= '2026-04-01 09:00:00';

-- 5. Tell antall events per bruker per dag
SELECT user_id, yyyymmdd, COUNT(*) as event_count
FROM user_events
WHERE user_id = 'student001'
GROUP BY user_id, yyyymmdd;

-- 6. Hent de 5 siste events for en bruker (demonstrerer CLUSTERING ORDER BY DESC)
SELECT * FROM user_events
WHERE user_id = 'student002'
LIMIT 5;

-- 7. Finn alle login events for en bruker på en spesifikk dag
-- Merk: ALLOW FILTERING er nødvendig siden event_type ikke er del av primary key
-- Dette er IKKE EFFEKTIVT for store datasett!
-- Kanskje ikke så farlig her siden USER_ID og YYYYMMDD begrenser søket til en liten partisjon, men fortsatt ikke optimalt.
SELECT * FROM user_events
WHERE user_id = 'student003'
AND yyyymmdd = 20260401
AND event_type = 'login'
ALLOW FILTERING;

-- Bør unngås: Hent alle login events for alle brukere.
-- Må søke i alle noder og partisjoner.
SELECT * FROM user_events
WHERE event_type = 'login'
   ALLOW FILTERING;
-- =====================================================
-- EXPLAIN: Primary Key Structure
-- =====================================================
-- PRIMARY KEY ((user_id), yyyymmdd, event_time)
--
-- Partition Key: (user_id)
--   - Bestemmer hvilken node i clusteret som lagrer dataen
--   - All data for samme user_id lagres på samme node
--   - MÅ alltid brukes i WHERE clause for effektive queries
--
-- Clustering Columns: yyyymmdd, event_time
--   - Bestemmer sorteringsrekkefølgen INNENFOR en partisjon
--   - Data sorteres DESC (nyeste først) pga CLUSTERING ORDER BY
--   - Muliggjør effektive range queries innenfor en partisjon
--   - Må brukes i rekkefølge i WHERE clause (først yyyymmdd, deretter event_time)
--
-- Hvorfor denne strukturen?
--   - Gode queries: "Hent alle events for bruker X"
--   - Gode queries: "Hent events for bruker X på dag Y"
--   - Dårlige queries: "Hent alle events av type login" (krever ALLOW FILTERING)
--   - Dårlige queries: "Hent events for alle brukere" (full table scan)


-- Show table structure
--DESCRIBE TABLE user_events;

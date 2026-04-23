-- =============================================================
-- create-demo-data.cql
-- Oppretter keyspace, tabeller og testdata for Cassandra-demo.
-- Inneholder to tabeller:
--   - teacher (enkel tabell med UUID som primærnøkkel)
--   - user_events (partisjonsnøkkel + klusterkolonner)
--
-- Kjøres slik:
--   docker exec -i dat107-cassandra cqlsh < create-demo-data.cql
-- =============================================================

-- Slett keyspace hvis det finnes fra før (for re-kjøring)
DROP KEYSPACE IF EXISTS hvl_db;

-- Opprett keyspace for single-node cluster
CREATE KEYSPACE hvl_db
WITH replication = {
    'class': 'SimpleStrategy',
    'replication_factor': 1
}
AND durable_writes = true;

USE hvl_db;

-- =============================================================
-- Tabell 1: teacher
-- Enkel tabell med UUID som primærnøkkel
-- =============================================================

CREATE TABLE teacher (
    id UUID PRIMARY KEY,
    fornavn TEXT,
    etternavn TEXT
);

INSERT INTO teacher (id, fornavn, etternavn) VALUES (uuid(), 'Dag', 'Toppe Larsen');
INSERT INTO teacher (id, fornavn, etternavn) VALUES (uuid(), 'Lars-Petter', 'Helland');
INSERT INTO teacher (id, fornavn, etternavn) VALUES (uuid(), 'Lasse', 'Jenssen');

-- =============================================================
-- Tabell 2: user_events
-- Demonstrerer partisjonsnøkkel og klusterkolonner
--
-- PRIMARY KEY ((user_id), yyyymmdd, event_time)
--   Partisjonsnøkkel:  user_id
--   Klusterkolonner:   yyyymmdd, event_time
-- =============================================================

CREATE TABLE user_events (
    user_id TEXT,
    yyyymmdd INT,
    event_time TIMESTAMP,
    event_type TEXT,
    details TEXT,
    PRIMARY KEY ((user_id), yyyymmdd, event_time)
) WITH CLUSTERING ORDER BY (yyyymmdd DESC, event_time DESC);

-- student001 (20 events)
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

-- student002 (20 events)
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

-- student003 (20 events)
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

-- student004 (20 events)
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

-- student005 (20 events)
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


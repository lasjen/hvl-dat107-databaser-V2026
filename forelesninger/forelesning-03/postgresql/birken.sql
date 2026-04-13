-- =====================================================
-- Schema and setup
-- =====================================================
CREATE SCHEMA if not exists video06;
SET search_path = video06;


-- Rerun-friendly cleanup
DROP TABLE IF EXISTS deltaker;
DROP TABLE IF EXISTS pulje;

-- =====================================================
-- Table: pulje
-- =====================================================
CREATE TABLE pulje (
  p_id       INTEGER PRIMARY KEY,
  start_tid  TIMESTAMP NOT NULL
);

-- =====================================================
-- Table: deltaker (relational, no XML column)
-- Note: fdato is TEXT to preserve source value 1975-03-00.
-- =====================================================
CREATE TABLE deltaker (
  id           VARCHAR(10) PRIMARY KEY,
  navn         VARCHAR(100) NOT NULL,
  fdato        DATE NOT NULL,
  fnr          VARCHAR(11),
  medlem       BOOLEAN NOT NULL,
  poeng        NUMERIC(7,2) NOT NULL,
  hjemmeside   VARCHAR(255),
  pulje_id     INTEGER NOT NULL REFERENCES pulje(p_id),
  foresatt_id  VARCHAR(10),
  lisens       VARCHAR(20) NOT NULL
);

-- =====================================================
-- Insert data: pulje
-- =====================================================
INSERT INTO pulje (p_id, start_tid)
VALUES
  (1, '2026-03-15T08:00:00'),
  (2, '2026-03-15T08:30:00'),
  (3, '2026-03-15T09:00:00'),
  (4, '2026-03-15T09:30:00'),
  (5, '2026-03-15T10:00:00');

-- =====================================================
-- Insert data: deltaker
-- =====================================================
INSERT INTO deltaker (id, navn, fdato, fnr, medlem, poeng, hjemmeside, pulje_id, foresatt_id, lisens)
VALUES
  ('h0001', 'Lasse Jenssen', '1983-05-12', '12058348217', TRUE, 1200.01, 'https://www.jcon.no/blog', 1, NULL, 'helårs'),
  ('h0002', 'Ola Hansen', '1975-03-06', NULL, TRUE, 4405.21, 'www.olahansen.no', 1, NULL, 'enkel'),
  ('d0005', 'Norah Jenssen', '2012-12-02', '02121250683', FALSE, 621.23, 'https://www.jenssen.no/nora', 1, 'h0001', 'ikke registrert'),
  ('h0003', 'Jonas Berg', '1988-01-14', '14018883725', TRUE, 980.12, 'https://example.com/jonas-berg', 1, NULL, 'helårs'),
  ('h0004', 'Mats Lunde', '1990-04-21', '21049019357', FALSE, 765.33, 'https://example.com/mats-lunde', 1, NULL, 'enkel'),
  ('h0005', 'Thomas Engen', '1988-05-03', '03058862491', TRUE, 905.20, 'https://example.com/thomas-engen', 1, NULL, 'ikke registrert'),
  ('h0006', 'Henrik Aas', '1982-11-05', '05118228530', TRUE, 1105.44, 'https://example.com/henrik-aas', 1, NULL, 'helårs'),
  ('h0007', 'Anders Lie', '1979-09-18', '18097959372', FALSE, 845.67, 'https://example.com/anders-lie', 1, NULL, 'enkel'),
  ('h0008', 'Kristoffer Moe', '1995-02-10', '10029528463', TRUE, 930.22, 'https://example.com/kristoffer-moe', 1, 'h0007', 'ikke registrert'),
  ('h0009', 'Sindre Johansen', '1986-07-29', '29078613504', TRUE, 1010.50, 'https://example.com/sindre-johansen', 1, NULL, 'helårs'),
  ('h0010', 'Emil Røed', '1992-03-12', '12039202758', FALSE, 720.84, 'https://example.com/emil-rod', 1, NULL, 'enkel'),
  ('h0011', 'Vetle Skaar', '1984-05-22', '22058455370', TRUE, 990.77, 'https://example.com/vetle-skaar', 1, NULL, 'ikke registrert'),
  ('h0012', 'Trym Eide', '1981-10-09', '09108118065', FALSE, 800.12, 'https://example.com/trym-eide', 1, NULL, 'helårs'),
  ('h0013', 'Leif Knutsen', '1977-08-16', '16087720793', TRUE, 1055.66, 'https://example.com/leif-knutsen', 1, NULL, 'enkel'),
  ('h0014', 'Petter Dahl', '1993-06-03', '03069396218', FALSE, 760.42, 'https://example.com/petter-dahl', 1, NULL, 'ikke registrert'),
  ('h0015', 'Jørgen Hauge', '1989-12-24', '24128953601', TRUE, 1005.90, 'https://example.com/jorgen-hauge', 1, NULL, 'helårs'),
  ('h0016', 'Eirik Tansen', '1987-02-27', '27028704215', FALSE, 835.13, 'https://example.com/eirik-tangen', 1, NULL, 'enkel'),
  ('h0017', 'Sigurd Vik', '1980-01-30', '30018075624', TRUE, 1120.88, 'https://example.com/sigurd-vik', 1, NULL, 'ikke registrert'),
  ('h0018', 'Filip Nymoen', '1996-09-11', '11099669458', FALSE, 745.25, 'https://example.com/filip-nymoen', 1, NULL, 'helårs'),
  ('h0019', 'Ulrik Foss', '1978-04-07', '07047848516', TRUE, 990.31, 'https://example.com/ulrik-foss', 1, NULL, 'enkel'),
  ('h0020', 'Ruben Sand', '1991-11-19', '19119119832', FALSE, 780.64, 'https://example.com/ruben-sand', 1, NULL, 'ikke registrert'),
  ('h0021', 'Kristian Lund', '1985-03-23', '23038576014', TRUE, 1025.47, 'https://example.com/kristian-lund', 1, NULL, 'helårs'),
  ('h0022', 'Kenneth Myhre', '1983-07-02', '02078316275', FALSE, 850.76, 'https://example.com/kenneth-myhre', 1, NULL, 'enkel'),
  ('d0006', 'Marie Solberg', '1994-02-08', '08029472613', TRUE, 970.33, 'https://example.com/marie-solberg', 1, NULL, 'ikke registrert'),
  ('d0007', 'Silje Haug', '1990-10-15', '15109001349', FALSE, 720.22, 'https://example.com/silje-haug', 1, NULL, 'helårs'),
  ('d0008', 'Line Karlsen', '1988-06-19', '19068885403', TRUE, 990.55, 'https://example.com/line-karlsen', 1, NULL, 'enkel'),
  ('d0009', 'Nora Vik', '1975-11-30', '30119551327', FALSE, 740.68, 'https://example.com/nora-vik', 1, NULL, 'ikke registrert'),
  ('d0010', 'Tuva Nilsen', '1998-01-05', '05019213598', TRUE, 950.10, 'https://example.com/tuva-nilsen', 1, 'd0009', 'helårs'),
  ('d0011', 'Camilla Andersen', '1987-03-28', '28038760941', FALSE, 760.91, 'https://example.com/camilla-andersen', 1, NULL, 'enkel'),
  ('d0012', 'Ida Berg', '1991-04-17', '17049174162', TRUE, 980.44, 'https://example.com/ida-berg', 1, NULL, 'ikke registrert'),
  ('d0013', 'Emilie Larsen', '1996-07-22', '22079680435', FALSE, 740.21, 'https://example.com/emilie-larsen', 1, NULL, 'helårs'),
  ('d0014', 'Ragnhild Myklebust', '1983-08-11', '11088343890', TRUE, 1015.32, 'https://example.com/ragnhild-myklebust', 1, NULL, 'enkel'),
  ('d0015', 'Sara Holte', '1989-09-09', '09098938157', FALSE, 780.70, 'https://example.com/sara-holte', 1, NULL, 'ikke registrert'),
  ('d0016', 'Helene Østby', '1985-12-13', '13128526740', TRUE, 995.88, 'https://example.com/helene-ostby', 1, NULL, 'helårs'),
  ('d0017', 'Frida Sunde', '1993-02-02', '02029314965', FALSE, 760.10, 'https://example.com/frida-sunde', 1, NULL, 'enkel'),
  ('d0018', 'Karoline Fladmark', '1987-06-25', '25068735219', TRUE, 985.11, 'https://example.com/karoline-fladmark', 1, NULL, 'ikke registrert'),
  ('d0019', 'Hanna Rønning', '1997-05-04', '04059747036', FALSE, 735.44, 'https://example.com/hanna-ronning', 1, NULL, 'helårs'),
  ('d0020', 'Vilde Andreassen', '1990-03-01', '01039090671', TRUE, 1000.12, 'https://example.com/vilde-andreassen', 1, NULL, 'enkel'),
  ('d0021', 'Emma Bråthen', '1994-11-07', '07119470825', FALSE, 750.33, 'https://example.com/emma-brathen', 1, NULL, 'ikke registrert'),
  ('d0022', 'Kristine Haugen', '1986-08-18', '18088643910', TRUE, 995.44, 'https://example.com/kristine-haugen', 1, NULL, 'helårs'),
  ('d0023', 'Julie Storm', '1992-09-29', '29099287613', FALSE, 770.80, 'https://example.com/julie-storm', 1, NULL, 'enkel'),
  ('d0024', 'Malin Thorsen', '1995-01-16', '16019501973', TRUE, 960.12, 'https://example.com/malin-thorsen', 1, NULL, 'ikke registrert'),
  ('d0025', 'Andrea Olsen', '1998-10-10', '10109815602', FALSE, 740.22, 'https://example.com/andrea-olsen', 1, NULL, 'helårs');

-- =====================================================
-- Fordel deltakere jevnt mellom puljer basert på poeng.
-- Høyest poengsum havner i laveste pulje_id.
-- =====================================================
WITH assigned AS (
  SELECT
    id,
    ntile(5) OVER (ORDER BY poeng DESC, id) AS ny_pulje
  FROM deltaker
)
UPDATE deltaker d
SET pulje_id = a.ny_pulje
FROM assigned a
WHERE d.id = a.id;

COMMIT;


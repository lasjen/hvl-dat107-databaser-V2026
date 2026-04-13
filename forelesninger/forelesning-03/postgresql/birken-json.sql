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
  pId       INTEGER,
  startTid  TIMESTAMP,
  CONSTRAINT pulje_pk PRIMARY KEY (pId)
);

-- =====================================================
-- Table: deltaker
-- =====================================================
CREATE TABLE deltaker (
  id VARCHAR(10),
  puljeId INTEGER,
  json_info  JSONB,
  CONSTRAINT deltaker_pk PRIMARY KEY (id),
  CONSTRAINT deltaker_pulje_fk FOREIGN KEY (puljeId) REFERENCES pulje(pId)
);

-- =====================================================
-- Insert data: pulje
-- =====================================================
INSERT INTO pulje (pId, startTid)
VALUES
  (1, '2026-03-15T08:00:00'),
  (2, '2026-03-15T08:30:00'),
  (3, '2026-03-15T09:00:00'),
  (4, '2026-03-15T09:30:00'),
  (5, '2026-03-15T10:00:00');

-- =====================================================
-- Insert data: deltaker
-- =====================================================
INSERT INTO deltaker (id, puljeId, json_info)
VALUES
  ('h0001', 1, '{"lisens":"helårs","navn":"Lasse Jenssen","fdato":"1983-05-12","fnr":"12058348217","poeng":1200.01,"hjemmeside":"https://www.jcon.no/blog"}'),
  ('h0002', 1, '{"lisens":"enkel","navn":"Ola Hansen","fdato":"1975-03-00","medlem":true,"poeng":4405.21,"hjemmeside":"www.olahansen.no"}'),
  ('d0005', 1, '{"lisens":"ikke registrert","navn":"Norah Jenssen","fdato":"2012-12-02","fnr":"02121250683","poeng":621.23,"hjemmeside":"https://www.jenssen.no/nora","foresattId":"h0001"}'),
  ('h0003', 1, '{"lisens":"helårs","navn":"Jonas Berg","fdato":"1988-01-14","fnr":"14018883725","medlem":true,"poeng":980.12,"hjemmeside":"https://example.com/jonas-berg"}'),
  ('h0004', 1, '{"lisens":"enkel","navn":"Mats Lunde","fdato":"1990-04-21","fnr":"21049019357","poeng":765.33,"hjemmeside":"https://example.com/mats-lunde"}'),
  ('h0005', 1, '{"lisens":"ikke registrert","navn":"Thomas Engen","fdato":"1988-05-03","fnr":"03058862491","medlem":true,"poeng":905.20,"hjemmeside":"https://example.com/thomas-engen"}'),
  ('h0006', 1, '{"lisens":"helårs","navn":"Henrik Aas","fdato":"1982-11-05","fnr":"05118228530","medlem":true,"poeng":1105.44,"hjemmeside":"https://example.com/henrik-aas"}'),
  ('h0007', 1, '{"lisens":"enkel","navn":"Anders Lie","fdato":"1971-09-18","fnr":"18097959372","poeng":845.67,"hjemmeside":"https://example.com/anders-lie"}'),
  ('h0008', 1, '{"lisens":"ikke registrert","navn":"Kristoffer Lie","fdato":"1995-02-10","fnr":"10029528463","medlem":true,"poeng":930.22,"hjemmeside":"https://example.com/kristoffer-moe","foresattId":"h0007"}'),
  ('h0009', 1, '{"lisens":"helårs","navn":"Sindre Johansen","fdato":"1986-07-29","fnr":"29078613504","medlem":true,"poeng":1010.50,"hjemmeside":"https://example.com/sindre-johansen"}'),
  ('h0010', 1, '{"lisens":"enkel","navn":"Emil Røed","fdato":"1992-03-12","fnr":"12039202758","poeng":720.84,"hjemmeside":"https://example.com/emil-rod"}'),
  ('h0011', 1, '{"lisens":"ikke registrert","navn":"Vetle Skaar","fdato":"1984-05-22","fnr":"22058455370","medlem":true,"poeng":990.77,"hjemmeside":"https://example.com/vetle-skaar"}'),
  ('h0012', 1, '{"lisens":"helårs","navn":"Trym Eide","fdato":"1981-10-09","fnr":"09108118065","poeng":800.12,"hjemmeside":"https://example.com/trym-eide"}'),
  ('h0013', 1, '{"lisens":"enkel","navn":"Leif Knutsen","fdato":"1977-08-16","fnr":"16087720793","medlem":true,"poeng":1055.66,"hjemmeside":"https://example.com/leif-knutsen"}'),
  ('h0014', 1, '{"lisens":"ikke registrert","navn":"Petter Dahl","fdato":"1993-06-03","fnr":"03069396218","poeng":760.42,"hjemmeside":"https://example.com/petter-dahl"}'),
  ('h0015', 1, '{"lisens":"helårs","navn":"Jørgen Hauge","fdato":"1989-12-24","fnr":"24128953601","medlem":true,"poeng":1005.90,"hjemmeside":"https://example.com/jorgen-hauge"}'),
  ('h0016', 1, '{"lisens":"enkel","navn":"Eirik Tangen","fdato":"1987-02-27","fnr":"27028704215","poeng":835.13,"hjemmeside":"https://example.com/eirik-tangen"}'),
  ('h0017', 1, '{"lisens":"ikke registrert","navn":"Sigurd Vik","fdato":"1980-01-30","fnr":"30018075624","medlem":true,"poeng":1120.88,"hjemmeside":"https://example.com/sigurd-vik"}'),
  ('h0018', 1, '{"lisens":"helårs","navn":"Filip Nymoen","fdato":"1996-09-11","fnr":"11099669458","poeng":745.25,"hjemmeside":"https://example.com/filip-nymoen"}'),
  ('h0019', 1, '{"lisens":"enkel","navn":"Ulrik Foss","fdato":"1978-04-07","fnr":"07047848516","medlem":true,"poeng":990.31,"hjemmeside":"https://example.com/ulrik-foss"}'),
  ('h0020', 1, '{"lisens":"ikke registrert","navn":"Ruben Sand","fdato":"1991-11-19","fnr":"19119119832","poeng":780.64,"hjemmeside":"https://example.com/ruben-sand"}'),
  ('h0021', 1, '{"lisens":"helårs","navn":"Kristian Lund","fdato":"1985-03-23","fnr":"23038576014","medlem":true,"poeng":1025.47,"hjemmeside":"https://example.com/kristian-lund"}'),
  ('h0022', 1, '{"lisens":"enkel","navn":"Kenneth Myhre","fdato":"1983-07-02","fnr":"02078316275","poeng":850.76,"hjemmeside":"https://example.com/kenneth-myhre"}'),
  ('d0006', 1, '{"lisens":"ikke registrert","navn":"Marie Solberg","fdato":"1994-02-08","fnr":"08029472613","medlem":true,"poeng":970.33,"hjemmeside":"https://example.com/marie-solberg"}'),
  ('d0007', 1, '{"lisens":"helårs","navn":"Silje Haug","fdato":"1990-10-15","fnr":"15109001349","poeng":720.22,"hjemmeside":"https://example.com/silje-haug"}'),
  ('d0008', 1, '{"lisens":"enkel","navn":"Line Karlsen","fdato":"1988-06-19","fnr":"19068885403","medlem":true,"poeng":990.55,"hjemmeside":"https://example.com/line-karlsen"}'),
  ('d0009', 1, '{"lisens":"ikke registrert","navn":"Nora Vik","fdato":"1975-11-30","fnr":"30119551327","poeng":740.68,"hjemmeside":"https://example.com/nora-vik"}'),
  ('d0010', 1, '{"lisens":"helårs","navn":"Tuva Nilsen","fdato":"1998-01-05","fnr":"05019213598","medlem":true,"poeng":950.10,"hjemmeside":"https://example.com/tuva-nilsen","foresattId":"d0009"}'),
  ('d0011', 1, '{"lisens":"enkel","navn":"Camilla Andersen","fdato":"1987-03-28","fnr":"28038760941","poeng":760.91,"hjemmeside":"https://example.com/camilla-andersen"}'),
  ('d0012', 1, '{"lisens":"ikke registrert","navn":"Ida Berg","fdato":"1991-04-17","fnr":"17049174162","medlem":true,"poeng":980.44,"hjemmeside":"https://example.com/ida-berg"}'),
  ('d0013', 1, '{"lisens":"helårs","navn":"Emilie Larsen","fdato":"1996-07-22","fnr":"22079680435","poeng":740.21,"hjemmeside":"https://example.com/emilie-larsen"}'),
  ('d0014', 1, '{"lisens":"enkel","navn":"Ragnhild Myklebust","fdato":"1983-08-11","fnr":"11088343890","medlem":true,"poeng":1015.32,"hjemmeside":"https://example.com/ragnhild-myklebust"}'),
  ('d0015', 1, '{"lisens":"ikke registrert","navn":"Sara Holte","fdato":"1989-09-09","fnr":"09098938157","poeng":780.70,"hjemmeside":"https://example.com/sara-holte"}'),
  ('d0016', 1, '{"lisens":"helårs","navn":"Helene Østby","fdato":"1985-12-13","fnr":"13128526740","medlem":true,"poeng":995.88,"hjemmeside":"https://example.com/helene-ostby"}'),
  ('d0017', 1, '{"lisens":"enkel","navn":"Frida Sunde","fdato":"1993-02-02","fnr":"02029314965","poeng":760.10,"hjemmeside":"https://example.com/frida-sunde"}'),
  ('d0018', 1, '{"lisens":"ikke registrert","navn":"Karoline Fladmark","fdato":"1987-06-25","fnr":"25068735219","medlem":true,"poeng":985.11,"hjemmeside":"https://example.com/karoline-fladmark"}'),
  ('d0019', 1, '{"lisens":"helårs","navn":"Hanna Rønning","fdato":"1997-05-04","fnr":"04059747036","poeng":735.44,"hjemmeside":"https://example.com/hanna-ronning"}'),
  ('d0020', 1, '{"lisens":"enkel","navn":"Vilde Andreassen","fdato":"1990-03-01","fnr":"01039090671","medlem":true,"poeng":1000.12,"hjemmeside":"https://example.com/vilde-andreassen"}'),
  ('d0021', 1, '{"lisens":"ikke registrert","navn":"Emma Bråthen","fdato":"1994-11-07","fnr":"07119470825","poeng":750.33,"hjemmeside":"https://example.com/emma-brathen"}'),
  ('d0022', 1, '{"lisens":"helårs","navn":"Kristine Haugen","fdato":"1986-08-18","fnr":"18088643910","medlem":true,"poeng":995.44,"hjemmeside":"https://example.com/kristine-haugen"}'),
  ('d0023', 1, '{"lisens":"enkel","navn":"Julie Storm","fdato":"1992-09-29","fnr":"29099287613","poeng":770.80,"hjemmeside":"https://example.com/julie-storm"}'),
  ('d0024', 1, '{"lisens":"ikke registrert","navn":"Malin Thorsen","fdato":"1995-01-16","fnr":"16019501973","medlem":true,"poeng":960.12,"hjemmeside":"https://example.com/malin-thorsen"}'),
  ('d0025', 1, '{"lisens":"helårs","navn":"Andrea Olsen","fdato":"1998-10-10","fnr":"10109815602","poeng":740.22,"hjemmeside":"https://example.com/andrea-olsen"}');

-- Fordel deltakere jevnt mellom puljer basert pa poeng.
-- Hoyest poengsum havner i laveste puljeId.
WITH scored AS (
  SELECT
    id,
    (json_info->>'poeng')::numeric AS poeng
  FROM deltaker
), assigned AS (
  SELECT
    id,
    ntile(5) OVER (ORDER BY poeng DESC, id) AS ny_pulje
  FROM scored
)
UPDATE deltaker d
SET puljeId = a.ny_pulje
FROM assigned a
WHERE d.id = a.id;

COMMIT;


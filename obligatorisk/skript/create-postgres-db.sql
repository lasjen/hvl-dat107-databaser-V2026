-- ---------------------------------------------
-- PostgreSQL: Create schema and set search path
-- ---------------------------------------------
CREATE SCHEMA IF NOT EXISTS oblig;
SET search_path = oblig;

-- Drop tables if they exist (for clean re-runs)
DROP TABLE IF EXISTS medlemsavgift;
DROP TABLE IF EXISTS medlem;
DROP TABLE IF EXISTS lokallag;

CREATE TABLE lokallag (
   lokallag_id              SERIAL
    CONSTRAINT pk_lokallag PRIMARY KEY,
   lagnavn                  VARCHAR(200) NOT NULL,

   motelokale_gateadresse   VARCHAR(200) NOT NULL,
   motelokale_postnr        VARCHAR(4)   NOT NULL,
   motelokale_poststed      VARCHAR(100) NOT NULL,

   leder_medlemsnummer      INTEGER NULL  -- FK legges på etterpå pga sirkel
);

-- (Valgfritt, men ofte ønskelig) lagnavn unikt
ALTER TABLE lokallag
   ADD CONSTRAINT uq_lokallag_lagnavn UNIQUE (lagnavn);

-- (Valgfritt) enkel sjekk for postnummer-format (4 siffer)
ALTER TABLE lokallag
   ADD CONSTRAINT ck_lokallag_postnr
      CHECK (motelokale_postnr ~ '^[0-9]{4}$');

CREATE TABLE medlem (
   medlemsnummer    INTEGER
     CONSTRAINT pk_medlem PRIMARY KEY,

   fornavn          VARCHAR(100) NOT NULL,
   etternavn        VARCHAR(100) NOT NULL,
   telefon          VARCHAR(30),
   epost            VARCHAR(200),

   gateadresse      VARCHAR(200) NOT NULL,
   postnr           VARCHAR(4)   NOT NULL,
   poststed         VARCHAR(100) NOT NULL,

   aktiv            boolean DEFAULT false constraint medlem_aktiv_nn NOT NULL,

   lokallag_id      INTEGER NOT NULL
);

-- FK: alle medlemmer er med i nøyaktig ett lokallag
ALTER TABLE medlem
   ADD CONSTRAINT fk_medlem_lokallag
      FOREIGN KEY (lokallag_id)
         REFERENCES lokallag (lokallag_id);

-- (Valgfritt) epost unik, om dere ønsker det
ALTER TABLE medlem
   ADD CONSTRAINT uq_medlem_epost UNIQUE (epost);

CREATE TABLE medlemsavgift (
   medlemsnummer   INTEGER NOT NULL,
   ar              INTEGER NOT NULL,
   betalt          CHAR(1) DEFAULT 'N' NOT NULL
      CONSTRAINT ck_avgift_betalt CHECK (betalt IN ('J','N')),
   betalingsdato   DATE,

   CONSTRAINT pk_medlemsavgift PRIMARY KEY (medlemsnummer, ar),
   CONSTRAINT fk_avgift_medlem FOREIGN KEY (medlemsnummer)
      REFERENCES medlem (medlemsnummer),
   CONSTRAINT ck_avgift_ar CHECK (ar BETWEEN 1900 AND 2100),
   CONSTRAINT ck_avgift_dato CHECK (
      (betalt = 'J' AND betalingsdato IS NOT NULL)
         OR
      (betalt = 'N' AND betalingsdato IS NULL)
      )
);



-- ------------------------------------------------------------
-- Insert sample data
-- ------------------------------------------------------------

-- Insert 1 lokallag
INSERT INTO lokallag (lagnavn, motelokale_gateadresse, motelokale_postnr, motelokale_poststed, leder_medlemsnummer)
VALUES ('Bergen Brettspillklubb', 'Strandgaten 15', '5013', 'Bergen', NULL);

-- Insert 30 medlemmer
INSERT INTO medlem (medlemsnummer, fornavn, etternavn, telefon, epost, gateadresse, postnr, poststed, aktiv, lokallag_id)
VALUES
(1001, 'Lars', 'Jenssen', '12345678', 'lasse.jenssen@hvl.no', 'Inndalsveien 28', '5063', 'Bergen', true, 1),
(1002, 'Kari', 'Hansen', '23456789', 'kari.hansen@example.com', 'Nygårdsgaten 10', '5015', 'Bergen', true, 1),
(1003, 'Ola', 'Nordmann', '34567890', 'ola.nordmann@example.com', 'Christies gate 5', '5015', 'Bergen', true, 1),
(1004, 'Emma', 'Nilsen', '45678901', 'emma.nilsen@example.com', 'Welhavens gate 20', '5006', 'Bergen', true, 1),
(1005, 'Jonas', 'Berg', '56789012', 'jonas.berg@example.com', 'Løvstakksiden 3', '5034', 'Bergen', true, 1),
(1006, 'Ingrid', 'Olsen', '67890123', 'ingrid.olsen@example.com', 'Kaigaten 7', '5013', 'Bergen', true, 1),
(1007, 'Erik', 'Andersen', '78901234', 'erik.andersen@example.com', 'Strandgaten 25', '5013', 'Bergen', true, 1),
(1008, 'Sara', 'Eriksen', '89012345', 'sara.eriksen@example.com', 'Kong Oscars gate 15', '5017', 'Bergen', true, 1),
(1009, 'Martin', 'Lie', '90123456', 'martin.lie@example.com', 'Hollendergaten 8', '5011', 'Bergen', true, 1),
(1010, 'Marte', 'Sæther', '01234567', 'marte.saether@example.com', 'Nordnes sjøbad 1', '5005', 'Bergen', true, 1),
(1011, 'Thomas', 'Moen', '11223344', 'thomas.moen@example.com', 'Sandviksbodene 12', '5035', 'Bergen', true, 1),
(1012, 'Sofie', 'Lund', '22334455', 'sofie.lund@example.com', 'Møhlenpris 18', '5006', 'Bergen', true, 1),
(1013, 'Henrik', 'Dahl', '33445566', 'henrik.dahl@example.com', 'Damsgårdsveien 40', '5058', 'Bergen', true, 1),
(1014, 'Nora', 'Bakke', '44556677', 'nora.bakke@example.com', 'Åsane Senter 2', '5116', 'Ulset', true, 1),
(1015, 'Markus', 'Hauge', '55667788', 'markus.hauge@example.com', 'Fyllingsveien 55', '5147', 'Fyllingsdalen', true, 1),
(1016, 'Julie', 'Solberg', '66778899', 'julie.solberg@example.com', 'Lagunen 3', '5239', 'Rådal', true, 1),
(1017, 'Andreas', 'Vik', '77889900', 'andreas.vik@example.com', 'Nesttunbrekka 7', '5221', 'Nesttun', true, 1),
(1018, 'Thea', 'Hagen', '88990011', 'thea.hagen@example.com', 'Sandsliåsen 20', '5254', 'Sandsli', true, 1),
(1019, 'Magnus', 'Rønning', '99001122', 'magnus.ronning@example.com', 'Storetveitvegen 15', '5072', 'Bergen', true, 1),
(1020, 'Emilie', 'Knutsen', '00112233', 'emilie.knutsen@example.com', 'Haukeland 45', '5021', 'Bergen', true, 1),
(1021, 'Kristian', 'Berge', '11223355', 'kristian.berge@example.com', 'Fantoft 12', '5072', 'Bergen', false, 1),
(1022, 'Amalie', 'Myklebust', '22334466', 'amalie.myklebust@example.com', 'Paradis 8', '5232', 'Paradis', false, 1),
(1023, 'Sander', 'Tveit', '33445577', 'sander.tveit@example.com', 'Hop 22', '5232', 'Paradis', false, 1),
(1024, 'Mathilde', 'Strand', '44556688', 'mathilde.strand@example.com', 'Breistein 5', '5104', 'Breistein', true, 1),
(1025, 'Alexander', 'Foss', '55667799', 'alexander.foss@example.com', 'Kokstad 33', '5257', 'Kokstad', true, 1),
(1026, 'Victoria', 'Berntsen', '66778800', 'victoria.berntsen@example.com', 'Midtun 16', '5224', 'Nesttun', true, 1),
(1027, 'Daniel', 'Larsen', '77889911', 'daniel.larsen@example.com', 'Hylkje 9', '5109', 'Hylkje', true, 1),
(1028, 'Ida', 'Kristiansen', '88990022', 'ida.kristiansen@example.com', 'Ytre Arna 40', '5267', 'Ytre Arna', true, 1),
(1029, 'Sebastian', 'Pedersen', '99001133', 'sebastian.pedersen@example.com', 'Indre Arna 25', '5269', 'Indre Arna', true, 1),
(1030, 'Linnea', 'Johannessen', '00112244', 'linnea.johannessen@example.com', 'Eidsvåg 18', '5105', 'Eidsvåg', true, 1);

-- Update lokallag with leder_medlemsnummer
UPDATE lokallag SET leder_medlemsnummer = 1001 WHERE lokallag_id = 1;

-- Insert medlemsavgift for de siste 10 årene (2017-2026)
-- For årene 2017-2025: alle betalt
-- For året 2026: ingen betalt ennå

-- 2017 (alle betalt)
INSERT INTO medlemsavgift (medlemsnummer, ar, betalt, betalingsdato)
SELECT medlemsnummer, 2017, 'J', DATE '2017-01-15' + (medlemsnummer - 1000) * INTERVAL '1 day'
FROM medlem;

-- 2018 (alle betalt)
INSERT INTO medlemsavgift (medlemsnummer, ar, betalt, betalingsdato)
SELECT medlemsnummer, 2018, 'J', DATE '2018-01-15' + (medlemsnummer - 1000) * INTERVAL '1 day'
FROM medlem;

-- 2019 (alle betalt)
INSERT INTO medlemsavgift (medlemsnummer, ar, betalt, betalingsdato)
SELECT medlemsnummer, 2019, 'J', DATE '2019-01-15' + (medlemsnummer - 1000) * INTERVAL '1 day'
FROM medlem;

-- 2020 (alle betalt)
INSERT INTO medlemsavgift (medlemsnummer, ar, betalt, betalingsdato)
SELECT medlemsnummer, 2020, 'J', DATE '2020-01-15' + (medlemsnummer - 1000) * INTERVAL '1 day'
FROM medlem;

-- 2021 (alle betalt)
INSERT INTO medlemsavgift (medlemsnummer, ar, betalt, betalingsdato)
SELECT medlemsnummer, 2021, 'J', DATE '2021-01-15' + (medlemsnummer - 1000) * INTERVAL '1 day'
FROM medlem;

-- 2022 (alle betalt)
INSERT INTO medlemsavgift (medlemsnummer, ar, betalt, betalingsdato)
SELECT medlemsnummer, 2022, 'J', DATE '2022-01-15' + (medlemsnummer - 1000) * INTERVAL '1 day'
FROM medlem;

-- 2023 (alle betalt)
INSERT INTO medlemsavgift (medlemsnummer, ar, betalt, betalingsdato)
SELECT medlemsnummer, 2023, 'J', DATE '2023-01-15' + (medlemsnummer - 1000) * INTERVAL '1 day'
FROM medlem;

-- 2024 (alle betalt)
INSERT INTO medlemsavgift (medlemsnummer, ar, betalt, betalingsdato)
SELECT medlemsnummer, 2024, 'J', DATE '2024-01-15' + (medlemsnummer - 1000) * INTERVAL '1 day'
FROM medlem;

-- 2025 (alle betalt)
INSERT INTO medlemsavgift (medlemsnummer, ar, betalt, betalingsdato)
SELECT medlemsnummer, 2025, 'J', DATE '2025-01-15' + (medlemsnummer - 1000) * INTERVAL '1 day'
FROM medlem;

-- 2026 (ingen betalt ennå)
INSERT INTO medlemsavgift (medlemsnummer, ar, betalt, betalingsdato)
SELECT medlemsnummer, 2026, 'N', NULL
FROM medlem;

-- 2 medlemmer har betalt for 2026
UPDATE medlemsavgift
SET betalt = 'J', betalingsdato = CURRENT_DATE + (medlemsnummer - 1000) * INTERVAL '1 day'
WHERE ar = 2026 AND medlemsnummer IN (1001, 1002);

commit;
-- ------------------------------------------------------------
-- Verify data
-- ------------------------------------------------------------

SELECT 'Lokallag:' as tabell, COUNT(*) as antall FROM lokallag
UNION ALL
SELECT 'Medlemmer:', COUNT(*) FROM medlem
UNION ALL
SELECT 'Medlemsavgifter:', COUNT(*) FROM medlemsavgift;

-- Show lokallag with leder info
SELECT l.lokallag_id, l.lagnavn, l.motelokale_gateadresse, l.motelokale_poststed,
       m.fornavn || ' ' || m.etternavn as leder
FROM lokallag l
LEFT JOIN medlem m ON l.leder_medlemsnummer = m.medlemsnummer;

-- Show summary of medlemsavgift per år
SELECT ar,
       COUNT(*) as antall_medlemmer,
       SUM(CASE WHEN betalt = 'J' THEN 1 ELSE 0 END) as antall_betalt,
       SUM(CASE WHEN betalt = 'N' THEN 1 ELSE 0 END) as antall_ikke_betalt
FROM medlemsavgift
GROUP BY ar
ORDER BY ar;


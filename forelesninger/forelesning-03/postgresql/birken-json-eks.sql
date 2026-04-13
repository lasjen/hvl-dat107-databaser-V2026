-- =====================================================
-- PostgreSQL JSONB Eksempler
-- Henting av data fra JSONB-kolonne
-- =====================================================
SET search_path = video06;

-- =====================================================
-- EKSEMPEL: se på xml_info for deltakere med id 'h0001' og 'h0002'
-- =====================================================
-- Returnerer hele JSON-en for deltakere med id 'h0001' og 'h0002'
SELECT id, json_info
FROM deltaker
WHERE id IN ('h0001','h0002');

-- =====================================================
-- EKSEMPEL 2:
-- =====================================================
-- Skriv spørring som henter ut id og navn for deltaker id 'h0001' og 'h0002'.
-- Bruk -> og ->> operatorer for å hente verdier
SELECT
  id,
  -- -> returnerer JSONB (med anførselstegn rundt tekstverdier)
  d.json_info->'navn' AS navn_jsonb,
  -- ->> returnerer tekst (uten anførselstegn)
  d.json_info->>'navn' AS navn
FROM deltaker d
WHERE id in ( 'h0001','h0002');

-- Bruk metoden jsonb_path_query()
SELECT
   id,
   jsonb_path_query(d.json_info, '$.navn') AS navn_jsonb
   ,jsonb_path_query(json_info, '$.navn')::text AS navn_text,
   --jsonb_path_query returnerer en array, så vi må hente ut første element
   jsonb_path_query(json_info, '$.navn') ->> 0 AS navn_uten_hermetegn
FROM deltaker d
WHERE id in ( 'h0001', 'h0002');

-- =====================================================
-- EKSEMPEL 3:
-- =====================================================
-- Henter navn og poeng for alle deltakere
SELECT
  id,
  json_info->>'navn' AS navn,
  -- For numeriske verdier må vi caste til numeric
  (json_info->>'poeng')::numeric AS poeng
FROM deltaker;

-- =====================================================
-- EKSEMPEL: ? operatoren
-- =====================================================
-- Finn deltakere som har foresattId
SELECT
   id,
   json_info->>'navn' AS navn,
   json_info->>'foresattId' AS foresatt_id
FROM deltaker d
WHERE d.json_info ? 'foresattId';

-- =====================================================
-- EKSEMPEL:
-- =====================================================
-- Finn deltakere i pulje 1 og vis id, navn og lisens
SELECT
   id,
   json_info->>'navn' AS navn,
   json_info->>'lisens' AS lisens
FROM deltaker d
WHERE d.puljeId = 1;

-- =====================================================
-- EKSEMPEL: @> operatoren
-- =====================================================
-- Finn alle deltakere uten lisens (lisens = "ikke registrert")
-- Bruk @> operatoren for å sjekke om JSON inneholder et bestemt nøkkel-verdi par
SELECT
   id,
   json_info->>'navn' AS navn,
   json_info->>'lisens' AS lisens
FROM deltaker d
WHERE json_info @> '{"lisens": "ikke registrert"}';

-- =====================================================
-- EKSEMPEL: NOT + @> operatoren
-- =====================================================
-- Finn alle deltakere med lisens (dvs de som ikke har "ikke registrert")
SELECT
   id,
   json_info->>'navn' AS navn,
   json_info->>'lisens' AS lisens
FROM deltaker d
WHERE NOT json_info @> '{"lisens": "ikke registrert"}';

-- =====================================================
-- EKSEMPEL:
-- =====================================================
-- Henter 5 deltakere med poeng > 1000 (de med høyest poeng først)
SELECT
  id,
  json_info->>'navn' AS navn,
  (json_info->>'poeng')::numeric AS poeng
FROM deltaker
WHERE (json_info->>'poeng')::numeric > 1000
ORDER BY (json_info->>'poeng')::numeric DESC
LIMIT 5;

-- =====================================================
-- EKSEMPEL: Aggregerings funksjoner
-- =====================================================
-- Finn gjennomsnittlig poeng, maks poeng, min poeng og antall deltakere
SELECT
  AVG((json_info->>'poeng')::numeric) AS gjennomsnitt,
  MAX((json_info->>'poeng')::numeric) AS maksimum,
  MIN((json_info->>'poeng')::numeric) AS minimum,
  COUNT(*) AS antall_deltakere
FROM deltaker;

SELECT
   puljeId,
   AVG((json_info->>'poeng')::numeric) AS gjennomsnitt,
   MAX((json_info->>'poeng')::numeric) AS maksimum,
   MIN((json_info->>'poeng')::numeric) AS minimum,
   COUNT(*) AS antall_deltakere
FROM deltaker
GROUP by puljeId
ORDER BY puljeId;

-- =====================================================
-- EKSEMPEL: ? operator (finnes nøkkel i JSON-en?)
-- =====================================================
-- Finn alle deltakere som er medlemmer.
SELECT
  id,
  json_info->>'navn' AS navn,
  (json_info->>'poeng')::numeric AS poeng,
   json_info->>'medlem' AS medlem
FROM deltaker
WHERE json_info ? 'medlem' AND json_info->>'medlem' = 'true';

-- =====================================================
-- EKSEMPEL: jsonb_set()
-- =====================================================
-- Bruk metoden jsonb_set() for å oppdatere poeng for deltaker h0001 til 1500, og vis både gammelt og nytt poeng.
-- Vis både den gamle poengverdien og den nye poengverdien i resultatet.
-- NB! Ikke endre i tabellen, men hvis metoden brukt i en SELECT.
SELECT
  id,
  json_info->>'navn' AS gammelt_navn,
   (json_info->>'poeng')::numeric AS gammelt_poeng,
  jsonb_set(json_info, '{poeng}', '1500'::jsonb)->>'poeng' AS ny_poeng
FROM deltaker
WHERE id = 'h0001';

UPDATE deltaker
SET json_info = jsonb_set(json_info, '{poeng}', '1500'::jsonb)
WHERE id = 'h0001';

-- Legge til ny nøkkel
UPDATE deltaker
SET json_info = json_info || '{"epost": "lasse@example.com"}'::jsonb
WHERE id = 'h0001';


json_info || '{"epost": "lasse@example.com"}'::jsonb

select *
from deltaker
where id = 'h0001';
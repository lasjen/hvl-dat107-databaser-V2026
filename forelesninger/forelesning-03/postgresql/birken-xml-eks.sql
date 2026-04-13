-- =====================================================
-- PostgreSQL XML Eksempler
-- Henting av data fra XML-kolonne
-- =====================================================
-- Forutsetter at birken-xml.sql er kjørt
--
SET search_path = video06;

-- =====================================================
-- EKSEMPEL 1:
-- =====================================================
-- Returnerer hele XML-en for deltaker h0001 og h0002.
SELECT id, xml_info
FROM deltaker
WHERE id in ('h0001','h0002');

-- =====================================================
-- EKSEMPEL 2:
-- =====================================================
-- Bruker xpath() for å hente navn-elementet og teksten i det (viser ulike eksempler)
SELECT
  id,
  -- Returnerer et array (vises med {} i postgres)
  xpath('/deltaker/navn', d.xml_info) as navn_element
  ,xpath('/deltaker/navn/text()', d.xml_info) as navn_text,
  -- Henter ut første element i arrayet (se datatypen) - dette er fortsatt XML
  (xpath('/deltaker/navn/text()', d.xml_info))[1] AS navn_tekst,
  -- Henter ut første element i arrayet og konverterer til tekst
  (xpath('/deltaker/navn/text()', d.xml_info))[1]::text AS navn
FROM deltaker d
WHERE id in ( 'h0001', 'h0002');

-- =====================================================
-- EKSEMPEL 3:
-- =====================================================
-- Henter navn, id og poeng
SELECT
  id,
  (xpath('//navn/text()', xml_info))[1]::text AS navn,
  (xpath('//poeng/text()', xml_info))[1]::text::numeric AS poeng
  -- Hvis vi prøver å konvertere direkte til numeric uten å hente ut tekst først, får vi feil fordi xpath() returnerer XML, ikke tekst
  --,(xpath('//poeng/text()', xml_info))[1]::numeric AS poeng2
FROM deltaker;

-- =====================================================
-- EKSEMPEL 4:
-- =====================================================
-- Finn deltakere som har foresattId (Tips! Bruk XPATH_EXISTS i WHERE klausulen)
SELECT
   id,
   (xpath('//navn/text()', xml_info))[1]::text AS navn
FROM deltaker
WHERE xpath_exists('//foresattId', xml_info);

-- =====================================================
-- EKSEMPEL 5:
-- =====================================================
-- Finn deltakere i pulje 1 og vis id, navn og lisens
-- Legg merke til at vi ikke bruker text() for å hente ut attributter verdier.
SELECT
   id,
   (xpath('//navn/text()', xml_info))[1]::text AS navn,
   (xpath('/deltaker/@lisens', xml_info))[1]::text AS lisens
FROM deltaker d
WHERE d.puljeId = 1;

-- =====================================================
-- EKSEMPEL 6:
-- =====================================================
-- Finn alle deltakere uten lisens (dvs. lisens = "ikke registrert")
SELECT
   id,
   (xpath('//navn/text()', xml_info))[1]::text AS navn,
   (xpath('/deltaker/@lisens', xml_info))[1]::text AS lisens
FROM deltaker d
WHERE xpath_exists('//deltaker[@lisens="ikke registrert"]', xml_info);

-- =====================================================
-- EKSEMPEL 7:
-- =====================================================
-- Finn alle deltakere med lisens (dvs de som ikke har "ikke registrert" på lisens-attributtet).
SELECT
   id,
   (xpath('//navn/text()', xml_info))[1]::text AS navn,
   (xpath('/deltaker/@lisens', xml_info))[1]::text AS lisens
FROM deltaker d
WHERE xpath_exists('/deltaker[not(@lisens="ikke registrert")]', xml_info);

-- =====================================================
-- EKSEMPEL 8:
-- =====================================================
-- Henter 5 deltakere med poeng > 1000 (de med høyest poeng først)
SELECT
  id,
  (xpath('//navn/text()', xml_info))[1]::text AS navn,
  (xpath('//poeng/text()', xml_info))[1]::text::numeric AS poeng
FROM deltaker
WHERE (xpath('//poeng/text()', xml_info))[1]::text::numeric > 1000
ORDER BY poeng DESC
LIMIT 5;

SELECT
   id,
   (xpath('//navn/text()', xml_info))[1]::text AS navn,
   (xpath('//poeng/text()', xml_info))[1]::text::numeric AS poeng
FROM deltaker
WHERE xpath_exists('//deltaker[poeng > 1000]', xml_info)
ORDER BY poeng DESC
LIMIT 5;

-- =====================================================
-- EKSEMPEL 9:
-- =====================================================
-- Finn deltakere i pulje 2 (hent id, navn og starttid)
SELECT
  id,
  (xpath('//navn/text()', xml_info))[1]::text AS navn,
  puljeId, p.starttid
FROM deltaker d, pulje p
WHERE d.puljeId = p.pid
  AND puljeId = 2;

-- =====================================================
-- EKSEMPEL 10:
-- =====================================================
-- Konverterer XML til regulære rader/kolonner (navn, poeng, fnr, hjemmeside, lisens og om deltaker er medlem) for alle deltakere
-- Bruk XMLTABLE() metoden. MEN er dette mulig for alle kolonner? Hva med medlem som er et element uten tekstverdi?
SELECT
  d.id,
  d.puljeid,
  t.navn,
  t.poeng::numeric,
  --xpath_exists('//medlem', d.xml_info)::boolean as medlem,
  case when t.medlem_exist is not null then true else false end as medlem2,
  t.fnr::text,
  t.hjemmeside::text,
  t.lisens::text
FROM deltaker d,
LATERAL xmltable(
  '//deltaker'
  PASSING d.xml_info
  COLUMNS
    navn text PATH 'navn',
    poeng text PATH 'poeng',
    fnr text PATH '//fnr',
    hjemmeside text PATH '//hjemmeside',
    lisens text PATH '//@lisens',
    medlem_exist text PATH '//medlem'
) AS t;




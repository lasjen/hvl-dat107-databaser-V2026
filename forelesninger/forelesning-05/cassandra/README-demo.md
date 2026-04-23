# Cassandra CQL – Demo

Denne demoen viser Cassandra Query Language (CQL) steg for steg.
Vi bruker to tabeller:
- **teacher** – enkel tabell med UUID som primærnøkkel
- **user_events** – tabell med partisjonsnøkkel og klusterkolonner

## Forberedelser

```bash
# Start Cassandra
docker compose up -d

# Vent ca. 30 sekunder, kjør deretter dataskriptet
docker exec -i dat107-cassandra cqlsh < create-demo-data.cql

# Koble til med cqlsh
docker exec -it dat107-cassandra cqlsh
```

---

## Del 1: Grunnleggende CQL (teacher-tabellen)

### 1.1 Velg keyspace og se tabellene

```sql
USE hvl_db;

DESCRIBE TABLES;
```

### 1.2 Se strukturen til en tabell

```sql
DESCRIBE TABLE teacher;
```

### 1.3 Hent alle rader

```sql
SELECT * FROM teacher;
```

### 1.4 Velg bestemte kolonner

```sql
SELECT fornavn, etternavn FROM teacher;
```

### 1.5 Sett inn en ny lærer

```sql
INSERT INTO teacher (id, fornavn, etternavn)
VALUES (uuid(), 'Kari', 'Nordmann');

SELECT * FROM teacher;
```

### 1.6 Oppdater en rad

I Cassandra brukes `INSERT` eller `UPDATE`. For `UPDATE` trenger du primærnøkkelen:

```sql
-- Finn først id-en til en lærer
SELECT * FROM teacher;

-- Oppdater med den id-en (erstatt med faktisk UUID fra resultatet over)
-- UPDATE teacher SET fornavn = 'Karl' WHERE id = <UUID>;
```

### 1.7 Slett en rad

```sql
-- Slett med primærnøkkel (erstatt med faktisk UUID)
-- DELETE FROM teacher WHERE id = <UUID>;
```

### 1.8 Slett alle rader

```sql
TRUNCATE TABLE teacher;

-- Verifiser
SELECT * FROM teacher;
```

---

## Del 2: Partisjonsnøkkel og klusterkolonner (user_events)

### Forstå primærnøkkelen

```
PRIMARY KEY ((user_id), yyyymmdd, event_time)
              ▲              ▲          ▲
       Partisjonsnøkkel   Klusterkolonne 1   Klusterkolonne 2
```

- **Partisjonsnøkkel** (`user_id`) – bestemmer hvilken node som lagrer dataen
- **Klusterkolonner** (`yyyymmdd`, `event_time`) – sorterer data innenfor partisjonen

---

### 2.1 Hent alle events for én bruker

```sql
-- EFFEKTIVT: Bruker partisjonsnøkkel
SELECT * FROM user_events
WHERE user_id = 'student001';
```

> ✅ Dette er effektivt fordi Cassandra vet nøyaktig hvilken node dataen ligger på.

---

### 2.2 Hent events for én bruker på én dag

```sql
-- EFFEKTIVT: Partisjonsnøkkel + første klusterkolonne
SELECT * FROM user_events
WHERE user_id = 'student001'
  AND yyyymmdd = 20260401;
```

---

### 2.3 Hent events for én bruker over flere dager

```sql
-- EFFEKTIVT: Partisjonsnøkkel + range på klusterkolonne
SELECT * FROM user_events
WHERE user_id = 'student001'
  AND yyyymmdd >= 20260401
  AND yyyymmdd <= 20260403;
```

---

### 2.4 Hent events for én bruker på én dag innenfor et tidsrom

```sql
-- EFFEKTIVT: Partisjonsnøkkel + begge klusterkolonner
SELECT * FROM user_events
WHERE user_id = 'student001'
  AND yyyymmdd = 20260401
  AND event_time >= '2026-04-01 08:00:00'
  AND event_time <= '2026-04-01 09:00:00';
```

---

### 2.5 Begrens antall resultater

```sql
-- De 5 nyeste events for student002 (nyeste først pga CLUSTERING ORDER DESC)
SELECT * FROM user_events
WHERE user_id = 'student002'
LIMIT 5;
```

---

### 2.6 Tell antall events per dag

```sql
SELECT user_id, yyyymmdd, COUNT(*) AS antall
FROM user_events
WHERE user_id = 'student001'
GROUP BY user_id, yyyymmdd;
```

---

### 2.7 Velg bestemte kolonner

```sql
SELECT event_time, event_type, details
FROM user_events
WHERE user_id = 'student003'
  AND yyyymmdd = 20260406;
```

---

## Del 3: Hva som IKKE fungerer (og hvorfor)

### 3.1 Spørring uten partisjonsnøkkel (FEILER)

```sql
-- Dette gir FEIL:
SELECT * FROM user_events
WHERE yyyymmdd = 20260401;
```

> ❌ Cassandra vet ikke hvilken node den skal lete på uten partisjonsnøkkelen.

---

### 3.2 ALLOW FILTERING (bør unngås)

```sql
-- Fungerer, men er IKKE EFFEKTIVT for store datasett
SELECT * FROM user_events
WHERE user_id = 'student003'
  AND yyyymmdd = 20260401
  AND event_type = 'login'
ALLOW FILTERING;
```

> ⚠️ `ALLOW FILTERING` tvinger Cassandra til å lese alle rader og filtrere.
> OK for små datasett, men farlig i produksjon med millioner av rader.

---

### 3.3 Søk på alle brukere (VELDIG ineffektivt)

```sql
-- Må søke alle partisjoner (alle noder)
SELECT * FROM user_events
WHERE event_type = 'login'
ALLOW FILTERING;
```

> ❌ Unngå dette i produksjon! Krever full scan av alle noder.

---

## Del 4: Innsetting, oppdatering og sletting

### 4.1 Sett inn en ny event

```sql
INSERT INTO user_events (user_id, yyyymmdd, event_time, event_type, details)
VALUES ('student001', 20260407, '2026-04-07 08:00:00', 'login', 'Logged in from Chrome');
```

### 4.2 Oppdater en eksisterende event

```sql
-- I Cassandra er UPDATE og INSERT nesten det samme (upsert)
UPDATE user_events
SET details = 'Logged in from Safari (updated)'
WHERE user_id = 'student001'
  AND yyyymmdd = 20260407
  AND event_time = '2026-04-07 08:00:00';
```

### 4.3 Slett én event

```sql
DELETE FROM user_events
WHERE user_id = 'student001'
  AND yyyymmdd = 20260407
  AND event_time = '2026-04-07 08:00:00';
```

### 4.4 Slett alle events for én bruker på én dag

```sql
DELETE FROM user_events
WHERE user_id = 'student001'
  AND yyyymmdd = 20260406;

-- Verifiser
SELECT * FROM user_events
WHERE user_id = 'student001'
  AND yyyymmdd = 20260406;
```

---

## Oppsummering

### Forskjeller mellom SQL og CQL

| | SQL (PostgreSQL) | CQL (Cassandra) |
|---|---|---|
| **Joins** | ✅ Ja | ❌ Nei |
| **WHERE uten nøkkel** | ✅ Ja (men langsomt) | ❌ Nei (krever ALLOW FILTERING) |
| **Sortering** | `ORDER BY` fritt | Kun langs klusterkolonner |
| **Aggregering** | `GROUP BY`, `SUM`, `AVG` osv. | Begrenset `COUNT`, `SUM`, `AVG` |
| **Transaksjoner** | ✅ ACID | ❌ Begrenset (lightweight transactions) |
| **Skalering** | Vertikal (større maskin) | Horisontal (flere noder) |

### Tommelfingerregler for CQL

1. **Alltid bruk partisjonsnøkkelen** i WHERE
2. **Klusterkolonner må brukes i rekkefølge** (først `yyyymmdd`, så `event_time`)
3. **Unngå ALLOW FILTERING** i produksjon
4. **Design tabellene ut fra spørringene** – ikke ut fra datamodellen
5. **Denormalisering er normalt** – det er OK å duplisere data


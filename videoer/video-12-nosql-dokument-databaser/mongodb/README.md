# MongoDB Docker Setup

Dette katalogen inneholder et Docker Compose-oppsett for å kjøre en single-node MongoDB database uten autentisering.

## Hurtigstart

### 1. Start MongoDB

```bash
docker-compose up -d
```

### 2. Sjekk at MongoDB kjører

```bash
# Sjekk status
docker-compose ps

# Se logger
docker-compose logs -f mongodb
```

MongoDB tar vanligvis 5-10 sekunder å starte.

### 3. Koble til MongoDB

#### Bruk det medfølgende skriptet (anbefalt)

```bash
# Koble til med standard database (hvl_db)
./mongosh.sh

# Koble til en spesifikk database
./mongosh.sh admin
./mongosh.sh test
```

Skriptet sjekker automatisk at MongoDB er klar før tilkobling.

#### Alternativt: Manuell tilkobling

```bash
# Fra Docker-containeren
docker exec -it mongodb mongosh

# Eller fra host (hvis mongosh er installert)
mongosh mongodb://localhost:27017/hvl_db
```

## Grunnleggende MongoDB Kommandoer

Når du er koblet til mongosh:

```javascript
// Vis alle databaser
show dbs

// Bruk en database (opprettes automatisk hvis den ikke finnes)
use hvl_db

// Vis alle collections (tabeller)
show collections

// Opprett en collection og legg inn data
db.teacher.insertOne({
    fornavn: "Lasse",
    etternavn: "Jenssen"
})

// Legg inn flere dokumenter
db.teacher.insertMany([
    { fornavn: "Dag", etternavn: "Toppe Hansen" },
    { fornavn: "Lars-Petter", etternavn: "Helland" }
])

// Finn alle dokumenter
db.teacher.find()

// Finn med formatering
db.teacher.find().pretty()

// Finn ett dokument
db.teacher.findOne({ fornavn: "Lasse" })

// Oppdater dokument
db.teacher.updateOne(
    { fornavn: "Lasse" },
    { $set: { etternavn: "Ny Etternavn" } }
)

// Slett dokument
db.teacher.deleteOne({ fornavn: "Lasse" })

// Slett alle dokumenter i collection
db.teacher.deleteMany({})

// Slett hele collection
db.teacher.drop()

// Avslutt mongosh
exit
```

## Portkonfigurasjon

- **27017**: MongoDB standard port (database-tilgang)

## Konfigurasjon

MongoDB-instansen er konfigurert med:

- **Image**: mongo:7.0 (nyeste stabile versjon)
- **Autentisering**: Deaktivert (kun for utvikling)
- **Standard database**: hvl_db
- **Persistent lagring**: Data beholdes mellom restarter

## Datalagring

Data lagres i Docker-volumet `mongodb_data`. For å slette all data:

```bash
docker-compose down -v
```

## Eksempel: Teacher Collection

### Automatisk oppsett med skript

Kjør det medfølgende skriptet for å opprette teacher collection med eksempeldata:

```bash
chmod +x setup-teacher.sh
./setup-teacher.sh
```

Dette oppretter:
- **Database**: `hvl_db`
- **Collection**: `teacher` med feltene:
  - `_id` (ObjectId, automatisk generert)
  - `fornavn` (String)
  - `etternavn` (String)
- **Eksempeldata**: 8 lærere (samme som i Cassandra-eksempelet)
- **Indekser**: På fornavn og etternavn for bedre søkeytelse

### Spør etter data

```bash
# Bruk mongosh-skriptet
./mongosh.sh hvl_db

# Eller direkte kommando
docker exec -it mongodb mongosh hvl_db --eval "db.teacher.find()"
```

### Manuelt oppsett

Opprett en teacher collection med eksempeldata manuelt:

```javascript
use hvl_db

// Opprett collection med data
db.teacher.insertMany([
    { fornavn: "Lasse", etternavn: "Jenssen" },
    { fornavn: "Dag", etternavn: "Toppe Hansen" },
    { fornavn: "Lars-Petter", etternavn: "Helland" }
])

// Vis alle lærere
db.teacher.find()

// Tell antall lærere
db.teacher.countDocuments()

// Søk etter lærer
db.teacher.find({ fornavn: "Lasse" })

// Finn og sorter
db.teacher.find().sort({ etternavn: 1 })
```

### Sammenligning med Cassandra

| Cassandra (CQL) | MongoDB (JavaScript) |
|-----------------|----------------------|
| `USE hvl_db;` | `use hvl_db` |
| `SELECT * FROM teacher;` | `db.teacher.find()` |
| `SELECT * FROM teacher WHERE fornavn = 'Lasse';` | `db.teacher.find({ fornavn: "Lasse" })` |
| `INSERT INTO teacher (id, fornavn, etternavn) VALUES (uuid(), 'Per', 'Hansen');` | `db.teacher.insertOne({ fornavn: "Per", etternavn: "Hansen" })` |
| `DELETE FROM teacher WHERE id = ...;` | `db.teacher.deleteOne({ _id: ObjectId("...") })` |
| `TRUNCATE teacher;` | `db.teacher.deleteMany({})` |

## Feilsøking

### Container starter ikke

Sjekk logger:
```bash
docker-compose logs mongodb
```

### Kan ikke koble til

Vent litt lenger - MongoDB trenger tid til å initialisere. Sjekk health status:
```bash
docker-compose ps
```

### Nullstill alt

```bash
docker-compose down -v
docker-compose up -d
```

## Stopp MongoDB

```bash
# Stopp men behold data
docker-compose down

# Stopp og fjern data
docker-compose down -v
```

## Sikkerhet

⚠️ **ADVARSEL**: Dette oppsettet har **ingen autentisering** og er kun egnet for **lokal utvikling**.

For produksjon, aktiver alltid autentisering:

```yaml
environment:
  MONGO_INITDB_ROOT_USERNAME: admin
  MONGO_INITDB_ROOT_PASSWORD: strongpassword
```

## Ressurser

- [MongoDB Dokumentasjon](https://www.mongodb.com/docs/)
- [MongoDB Shell (mongosh) Guide](https://www.mongodb.com/docs/mongodb-shell/)
- [Docker Hub - MongoDB](https://hub.docker.com/_/mongo)


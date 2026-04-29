# Neo4j Docker Setup

Dette katalogen inneholder et Docker Compose-oppsett for å kjøre en single-node Neo4j graph database uten autentisering.

## Hurtigstart

### 1. Start Neo4j

```bash
docker-compose up -d
```

### 2. Vent på at Neo4j er klar

```bash
# Sjekk status
docker-compose ps

# Se logger
docker-compose logs -f neo4j
```

Neo4j tar vanligvis 15-30 sekunder å starte.

### 3. Last inn testdata

#### Standard HVL-data (forelesere, studenter, emner)

```bash
./setup-data.sh
# eller eksplisitt:
./setup-data.sh seed-data.cypher
```

Dette oppretter:
- **Forelesere**: Lasse Jenssen, Dag Toppe Larsen, Lars-Petter Helland
- **Studenter**: Ola Nordmann
- **Emner**: DAT100, MAT101, DAT107
- **Relasjoner**: UNDERVISER, ANSVARLIG, STUDERER

#### Alternativt: Venner-nettverk (20 personer med vennskap)

```bash
./setup-data.sh seed-venner.cypher
```

Dette oppretter:
- **20 personer** med brukernavn, fornavn, etternavn og by
- **VENNER-relasjoner** mellom personene
- Personer fra forskjellige byer: Bergen, Oslo, Stavanger, Trondheim, m.fl.

**Nyttige spørringer for venner-data:**
```cypher
// Finn alle venner til Ola
MATCH (p:Person {fornavn: "Ola"})-[:VENNER]->(venn:Person)
RETURN venn.fornavn, venn.etternavn, venn.by;

// Finn personer fra Bergen
MATCH (p:Person {by: "Bergen"})
RETURN p.brukernavn, p.fornavn, p.etternavn;

// Finn hvem som har flest venner
MATCH (p:Person)-[:VENNER]->(venn:Person)
RETURN p.fornavn, p.etternavn, count(venn) AS antall_venner
ORDER BY antall_venner DESC;

// Finn felles venner
MATCH (p1:Person {fornavn: "Ola"})-[:VENNER]->(felles:Person)<-[:VENNER]-(p2:Person)
WHERE p1 <> p2
RETURN p2.fornavn, p2.etternavn, collect(felles.fornavn) AS felles_venner;
```

### 4. Koble til Neo4j

#### Via Neo4j Browser (Web GUI) - Anbefalt

Åpne nettleseren: **http://localhost:7474**

- Klikk **Connect** (ingen autentisering nødvendig)
- Test med: `MATCH (n) RETURN n;`

#### Via cypher-shell (kommandolinje)

```bash
# Bruk det medfølgende skriptet
./cypher-shell.sh

# Eller manuelt
docker exec -it neo4j cypher-shell -a neo4j://localhost:7687
```

## Portkonfigurasjon

- **7474**: HTTP - Neo4j Browser (Web interface)
- **7687**: Bolt - Database-tilgang (Cypher queries)

## Konfigurasjon

Neo4j-instansen er konfigurert med:

- **Image**: neo4j:5.26.0 (nyeste stabile versjon)
- **Autentisering**: Deaktivert (kun for utvikling)
- **Heap Memory**: 512MB initial, 2GB max
- **Page Cache**: 512MB
- **Persistent lagring**: Data beholdes mellom restarter

## Datalagring

Data lagres i Docker-volumes:
- `neo4j_data`: Database-data
- `neo4j_logs`: Loggfiler
- `neo4j_import`: CSV/JSON filer for import
- `neo4j_plugins`: Plugins og extensions

For å slette all data:

```bash
docker-compose down -v
```

## Grunnleggende Cypher Kommandoer

### Vis alle noder

```cypher
MATCH (n) RETURN n;
```

### Vis alle relasjoner

```cypher
MATCH (n)-[r]->(m) RETURN n, r, m;
```

### Finn alle emner som Dag underviser

```cypher
MATCH (p:Person {fornavn: "Dag"})-[:UNDERVISER]->(e:Emne) 
RETURN e.kode, e.navn;
```

### Finn alle roller som Dag har i ulike emner

```cypher
MATCH (p:Person {fornavn: "Dag"})-[r]->(e:Emne) 
RETURN type(r) as Rolle, e.kode as Emne, e.navn as Emnenavn;
```

### Finn alle forelesere som underviser i DAT107

```cypher
MATCH (p:Foreleser)-[:UNDERVISER]->(e:Emne {kode: "DAT107"})
RETURN p.fornavn, p.etternavn;
```

### Finn alle studenter og emnene de studerer

```cypher
MATCH (s:Student)-[:STUDERER]->(e:Emne)
RETURN s.fornavn + ' ' + s.etternavn as Student, e.kode, e.navn;
```

### Tell noder og relasjoner

```cypher
// Tell alle noder
MATCH (n) RETURN count(n);

// Tell per label
MATCH (n) RETURN labels(n) as Label, count(n) as Antall;

// Tell relasjoner
MATCH ()-[r]->() RETURN type(r) as Type, count(r) as Antall;
```

### Opprett ny node

```cypher
CREATE (s:Person:Student {
    fornavn: "Kari", 
    etternavn: "Hansen"
});
```

### Opprett relasjon

```cypher
MATCH (s:Student {fornavn: "Kari"}), (e:Emne {kode: "DAT107"})
CREATE (s)-[:STUDERER]->(e);
```

### Oppdater node

```cypher
MATCH (p:Person {fornavn: "Lasse"})
SET p.email = "lasse.jenssen@hvl.no";
```

### Slett node

```cypher
// Slett node uten relasjoner
MATCH (p:Person {fornavn: "Kari"}) 
DELETE p;

// Slett node med alle relasjoner
MATCH (p:Person {fornavn: "Kari"}) 
DETACH DELETE p;
```

### Slett alt

```cypher
MATCH (n) DETACH DELETE n;
```

## Eksempel: HVL-databasen

Etter å ha kjørt `./setup-data.sh`, kan du teste disse spørringene:

```cypher
// Hvem er emneansvarlig for DAT107?
MATCH (p:Person)-[:ANSVARLIG]->(e:Emne {kode: "DAT107"})
RETURN p.fornavn, p.etternavn;

// Hvilke emner har flest forelesere?
MATCH (p:Foreleser)-[:UNDERVISER]->(e:Emne)
RETURN e.kode, e.navn, count(p) as AntallForelesere
ORDER BY AntallForelesere DESC;

// Finn studenter og deres emner
MATCH (s:Student)-[:STUDERER]->(e:Emne)
RETURN s.fornavn, s.etternavn, collect(e.kode) as Emner;

// Finn alle som er involvert i DAT107 (både forelesere og studenter)
MATCH (p:Person)-[r]->(e:Emne {kode: "DAT107"})
RETURN p.fornavn, p.etternavn, labels(p) as Rolle, type(r) as Relasjon;
```

## Visualisering i Neo4j Browser

1. Åpne http://localhost:7474
2. Kjør: `MATCH (n) RETURN n;`
3. Se grafen visualisert med noder og relasjoner
4. Klikk på noder for å se egenskaper
5. Dra og organiser grafen som du vil

## Feilsøking

### Container starter ikke

Sjekk logger:
```bash
docker-compose logs neo4j
```

### Kan ikke koble til Browser

Vent litt lenger - Neo4j trenger tid til å initialisere. Sjekk health status:
```bash
docker-compose ps
```

Verifiser at Neo4j svarer:
```bash
curl http://localhost:7474
```

### Setup-skriptet feiler

Sjekk at containeren kjører:
```bash
docker ps | grep neo4j
```

Prøv å kjøre Cypher-kommandoene manuelt:
```bash
./cypher-shell.sh
```

### Nullstill alt

```bash
docker-compose down -v
docker-compose up -d
./setup-data.sh
```

## Stopp Neo4j

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
  NEO4J_AUTH: neo4j/your-strong-password
```

## Sammenligning med Andre Databaser

| Konsept | SQL/Cassandra | MongoDB | Neo4j |
|---------|---------------|---------|-------|
| Database | Database/Keyspace | Database | Database |
| Tabell/Collection | Table | Collection | Label |
| Rad/Dokument | Row | Document | Node |
| Kolonne/Felt | Column | Field | Property |
| Relasjon | Foreign Key/JOIN | Reference/$lookup | Relationship |
| Query Language | SQL/CQL | JavaScript | Cypher |

## Ressurser

- [Neo4j Dokumentasjon](https://neo4j.com/docs/)
- [Cypher Query Language](https://neo4j.com/docs/cypher-manual/current/)
- [Neo4j Browser Guide](https://neo4j.com/docs/browser-manual/current/)
- [Docker Hub - Neo4j](https://hub.docker.com/_/neo4j)
- [Graph Academy (gratis kurs)](https://graphacademy.neo4j.com/)


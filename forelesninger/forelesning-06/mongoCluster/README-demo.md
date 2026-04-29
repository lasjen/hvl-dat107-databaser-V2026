# MongoDB Replica Set – Demo

Denne demoen viser hvordan et MongoDB **replica set** med 3 noder fungerer,
inkludert automatisk replikering og failover.

## Arkitektur

```
┌──────────┐    ┌──────────┐    ┌──────────┐
│  mongo1  │    │  mongo2  │    │  mongo3  │
│ PRIMARY  │◄──►│SECONDARY │◄──►│SECONDARY │
│ :27017   │    │ :27018   │    │ :27019   │
└──────────┘    └──────────┘    └──────────┘
```

- **Primary** – tar imot all skriving
- **Secondary** – replikerer data fra primary, kan brukes til lesing
- Ved failover velges en ny primary automatisk

---

## 1. Start clusteret

```bash
docker compose up -d
```

Vent ca. 15 sekunder til replica set-et er initialisert.

---

## 2. Sjekk status

### Hvem er primary og secondary?

```bash
docker exec -it mongo1 mongosh --eval "rs.status().members.forEach(m => print(m.name + ' : ' + m.stateStr))"
```
rs.status() er en mongosh‑helper som returnerer status for replica set sett fra noden du er koblet til.

```json
{
  set: "rs0",
  myState: 1,
  members: [
    { name: "mongo1:27017", stateStr: "PRIMARY", ... },
    { name: "mongo2:27017", stateStr: "SECONDARY", ... }
  ]
}

```

Forventet output:
```
mongo1:27017 : PRIMARY
mongo2:27017 : SECONDARY
mongo3:27017 : SECONDARY
```

---

## 3. Sett inn data på primary

```bash
docker exec -it mongo1 mongosh 
use demo;
db.studenter.insertMany([
    { navn: "Kari",   alder: 22, studie: "Informatikk" },
    { navn: "Ola",    alder: 25, studie: "Matematikk" },
    { navn: "Lars",   alder: 23, studie: "Informatikk" },
    { navn: "Emma",   alder: 21, studie: "Fysikk" },
    { navn: "Jonas",  alder: 24, studie: "Informatikk" }
]);
print("Antall dokumenter på primary: " + db.studenter.countDocuments());
```

---

## 4. Les data fra secondary (replikering)

```bash
docker exec -it mongo2 mongosh
db.getMongo().setReadPref("secondary");
use demo;
print("Antall dokumenter på secondary: " + db.studenter.countDocuments());
db.studenter.find().forEach(printjson);
```

setReadPref("secondary") forteller mongosh at vi ønsker å lese fra en secondary-node. 
Hvis du ikke setter dette, vil mongosh prøve å lese fra primary som er standard.


> **Merk:** Data er automatisk replikert fra primary til secondary.

---

## 5. Simuler failover

### Stopp primary-noden

```bash
docker stop mongo1
```

### Vent ca. 10 sekunder og sjekk ny status

```bash
docker exec -it mongo2 mongosh --eval "rs.status().members.forEach(m => print(m.name + ' : ' + m.stateStr))"
```

Forventet output (en av de andre er nå PRIMARY):
```
mongo1:27017 : (not reachable/healthy)
mongo2:27017 : PRIMARY
mongo3:27017 : SECONDARY
```

### Verifiser at data fortsatt er tilgjengelig

```bash
docker exec -it mongo2 mongosh mongodb://localhost:27017/?directConnection=true 
print("Antall etter failover: " + db.studenter.countDocuments());
```

### Start mongo1 igjen

```bash
docker start mongo1
```

mongo1 kommer tilbake som **secondary** og synkroniserer automatisk.

```bash
docker exec -it mongo1 mongosh --eval "rs.status().members.forEach(m => print(m.name + ' : ' + m.stateStr))"
```

---

## 6. Skriv mens primary er nede (feilhåndtering)

Stopp primary igjen og prøv å skrive før ny primary er valgt:

```bash
docker stop mongo2

# Prøv å skrive til mongo3 (som kanskje ikke er primary ennå)
docker exec -it mongo3 mongosh --eval '
  var demoDB = db.getSiblingDB("demo");
  try {
    demoDB.studenter.insertOne({ navn: "Test", alder: 20 });
    print("Skriving OK");
  } catch (e) {
    print("Feil: " + e.message);
  }
'
```

> Hvis ingen primary er valgt ennå, vil skrivingen feile.
> MongoDB krever **flertall** (majority) av nodene for å velge primary.

Start noden igjen:
```bash
docker start mongo2
```
---

## 7. Koble til clusteret fra DataGrip / IntelliJ

```bash
mongosh "mongodb://mongo1:27017,mongo2:27018,mongo3:27019/?replicaSet=myReplicaSet"

var demoDB = db.getSiblingDB("demo");
try {
 demoDB.studenter.insertOne({ navn: "Test 2", alder: 200 });
 print("Skriving OK");
} catch (e) {
 print("Feil: " + e.message);
}
```
---

## 8. Rydd opp

```bash
docker compose down -v
```

---

## Oppsummering

| Egenskap | Beskrivelse |
|----------|-------------|
| **Replikering** | Data kopieres automatisk fra primary til alle secondary-noder |
| **Failover** | Ny primary velges automatisk hvis nåværende primary går ned |
| **Lesing fra secondary** | Kan avlaste primary ved å lese fra secondary-noder |
| **Majority** | Flertall av noder må være oppe for at clusteret skal fungere |

---

## Koble til fra DataGrip / IntelliJ

```
mongodb://localhost:27017/?directConnection=true
```

Ingen brukernavn/passord (autentisering er ikke aktivert i denne demoen).


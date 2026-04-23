# MongoDB Query API – Demo

Denne demoen viser MongoDB Query API steg for steg,
fra enkle spørringer til aggregering.

Datamodellen er basert på Birken-påmelding med to samlinger:
- **puljer** – puljenummer og starttid
- **personer** – deltakere med navn, fødselsdato, poeng, pulje osv.

## Forberedelser

```bash
# Start databasen (oppretter data automatisk)
docker compose up -d

# Koble til med mongosh
docker exec -it dat107-mongodb mongosh birken
```

---

## 1. Se hva som finnes

```javascript
// Vis alle samlinger i databasen
show collections

// Tell antall dokumenter
db.puljer.countDocuments()
db.personer.countDocuments()

// Se ett dokument
db.personer.findOne()
```

---

## 2. Hent alle dokumenter

```javascript
// Alle puljer
db.puljer.find()

// Alle personer (kan bli mye output)
db.personer.find()
```

---

## 3. Filtrer med find()

### Finn én bestemt person

```javascript
db.personer.find({ _id: "h0001" })
```

### Finn alle medlemmer

```javascript
db.personer.find({ medlem: true })
```

### Finn alle i pulje 1

```javascript
db.personer.find({ puljeId: 1 })
```

### Finn alle som IKKE er medlemmer

```javascript
db.personer.find({ medlem: false })

db.personer.find({ medlem: { $ne: true } })

db.personer.find({ medlem: { $not: { $eq: true } } })
```

---

## 4. Sammenligningsoperatorer

### Finn alle med poeng over 1000

```javascript
db.personer.find({ poeng: { $gt: 1000 } })
```

### Finn alle med poeng mellom 900 og 1000

```javascript
db.personer.find({ poeng: { $gte: 900, $lte: 1000 } })
```

### Finn alle i pulje 1, 2 eller 3

```javascript
db.personer.find({ puljeId: { $in: [1, 2, 3] } })
```

---

## 5. Logiske operatorer

### Finn medlemmer med poeng over 1000

```javascript
db.personer.find({
    medlem: true,
    poeng: { $gt: 1000 }
})
```

### Finn personer som er i pulje 1 ELLER har poeng over 1100

```javascript
db.personer.find({
    $or: [
        { puljeId: 1 },
        { poeng: { $gt: 1100 } }
    ]
})
```

### Finn alle som har foresattId (barn)

```javascript
db.personer.find({ foresattId: { $exists: true } })
```

---

## 6. Projeksjon – velg hvilke felter som vises

### Vis bare navn og poeng

```javascript
db.personer.find({}, { navn: 1, poeng: 1 })
```

### Vis navn og poeng, men skjul _id

```javascript
db.personer.find({}, { _id: 0, navn: 1, poeng: 1 })
```

### Vis alt unntatt hjemmeside og fnr

```javascript
db.personer.find({}, { hjemmeside: 0, fnr: 0 })
```

---

## 7. Sortering

### Sorter etter poeng (høyest først)

```javascript
db.personer.find({}, { _id: 0, navn: 1, poeng: 1 }).sort({ poeng: -1 })
```

### Sorter etter navn (alfabetisk)

```javascript
db.personer.find({}, { _id: 0, navn: 1 }).sort({ navn: 1 })
```

### Sorter etter pulje, deretter poeng (synkende)

```javascript
db.personer.find({}, { _id: 0, navn: 1, puljeId: 1, poeng: 1 }).sort({ puljeId: 1, poeng: -1 })
```

---

## 8. Begrensning og hopping

### De 5 beste (høyest poeng)

```javascript
db.personer.find({}, { _id: 0, navn: 1, poeng: 1 }).sort({ poeng: -1 }).limit(5)
```

### Hopp over de 5 første, vis neste 5

```javascript
db.personer.find({}, { _id: 0, navn: 1, poeng: 1 }).sort({ poeng: -1 }).skip(5).limit(5)
```

---

## 9. Regulære uttrykk (tekstsøk)

### Finn alle med navn som starter på "K"

```javascript
db.personer.find({ navn: /^K/ })
```

### Finn alle med "sen" i etternavnet

```javascript
db.personer.find({ navn: /sen$/i })
```

### Finn alle med "Berg" i navnet

```javascript
db.personer.find({ navn: /Berg/ })
```

---

## 10. Oppdatering

### Oppdater poeng for én person

```javascript
db.personer.updateOne(
    { _id: "h0001" },
    { $set: { poeng: 1300.00 } }
)

// Verifiser
db.personer.findOne({ _id: "h0001" })
```

### Legg til 50 bonuspoeng for alle medlemmer

```javascript
db.personer.updateMany(
    { medlem: true },
    { $inc: { poeng: 50 } }
)
```

### Legg til et nytt felt for én person

```javascript
db.personer.updateOne(
    { _id: "h0001" },
    { $set: { epost: "lasse@example.com" } }
)
```

### Fjern et felt

```javascript
db.personer.updateOne(
    { _id: "h0001" },
    { $unset: { epost: "" } }
)
```

---

## 11. Sletting

### Slett én person

```javascript
db.personer.deleteOne({ _id: "d0025" })
```

### Slett alle ikke-medlemmer i pulje 3

```javascript
db.personer.deleteMany({ medlem: false, puljeId: 3 })
```

> **NB:** Kjør `docker compose down -v && rm -rf mongodb-data && docker compose up -d`
> for å gjenopprette data etter sletting.

---

## 12. Distinct – unike verdier

### Hvilke puljer finnes?

```javascript
db.personer.distinct("puljeId")
db.personer.distinct("puljeId", { medlem: true })
```

---

## 13. Telling med filter

### Antall personer i pulje 2

```javascript
db.personer.countDocuments({ puljeId: 2 })
```

### Antall medlemmer med poeng over 1000

```javascript
db.personer.countDocuments({ medlem: true, poeng: { $gt: 1000 } })
```

---

## 14. Aggregering – Introduksjon

Aggregering bruker en **pipeline** – en rekke steg som data flyter gjennom.

### Enkel telling per pulje

```javascript
db.personer.aggregate([
    { $group: { _id: "$puljeId", antall: { $sum: 1 } } },
    { $sort: { _id: 1 } }
])
```

### Gjennomsnittlig poeng per pulje

```javascript
db.personer.aggregate([
    { $group: {
        _id: "$puljeId",
        snittPoeng: { $avg: "$poeng" },
        antall: { $sum: 1 }
    }},
    { $sort: { _id: 1 } }
])
```

---

## 15. Aggregering – $match (filtrering)

### Gjennomsnittlig poeng for kun medlemmer, per pulje

```javascript
db.personer.aggregate([
    { $match: { medlem: true } },
    { $group: {
        _id: "$puljeId",
        snittPoeng: { $avg: "$poeng" },
        antall: { $sum: 1 }
    }},
    { $sort: { snittPoeng: -1 } }
])
```

---

## 16. Aggregering – $project (velg/transformer felter)

### Vis bare navn og om personen har høy poengsum

```javascript
db.personer.aggregate([
    { $project: {
        _id: 0,
        navn: 1,
        poeng: 1,
        høyPoeng: { $gt: ["$poeng", 1000] }
    }},
    { $sort: { poeng: -1 } },
    { $limit: 10 }
])
```

---

## 17. Aggregering – $group med flere beregninger

### Min, maks og snitt poeng per pulje

```javascript
db.personer.aggregate([
    { $group: {
        _id: "$puljeId",
        antall:    { $sum: 1 },
        minPoeng:  { $min: "$poeng" },
        maksPoeng: { $max: "$poeng" },
        snittPoeng: { $avg: "$poeng" }
    }},
    { $sort: { _id: 1 } }
])
```

---

## 18. Aggregering – $lookup (join mellom samlinger)

### Slå sammen person med puljeinformasjon

```javascript
db.personer.aggregate([
    { $lookup: {
        from: "puljer",
        localField: "puljeId",
        foreignField: "_id",
        as: "pulje"
    }},
    { $unwind: "$pulje" },
    { $project: {
        _id: 0,
        navn: 1,
        poeng: 1,
        puljeNr: "$pulje._id",
        startTid: "$pulje.startTid"
    }},
    { $sort: { startTid: 1, poeng: -1 } },
    { $limit: 10 }
])
```

---

## 19. Komplett aggregerings-pipeline

Eksempel: Finn gjennomsnittlig poeng per pulje for medlemmer,
og lagre resultatet i en ny samling `pulje_statistikk`.

```javascript
db.personer.aggregate([

    // Steg 1: Filtrer – kun medlemmer
    { $match: { medlem: true } },

    // Steg 2: Transformer – behold bare det vi trenger
    { $project: {
        _id: 0,
        puljeId: 1,
        poeng: 1,
        navn: 1
    }},

    // Steg 3: Grupper per pulje
    { $group: {
        _id: "$puljeId",
        antallMedlemmer: { $sum: 1 },
        snittPoeng: { $avg: "$poeng" },
        maksPoeng: { $max: "$poeng" },
        minPoeng: { $min: "$poeng" },
        totalPoeng: { $sum: "$poeng" }
    }},

    // Steg 4: Sorter etter pulje
    { $sort: { _id: 1 } },

    // Steg 5: Lagre resultatet i en ny samling
    { $merge: {
        into: "pulje_statistikk",
        whenMatched: "replace",
        whenNotMatched: "insert"
    }}
])

// Se resultatet
db.pulje_statistikk.find().sort({ _id: 1 })
```

Forventet output:
```json
{ _id: 1, antallMedlemmer: 6, snittPoeng: ..., maksPoeng: ..., minPoeng: ..., totalPoeng: ... }
{ _id: 2, antallMedlemmer: 9, snittPoeng: ..., maksPoeng: ..., minPoeng: ..., totalPoeng: ... }
{ _id: 3, antallMedlemmer: 1, snittPoeng: ..., maksPoeng: ..., minPoeng: ..., totalPoeng: ... }
{ _id: 4, antallMedlemmer: 5, snittPoeng: ..., maksPoeng: ..., minPoeng: ..., totalPoeng: ... }
```

---

## Oppsummering

| Operasjon | Metode/Steg | Eksempel |
|-----------|------------|----------|
| Hent alle | `find()` | `db.personer.find()` |
| Filtrer | `find({...})` | `db.personer.find({ medlem: true })` |
| Projeksjon | `find({}, {...})` | `db.personer.find({}, { navn: 1 })` |
| Sorter | `.sort()` | `.sort({ poeng: -1 })` |
| Begrens | `.limit()` | `.limit(5)` |
| Tell | `countDocuments()` | `db.personer.countDocuments()` |
| Oppdater | `updateOne/Many()` | `db.personer.updateOne(...)` |
| Slett | `deleteOne/Many()` | `db.personer.deleteOne(...)` |
| Aggreger | `aggregate([...])` | `$match`, `$project`, `$group`, `$merge` |


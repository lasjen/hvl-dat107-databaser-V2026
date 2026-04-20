// =============================================================
// create-mongo-db.js
// Oppretter samlinger og legger inn data i MongoDB databasen
// "hvl-oblig" med tre samlinger:
//   - lokallag
//   - medlemmer (medlemsavgift for forrige og gjeldende år, samt ubetalte)
//   - medlemsavgift_historie (eldre betalte avgifter)
//
// Kjøres slik:
//   mongosh hvl-oblig create-mongo-db.js
// =============================================================
// Bytt til riktig database
db = db.getSiblingDB("hvl-oblig");

// Slett eksisterende data (for re-kjøring)
db.lokallag.drop();
db.medlemmer.drop();
db.medlemsavgift_historie.drop();

const currentYear = new Date().getFullYear();
const previousYear = currentYear - 1;
const firstYear = 2017;

// =============================================================
// 1. Lokallag
// =============================================================
print("Oppretter samling: lokallag");

db.lokallag.insertOne({
    _id: 1,
    lagnavn: "Bergen Brettspillklubb",
    møtelokale: {
        gateadresse: "Strandgaten 15",
        postnr: "5013",
        poststed: "Bergen"
    },
    leder_medlemsnummer: 1001
});

// =============================================================
// 2. Medlemmer
//    Hver medlem har embedded medlemsavgifter for:
//    - Forrige år og gjeldende år (alltid med)
//    - Eventuelle ubetalte avgifter fra eldre år
//    Alle andre (betalte, eldre) avgifter ligger i
//    medlemsavgift_historie.
// =============================================================
print("Oppretter samling: medlemmer");

db.medlemmer.insertMany([
    {
        _id: 1001, fornavn: "Lars", etternavn: "Jenssen",
        telefon: "12345678", epost: "lars.jenssen@example.no",
        adresse: { gateadresse: "Inndalsveien 28", postnr: "5063", poststed: "Bergen" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-01-16" },
            { år: 2026, betalingsdato: "2026-04-20" }
        ]
    },
    {
        _id: 1002, fornavn: "Kari", etternavn: "Hansen",
        telefon: "23456789", epost: "kari.hansen@example.com",
        adresse: { gateadresse: "Nygårdsgaten 10", postnr: "5015", poststed: "Bergen" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-01-17" },
            { år: 2026, betalingsdato: "2026-04-21" }
        ]
    },
    {
        _id: 1003, fornavn: "Ola", etternavn: "Nordmann",
        telefon: "34567890", epost: "ola.nordmann@example.com",
        adresse: { gateadresse: "Christies gate 5", postnr: "5015", poststed: "Bergen" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2024, betalingsdato: null },   // ubetalt – blir liggende her
            { år: 2025, betalingsdato: "2025-01-18" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1004, fornavn: "Emma", etternavn: "Nilsen",
        telefon: "45678901", epost: "emma.nilsen@example.com",
        adresse: { gateadresse: "Welhavens gate 20", postnr: "5006", poststed: "Bergen" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: null },    // ubetalt – blir liggende her
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1005, fornavn: "Jonas", etternavn: "Berg",
        telefon: "56789012", epost: "jonas.berg@example.com",
        adresse: { gateadresse: "Lovstakksiden 3", postnr: "5034", poststed: "Bergen" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-01-20" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1006, fornavn: "Ingrid", etternavn: "Olsen",
        telefon: "67890123", epost: "ingrid.olsen@example.com",
        adresse: { gateadresse: "Kaigaten 7", postnr: "5013", poststed: "Bergen" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-01-21" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1007, fornavn: "Erik", etternavn: "Andersen",
        telefon: "78901234", epost: "erik.andersen@example.com",
        adresse: { gateadresse: "Strandgaten 25", postnr: "5013", poststed: "Bergen" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-01-22" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1008, fornavn: "Sara", etternavn: "Eriksen",
        telefon: "89012345", epost: "sara.eriksen@example.com",
        adresse: { gateadresse: "Kong Oscars gate 15", postnr: "5017", poststed: "Bergen" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-01-23" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1009, fornavn: "Martin", etternavn: "Lie",
        telefon: "90123456", epost: "martin.lie@example.com",
        adresse: { gateadresse: "Hollendergaten 8", postnr: "5011", poststed: "Bergen" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-01-24" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1010, fornavn: "Marte", etternavn: "Saether",
        telefon: "01234567", epost: "marte.saether@example.com",
        adresse: { gateadresse: "Nordnes sjobad 1", postnr: "5005", poststed: "Bergen" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2023, betalingsdato: null },    // ubetalt – blir liggende her
            { år: 2024, betalingsdato: null },    // ubetalt – blir liggende her
            { år: 2025, betalingsdato: "2025-01-25" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1011, fornavn: "Thomas", etternavn: "Moen",
        telefon: "11223344", epost: "thomas.moen@example.com",
        adresse: { gateadresse: "Sandviksbodene 12", postnr: "5035", poststed: "Bergen" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-01-26" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1012, fornavn: "Sofie", etternavn: "Lund",
        telefon: "22334455", epost: "sofie.lund@example.com",
        adresse: { gateadresse: "Mohlenpris 18", postnr: "5006", poststed: "Bergen" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-01-27" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1013, fornavn: "Henrik", etternavn: "Dahl",
        telefon: "33445566", epost: "henrik.dahl@example.com",
        adresse: { gateadresse: "Damsgardsveien 40", postnr: "5058", poststed: "Bergen" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-01-28" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1014, fornavn: "Nora", etternavn: "Bakke",
        telefon: "44556677", epost: "nora.bakke@example.com",
        adresse: { gateadresse: "Asane Senter 2", postnr: "5116", poststed: "Ulset" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-01-29" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1015, fornavn: "Markus", etternavn: "Hauge",
        telefon: "55667788", epost: "markus.hauge@example.com",
        adresse: { gateadresse: "Fyllingsveien 55", postnr: "5147", poststed: "Fyllingsdalen" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-01-30" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1016, fornavn: "Julie", etternavn: "Solberg",
        telefon: "66778899", epost: "julie.solberg@example.com",
        adresse: { gateadresse: "Lagunen 3", postnr: "5239", poststed: "Rådal" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-01-31" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1017, fornavn: "Andreas", etternavn: "Vik",
        telefon: "77889900", epost: "andreas.vik@example.com",
        adresse: { gateadresse: "Nesttunbrekka 7", postnr: "5221", poststed: "Nesttun" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-02-01" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1018, fornavn: "Thea", etternavn: "Hagen",
        telefon: "88990011", epost: "thea.hagen@example.com",
        adresse: { gateadresse: "Sandsliasen 20", postnr: "5254", poststed: "Sandsli" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-02-02" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1019, fornavn: "Magnus", etternavn: "Rønning",
        telefon: "99001122", epost: "magnus.ronning@example.com",
        adresse: { gateadresse: "Storetveitvegen 15", postnr: "5072", poststed: "Bergen" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-02-03" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1020, fornavn: "Emilie", etternavn: "Knutsen",
        telefon: "00112233", epost: "emilie.knutsen@example.com",
        adresse: { gateadresse: "Haukeland 45", postnr: "5021", poststed: "Bergen" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-02-04" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1021, fornavn: "Kristian", etternavn: "Berge",
        telefon: "11223355", epost: "kristian.berge@example.com",
        adresse: { gateadresse: "Fantoft 12", postnr: "5072", poststed: "Bergen" },
        aktiv: false, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-02-05" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1022, fornavn: "Amalie", etternavn: "Myklebust",
        telefon: "22334466", epost: "amalie.myklebust@example.com",
        adresse: { gateadresse: "Paradis 8", postnr: "5232", poststed: "Paradis" },
        aktiv: false, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-02-06" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1023, fornavn: "Sander", etternavn: "Tveit",
        telefon: "33445577", epost: "sander.tveit@example.com",
        adresse: { gateadresse: "Hop 22", postnr: "5232", poststed: "Paradis" },
        aktiv: false, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-02-07" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1024, fornavn: "Mathilde", etternavn: "Strand",
        telefon: "44556688", epost: "mathilde.strand@example.com",
        adresse: { gateadresse: "Breistein 5", postnr: "5104", poststed: "Breistein" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-02-08" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1025, fornavn: "Alexander", etternavn: "Foss",
        telefon: "55667799", epost: "alexander.foss@example.com",
        adresse: { gateadresse: "Kokstad 33", postnr: "5257", poststed: "Kokstad" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-02-09" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1026, fornavn: "Victoria", etternavn: "Berntsen",
        telefon: "66778800", epost: "victoria.berntsen@example.com",
        adresse: { gateadresse: "Midtun 16", postnr: "5224", poststed: "Nesttun" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-02-10" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1027, fornavn: "Daniel", etternavn: "Larsen",
        telefon: "77889911", epost: "daniel.larsen@example.com",
        adresse: { gateadresse: "Hylkje 9", postnr: "5109", poststed: "Hylkje" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-02-11" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1028, fornavn: "Ida", etternavn: "Kristiansen",
        telefon: "88990022", epost: "ida.kristiansen@example.com",
        adresse: { gateadresse: "Ytre Arna 40", postnr: "5267", poststed: "Ytre Arna" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-02-12" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1029, fornavn: "Sebastian", etternavn: "Pedersen",
        telefon: "99001133", epost: "sebastian.pedersen@example.com",
        adresse: { gateadresse: "Indre Arna 25", postnr: "5269", poststed: "Indre Arna" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-02-13" },
            { år: 2026, betalingsdato: null }
        ]
    },
    {
        _id: 1030, fornavn: "Linnea", etternavn: "Johannessen",
        telefon: "00112244", epost: "linnea.johannessen@example.com",
        adresse: { gateadresse: "Eidsvåg 18", postnr: "5105", poststed: "Eidsvåg" },
        aktiv: true, lokallag_id: 1,
        medlemsavgifter: [
            { år: 2025, betalingsdato: "2025-02-14" },
            { år: 2026, betalingsdato: null }
        ]
    }
]);

// =============================================================
// 3. Medlemsavgift historie (eldre betalte avgifter)
//    Kun betalte avgifter lagres her. Ubetalte eldre avgifter
//    ligger fortsatt i medlemmer-samlingen.
// =============================================================
print("Oppretter samling: medlemsavgift_historie");

db.medlemsavgift_historie.insertMany([
    // Medlem 1001 – Lars Jenssen (alle eldre år betalt)
    { _id: "1001_2017", medlemsnummer: 1001, lokallag_id: 1, år: 2017, betalingsdato: "2017-01-16" },
    { _id: "1001_2018", medlemsnummer: 1001, lokallag_id: 1, år: 2018, betalingsdato: "2018-01-16" },
    { _id: "1001_2019", medlemsnummer: 1001, lokallag_id: 1, år: 2019, betalingsdato: "2019-01-16" },
    { _id: "1001_2020", medlemsnummer: 1001, lokallag_id: 1, år: 2020, betalingsdato: "2020-01-16" },
    { _id: "1001_2021", medlemsnummer: 1001, lokallag_id: 1, år: 2021, betalingsdato: "2021-01-16" },
    { _id: "1001_2022", medlemsnummer: 1001, lokallag_id: 1, år: 2022, betalingsdato: "2022-01-16" },
    { _id: "1001_2023", medlemsnummer: 1001, lokallag_id: 1, år: 2023, betalingsdato: "2023-01-16" },
    { _id: "1001_2024", medlemsnummer: 1001, lokallag_id: 1, år: 2024, betalingsdato: "2024-01-16" },

    // Medlem 1002 – Kari Hansen
    { _id: "1002_2017", medlemsnummer: 1002, lokallag_id: 1, år: 2017, betalingsdato: "2017-01-17" },
    { _id: "1002_2018", medlemsnummer: 1002, lokallag_id: 1, år: 2018, betalingsdato: "2018-01-17" },
    { _id: "1002_2019", medlemsnummer: 1002, lokallag_id: 1, år: 2019, betalingsdato: "2019-01-17" },
    { _id: "1002_2020", medlemsnummer: 1002, lokallag_id: 1, år: 2020, betalingsdato: "2020-01-17" },
    { _id: "1002_2021", medlemsnummer: 1002, lokallag_id: 1, år: 2021, betalingsdato: "2021-01-17" },
    { _id: "1002_2022", medlemsnummer: 1002, lokallag_id: 1, år: 2022, betalingsdato: "2022-01-17" },
    { _id: "1002_2023", medlemsnummer: 1002, lokallag_id: 1, år: 2023, betalingsdato: "2023-01-17" },
    { _id: "1002_2024", medlemsnummer: 1002, lokallag_id: 1, år: 2024, betalingsdato: "2024-01-17" },

    // Medlem 1003 – Ola Nordmann (2024 er UBETALT – ligger i medlemmer, ikke her)
    { _id: "1003_2017", medlemsnummer: 1003, lokallag_id: 1, år: 2017, betalingsdato: "2017-01-18" },
    { _id: "1003_2018", medlemsnummer: 1003, lokallag_id: 1, år: 2018, betalingsdato: "2018-01-18" },
    { _id: "1003_2019", medlemsnummer: 1003, lokallag_id: 1, år: 2019, betalingsdato: "2019-01-18" },
    { _id: "1003_2020", medlemsnummer: 1003, lokallag_id: 1, år: 2020, betalingsdato: "2020-01-18" },
    { _id: "1003_2021", medlemsnummer: 1003, lokallag_id: 1, år: 2021, betalingsdato: "2021-01-18" },
    { _id: "1003_2022", medlemsnummer: 1003, lokallag_id: 1, år: 2022, betalingsdato: "2022-01-18" },
    { _id: "1003_2023", medlemsnummer: 1003, lokallag_id: 1, år: 2023, betalingsdato: "2023-01-18" },
    // 2024 mangler – ubetalt, ligger i medlemmer-samlingen

    // Medlem 1004 – Emma Nilsen (2025 er UBETALT – ligger i medlemmer)
    { _id: "1004_2017", medlemsnummer: 1004, lokallag_id: 1, år: 2017, betalingsdato: "2017-01-19" },
    { _id: "1004_2018", medlemsnummer: 1004, lokallag_id: 1, år: 2018, betalingsdato: "2018-01-19" },
    { _id: "1004_2019", medlemsnummer: 1004, lokallag_id: 1, år: 2019, betalingsdato: "2019-01-19" },
    { _id: "1004_2020", medlemsnummer: 1004, lokallag_id: 1, år: 2020, betalingsdato: "2020-01-19" },
    { _id: "1004_2021", medlemsnummer: 1004, lokallag_id: 1, år: 2021, betalingsdato: "2021-01-19" },
    { _id: "1004_2022", medlemsnummer: 1004, lokallag_id: 1, år: 2022, betalingsdato: "2022-01-19" },
    { _id: "1004_2023", medlemsnummer: 1004, lokallag_id: 1, år: 2023, betalingsdato: "2023-01-19" },
    { _id: "1004_2024", medlemsnummer: 1004, lokallag_id: 1, år: 2024, betalingsdato: "2024-01-19" },

    // Medlem 1005 – Jonas Berg
    { _id: "1005_2017", medlemsnummer: 1005, lokallag_id: 1, år: 2017, betalingsdato: "2017-01-20" },
    { _id: "1005_2018", medlemsnummer: 1005, lokallag_id: 1, år: 2018, betalingsdato: "2018-01-20" },
    { _id: "1005_2019", medlemsnummer: 1005, lokallag_id: 1, år: 2019, betalingsdato: "2019-01-20" },
    { _id: "1005_2020", medlemsnummer: 1005, lokallag_id: 1, år: 2020, betalingsdato: "2020-01-20" },
    { _id: "1005_2021", medlemsnummer: 1005, lokallag_id: 1, år: 2021, betalingsdato: "2021-01-20" },
    { _id: "1005_2022", medlemsnummer: 1005, lokallag_id: 1, år: 2022, betalingsdato: "2022-01-20" },
    { _id: "1005_2023", medlemsnummer: 1005, lokallag_id: 1, år: 2023, betalingsdato: "2023-01-20" },
    { _id: "1005_2024", medlemsnummer: 1005, lokallag_id: 1, år: 2024, betalingsdato: "2024-01-20" },

    // Medlem 1006 – Ingrid Olsen
    { _id: "1006_2017", medlemsnummer: 1006, lokallag_id: 1, år: 2017, betalingsdato: "2017-01-21" },
    { _id: "1006_2018", medlemsnummer: 1006, lokallag_id: 1, år: 2018, betalingsdato: "2018-01-21" },
    { _id: "1006_2019", medlemsnummer: 1006, lokallag_id: 1, år: 2019, betalingsdato: "2019-01-21" },
    { _id: "1006_2020", medlemsnummer: 1006, lokallag_id: 1, år: 2020, betalingsdato: "2020-01-21" },
    { _id: "1006_2021", medlemsnummer: 1006, lokallag_id: 1, år: 2021, betalingsdato: "2021-01-21" },
    { _id: "1006_2022", medlemsnummer: 1006, lokallag_id: 1, år: 2022, betalingsdato: "2022-01-21" },
    { _id: "1006_2023", medlemsnummer: 1006, lokallag_id: 1, år: 2023, betalingsdato: "2023-01-21" },
    { _id: "1006_2024", medlemsnummer: 1006, lokallag_id: 1, år: 2024, betalingsdato: "2024-01-21" },

    // Medlem 1007 – Erik Andersen
    { _id: "1007_2017", medlemsnummer: 1007, lokallag_id: 1, år: 2017, betalingsdato: "2017-01-22" },
    { _id: "1007_2018", medlemsnummer: 1007, lokallag_id: 1, år: 2018, betalingsdato: "2018-01-22" },
    { _id: "1007_2019", medlemsnummer: 1007, lokallag_id: 1, år: 2019, betalingsdato: "2019-01-22" },
    { _id: "1007_2020", medlemsnummer: 1007, lokallag_id: 1, år: 2020, betalingsdato: "2020-01-22" },
    { _id: "1007_2021", medlemsnummer: 1007, lokallag_id: 1, år: 2021, betalingsdato: "2021-01-22" },
    { _id: "1007_2022", medlemsnummer: 1007, lokallag_id: 1, år: 2022, betalingsdato: "2022-01-22" },
    { _id: "1007_2023", medlemsnummer: 1007, lokallag_id: 1, år: 2023, betalingsdato: "2023-01-22" },
    { _id: "1007_2024", medlemsnummer: 1007, lokallag_id: 1, år: 2024, betalingsdato: "2024-01-22" },

    // Medlem 1008 – Sara Eriksen
    { _id: "1008_2017", medlemsnummer: 1008, lokallag_id: 1, år: 2017, betalingsdato: "2017-01-23" },
    { _id: "1008_2018", medlemsnummer: 1008, lokallag_id: 1, år: 2018, betalingsdato: "2018-01-23" },
    { _id: "1008_2019", medlemsnummer: 1008, lokallag_id: 1, år: 2019, betalingsdato: "2019-01-23" },
    { _id: "1008_2020", medlemsnummer: 1008, lokallag_id: 1, år: 2020, betalingsdato: "2020-01-23" },
    { _id: "1008_2021", medlemsnummer: 1008, lokallag_id: 1, år: 2021, betalingsdato: "2021-01-23" },
    { _id: "1008_2022", medlemsnummer: 1008, lokallag_id: 1, år: 2022, betalingsdato: "2022-01-23" },
    { _id: "1008_2023", medlemsnummer: 1008, lokallag_id: 1, år: 2023, betalingsdato: "2023-01-23" },
    { _id: "1008_2024", medlemsnummer: 1008, lokallag_id: 1, år: 2024, betalingsdato: "2024-01-23" },

    // Medlem 1009 – Martin Lie
    { _id: "1009_2017", medlemsnummer: 1009, lokallag_id: 1, år: 2017, betalingsdato: "2017-01-24" },
    { _id: "1009_2018", medlemsnummer: 1009, lokallag_id: 1, år: 2018, betalingsdato: "2018-01-24" },
    { _id: "1009_2019", medlemsnummer: 1009, lokallag_id: 1, år: 2019, betalingsdato: "2019-01-24" },
    { _id: "1009_2020", medlemsnummer: 1009, lokallag_id: 1, år: 2020, betalingsdato: "2020-01-24" },
    { _id: "1009_2021", medlemsnummer: 1009, lokallag_id: 1, år: 2021, betalingsdato: "2021-01-24" },
    { _id: "1009_2022", medlemsnummer: 1009, lokallag_id: 1, år: 2022, betalingsdato: "2022-01-24" },
    { _id: "1009_2023", medlemsnummer: 1009, lokallag_id: 1, år: 2023, betalingsdato: "2023-01-24" },
    { _id: "1009_2024", medlemsnummer: 1009, lokallag_id: 1, år: 2024, betalingsdato: "2024-01-24" },

    // Medlem 1010 – Marte Saether (2023 og 2024 er UBETALTE – ligger i medlemmer)
    { _id: "1010_2017", medlemsnummer: 1010, lokallag_id: 1, år: 2017, betalingsdato: "2017-01-25" },
    { _id: "1010_2018", medlemsnummer: 1010, lokallag_id: 1, år: 2018, betalingsdato: "2018-01-25" },
    { _id: "1010_2019", medlemsnummer: 1010, lokallag_id: 1, år: 2019, betalingsdato: "2019-01-25" },
    { _id: "1010_2020", medlemsnummer: 1010, lokallag_id: 1, år: 2020, betalingsdato: "2020-01-25" },
    { _id: "1010_2021", medlemsnummer: 1010, lokallag_id: 1, år: 2021, betalingsdato: "2021-01-25" },
    { _id: "1010_2022", medlemsnummer: 1010, lokallag_id: 1, år: 2022, betalingsdato: "2022-01-25" },
    // 2023 og 2024 mangler – ubetalte, ligger i medlemmer-samlingen

    // Medlem 1011 – Thomas Moen
    { _id: "1011_2017", medlemsnummer: 1011, lokallag_id: 1, år: 2017, betalingsdato: "2017-01-26" },
    { _id: "1011_2018", medlemsnummer: 1011, lokallag_id: 1, år: 2018, betalingsdato: "2018-01-26" },
    { _id: "1011_2019", medlemsnummer: 1011, lokallag_id: 1, år: 2019, betalingsdato: "2019-01-26" },
    { _id: "1011_2020", medlemsnummer: 1011, lokallag_id: 1, år: 2020, betalingsdato: "2020-01-26" },
    { _id: "1011_2021", medlemsnummer: 1011, lokallag_id: 1, år: 2021, betalingsdato: "2021-01-26" },
    { _id: "1011_2022", medlemsnummer: 1011, lokallag_id: 1, år: 2022, betalingsdato: "2022-01-26" },
    { _id: "1011_2023", medlemsnummer: 1011, lokallag_id: 1, år: 2023, betalingsdato: "2023-01-26" },
    { _id: "1011_2024", medlemsnummer: 1011, lokallag_id: 1, år: 2024, betalingsdato: "2024-01-26" },

    // Medlem 1012 – Sofie Lund
    { _id: "1012_2017", medlemsnummer: 1012, lokallag_id: 1, år: 2017, betalingsdato: "2017-01-27" },
    { _id: "1012_2018", medlemsnummer: 1012, lokallag_id: 1, år: 2018, betalingsdato: "2018-01-27" },
    { _id: "1012_2019", medlemsnummer: 1012, lokallag_id: 1, år: 2019, betalingsdato: "2019-01-27" },
    { _id: "1012_2020", medlemsnummer: 1012, lokallag_id: 1, år: 2020, betalingsdato: "2020-01-27" },
    { _id: "1012_2021", medlemsnummer: 1012, lokallag_id: 1, år: 2021, betalingsdato: "2021-01-27" },
    { _id: "1012_2022", medlemsnummer: 1012, lokallag_id: 1, år: 2022, betalingsdato: "2022-01-27" },
    { _id: "1012_2023", medlemsnummer: 1012, lokallag_id: 1, år: 2023, betalingsdato: "2023-01-27" },
    { _id: "1012_2024", medlemsnummer: 1012, lokallag_id: 1, år: 2024, betalingsdato: "2024-01-27" },

    // Medlem 1013 – Henrik Dahl
    { _id: "1013_2017", medlemsnummer: 1013, lokallag_id: 1, år: 2017, betalingsdato: "2017-01-28" },
    { _id: "1013_2018", medlemsnummer: 1013, lokallag_id: 1, år: 2018, betalingsdato: "2018-01-28" },
    { _id: "1013_2019", medlemsnummer: 1013, lokallag_id: 1, år: 2019, betalingsdato: "2019-01-28" },
    { _id: "1013_2020", medlemsnummer: 1013, lokallag_id: 1, år: 2020, betalingsdato: "2020-01-28" },
    { _id: "1013_2021", medlemsnummer: 1013, lokallag_id: 1, år: 2021, betalingsdato: "2021-01-28" },
    { _id: "1013_2022", medlemsnummer: 1013, lokallag_id: 1, år: 2022, betalingsdato: "2022-01-28" },
    { _id: "1013_2023", medlemsnummer: 1013, lokallag_id: 1, år: 2023, betalingsdato: "2023-01-28" },
    { _id: "1013_2024", medlemsnummer: 1013, lokallag_id: 1, år: 2024, betalingsdato: "2024-01-28" },

    // Medlem 1014 – Nora Bakke
    { _id: "1014_2017", medlemsnummer: 1014, lokallag_id: 1, år: 2017, betalingsdato: "2017-01-29" },
    { _id: "1014_2018", medlemsnummer: 1014, lokallag_id: 1, år: 2018, betalingsdato: "2018-01-29" },
    { _id: "1014_2019", medlemsnummer: 1014, lokallag_id: 1, år: 2019, betalingsdato: "2019-01-29" },
    { _id: "1014_2020", medlemsnummer: 1014, lokallag_id: 1, år: 2020, betalingsdato: "2020-01-29" },
    { _id: "1014_2021", medlemsnummer: 1014, lokallag_id: 1, år: 2021, betalingsdato: "2021-01-29" },
    { _id: "1014_2022", medlemsnummer: 1014, lokallag_id: 1, år: 2022, betalingsdato: "2022-01-29" },
    { _id: "1014_2023", medlemsnummer: 1014, lokallag_id: 1, år: 2023, betalingsdato: "2023-01-29" },
    { _id: "1014_2024", medlemsnummer: 1014, lokallag_id: 1, år: 2024, betalingsdato: "2024-01-29" },

    // Medlem 1015 – Markus Hauge
    { _id: "1015_2017", medlemsnummer: 1015, lokallag_id: 1, år: 2017, betalingsdato: "2017-01-30" },
    { _id: "1015_2018", medlemsnummer: 1015, lokallag_id: 1, år: 2018, betalingsdato: "2018-01-30" },
    { _id: "1015_2019", medlemsnummer: 1015, lokallag_id: 1, år: 2019, betalingsdato: "2019-01-30" },
    { _id: "1015_2020", medlemsnummer: 1015, lokallag_id: 1, år: 2020, betalingsdato: "2020-01-30" },
    { _id: "1015_2021", medlemsnummer: 1015, lokallag_id: 1, år: 2021, betalingsdato: "2021-01-30" },
    { _id: "1015_2022", medlemsnummer: 1015, lokallag_id: 1, år: 2022, betalingsdato: "2022-01-30" },
    { _id: "1015_2023", medlemsnummer: 1015, lokallag_id: 1, år: 2023, betalingsdato: "2023-01-30" },
    { _id: "1015_2024", medlemsnummer: 1015, lokallag_id: 1, år: 2024, betalingsdato: "2024-01-30" },

    // Medlem 1016 – Julie Solberg
    { _id: "1016_2017", medlemsnummer: 1016, lokallag_id: 1, år: 2017, betalingsdato: "2017-01-31" },
    { _id: "1016_2018", medlemsnummer: 1016, lokallag_id: 1, år: 2018, betalingsdato: "2018-01-31" },
    { _id: "1016_2019", medlemsnummer: 1016, lokallag_id: 1, år: 2019, betalingsdato: "2019-01-31" },
    { _id: "1016_2020", medlemsnummer: 1016, lokallag_id: 1, år: 2020, betalingsdato: "2020-01-31" },
    { _id: "1016_2021", medlemsnummer: 1016, lokallag_id: 1, år: 2021, betalingsdato: "2021-01-31" },
    { _id: "1016_2022", medlemsnummer: 1016, lokallag_id: 1, år: 2022, betalingsdato: "2022-01-31" },
    { _id: "1016_2023", medlemsnummer: 1016, lokallag_id: 1, år: 2023, betalingsdato: "2023-01-31" },
    { _id: "1016_2024", medlemsnummer: 1016, lokallag_id: 1, år: 2024, betalingsdato: "2024-01-31" },

    // Medlem 1017 – Andreas Vik
    { _id: "1017_2017", medlemsnummer: 1017, lokallag_id: 1, år: 2017, betalingsdato: "2017-02-01" },
    { _id: "1017_2018", medlemsnummer: 1017, lokallag_id: 1, år: 2018, betalingsdato: "2018-02-01" },
    { _id: "1017_2019", medlemsnummer: 1017, lokallag_id: 1, år: 2019, betalingsdato: "2019-02-01" },
    { _id: "1017_2020", medlemsnummer: 1017, lokallag_id: 1, år: 2020, betalingsdato: "2020-02-01" },
    { _id: "1017_2021", medlemsnummer: 1017, lokallag_id: 1, år: 2021, betalingsdato: "2021-02-01" },
    { _id: "1017_2022", medlemsnummer: 1017, lokallag_id: 1, år: 2022, betalingsdato: "2022-02-01" },
    { _id: "1017_2023", medlemsnummer: 1017, lokallag_id: 1, år: 2023, betalingsdato: "2023-02-01" },
    { _id: "1017_2024", medlemsnummer: 1017, lokallag_id: 1, år: 2024, betalingsdato: "2024-02-01" },

    // Medlem 1018 – Thea Hagen
    { _id: "1018_2017", medlemsnummer: 1018, lokallag_id: 1, år: 2017, betalingsdato: "2017-02-02" },
    { _id: "1018_2018", medlemsnummer: 1018, lokallag_id: 1, år: 2018, betalingsdato: "2018-02-02" },
    { _id: "1018_2019", medlemsnummer: 1018, lokallag_id: 1, år: 2019, betalingsdato: "2019-02-02" },
    { _id: "1018_2020", medlemsnummer: 1018, lokallag_id: 1, år: 2020, betalingsdato: "2020-02-02" },
    { _id: "1018_2021", medlemsnummer: 1018, lokallag_id: 1, år: 2021, betalingsdato: "2021-02-02" },
    { _id: "1018_2022", medlemsnummer: 1018, lokallag_id: 1, år: 2022, betalingsdato: "2022-02-02" },
    { _id: "1018_2023", medlemsnummer: 1018, lokallag_id: 1, år: 2023, betalingsdato: "2023-02-02" },
    { _id: "1018_2024", medlemsnummer: 1018, lokallag_id: 1, år: 2024, betalingsdato: "2024-02-02" },

    // Medlem 1019 – Magnus Rønning
    { _id: "1019_2017", medlemsnummer: 1019, lokallag_id: 1, år: 2017, betalingsdato: "2017-02-03" },
    { _id: "1019_2018", medlemsnummer: 1019, lokallag_id: 1, år: 2018, betalingsdato: "2018-02-03" },
    { _id: "1019_2019", medlemsnummer: 1019, lokallag_id: 1, år: 2019, betalingsdato: "2019-02-03" },
    { _id: "1019_2020", medlemsnummer: 1019, lokallag_id: 1, år: 2020, betalingsdato: "2020-02-03" },
    { _id: "1019_2021", medlemsnummer: 1019, lokallag_id: 1, år: 2021, betalingsdato: "2021-02-03" },
    { _id: "1019_2022", medlemsnummer: 1019, lokallag_id: 1, år: 2022, betalingsdato: "2022-02-03" },
    { _id: "1019_2023", medlemsnummer: 1019, lokallag_id: 1, år: 2023, betalingsdato: "2023-02-03" },
    { _id: "1019_2024", medlemsnummer: 1019, lokallag_id: 1, år: 2024, betalingsdato: "2024-02-03" },

    // Medlem 1020 – Emilie Knutsen
    { _id: "1020_2017", medlemsnummer: 1020, lokallag_id: 1, år: 2017, betalingsdato: "2017-02-04" },
    { _id: "1020_2018", medlemsnummer: 1020, lokallag_id: 1, år: 2018, betalingsdato: "2018-02-04" },
    { _id: "1020_2019", medlemsnummer: 1020, lokallag_id: 1, år: 2019, betalingsdato: "2019-02-04" },
    { _id: "1020_2020", medlemsnummer: 1020, lokallag_id: 1, år: 2020, betalingsdato: "2020-02-04" },
    { _id: "1020_2021", medlemsnummer: 1020, lokallag_id: 1, år: 2021, betalingsdato: "2021-02-04" },
    { _id: "1020_2022", medlemsnummer: 1020, lokallag_id: 1, år: 2022, betalingsdato: "2022-02-04" },
    { _id: "1020_2023", medlemsnummer: 1020, lokallag_id: 1, år: 2023, betalingsdato: "2023-02-04" },
    { _id: "1020_2024", medlemsnummer: 1020, lokallag_id: 1, år: 2024, betalingsdato: "2024-02-04" },

    // Medlem 1021 – Kristian Berge
    { _id: "1021_2017", medlemsnummer: 1021, lokallag_id: 1, år: 2017, betalingsdato: "2017-02-05" },
    { _id: "1021_2018", medlemsnummer: 1021, lokallag_id: 1, år: 2018, betalingsdato: "2018-02-05" },
    { _id: "1021_2019", medlemsnummer: 1021, lokallag_id: 1, år: 2019, betalingsdato: "2019-02-05" },
    { _id: "1021_2020", medlemsnummer: 1021, lokallag_id: 1, år: 2020, betalingsdato: "2020-02-05" },
    { _id: "1021_2021", medlemsnummer: 1021, lokallag_id: 1, år: 2021, betalingsdato: "2021-02-05" },
    { _id: "1021_2022", medlemsnummer: 1021, lokallag_id: 1, år: 2022, betalingsdato: "2022-02-05" },
    { _id: "1021_2023", medlemsnummer: 1021, lokallag_id: 1, år: 2023, betalingsdato: "2023-02-05" },
    { _id: "1021_2024", medlemsnummer: 1021, lokallag_id: 1, år: 2024, betalingsdato: "2024-02-05" },

    // Medlem 1022 – Amalie Myklebust
    { _id: "1022_2017", medlemsnummer: 1022, lokallag_id: 1, år: 2017, betalingsdato: "2017-02-06" },
    { _id: "1022_2018", medlemsnummer: 1022, lokallag_id: 1, år: 2018, betalingsdato: "2018-02-06" },
    { _id: "1022_2019", medlemsnummer: 1022, lokallag_id: 1, år: 2019, betalingsdato: "2019-02-06" },
    { _id: "1022_2020", medlemsnummer: 1022, lokallag_id: 1, år: 2020, betalingsdato: "2020-02-06" },
    { _id: "1022_2021", medlemsnummer: 1022, lokallag_id: 1, år: 2021, betalingsdato: "2021-02-06" },
    { _id: "1022_2022", medlemsnummer: 1022, lokallag_id: 1, år: 2022, betalingsdato: "2022-02-06" },
    { _id: "1022_2023", medlemsnummer: 1022, lokallag_id: 1, år: 2023, betalingsdato: "2023-02-06" },
    { _id: "1022_2024", medlemsnummer: 1022, lokallag_id: 1, år: 2024, betalingsdato: "2024-02-06" },

    // Medlem 1023 – Sander Tveit
    { _id: "1023_2017", medlemsnummer: 1023, lokallag_id: 1, år: 2017, betalingsdato: "2017-02-07" },
    { _id: "1023_2018", medlemsnummer: 1023, lokallag_id: 1, år: 2018, betalingsdato: "2018-02-07" },
    { _id: "1023_2019", medlemsnummer: 1023, lokallag_id: 1, år: 2019, betalingsdato: "2019-02-07" },
    { _id: "1023_2020", medlemsnummer: 1023, lokallag_id: 1, år: 2020, betalingsdato: "2020-02-07" },
    { _id: "1023_2021", medlemsnummer: 1023, lokallag_id: 1, år: 2021, betalingsdato: "2021-02-07" },
    { _id: "1023_2022", medlemsnummer: 1023, lokallag_id: 1, år: 2022, betalingsdato: "2022-02-07" },
    { _id: "1023_2023", medlemsnummer: 1023, lokallag_id: 1, år: 2023, betalingsdato: "2023-02-07" },
    { _id: "1023_2024", medlemsnummer: 1023, lokallag_id: 1, år: 2024, betalingsdato: "2024-02-07" },

    // Medlem 1024 – Mathilde Strand
    { _id: "1024_2017", medlemsnummer: 1024, lokallag_id: 1, år: 2017, betalingsdato: "2017-02-08" },
    { _id: "1024_2018", medlemsnummer: 1024, lokallag_id: 1, år: 2018, betalingsdato: "2018-02-08" },
    { _id: "1024_2019", medlemsnummer: 1024, lokallag_id: 1, år: 2019, betalingsdato: "2019-02-08" },
    { _id: "1024_2020", medlemsnummer: 1024, lokallag_id: 1, år: 2020, betalingsdato: "2020-02-08" },
    { _id: "1024_2021", medlemsnummer: 1024, lokallag_id: 1, år: 2021, betalingsdato: "2021-02-08" },
    { _id: "1024_2022", medlemsnummer: 1024, lokallag_id: 1, år: 2022, betalingsdato: "2022-02-08" },
    { _id: "1024_2023", medlemsnummer: 1024, lokallag_id: 1, år: 2023, betalingsdato: "2023-02-08" },
    { _id: "1024_2024", medlemsnummer: 1024, lokallag_id: 1, år: 2024, betalingsdato: "2024-02-08" },

    // Medlem 1025 – Alexander Foss
    { _id: "1025_2017", medlemsnummer: 1025, lokallag_id: 1, år: 2017, betalingsdato: "2017-02-09" },
    { _id: "1025_2018", medlemsnummer: 1025, lokallag_id: 1, år: 2018, betalingsdato: "2018-02-09" },
    { _id: "1025_2019", medlemsnummer: 1025, lokallag_id: 1, år: 2019, betalingsdato: "2019-02-09" },
    { _id: "1025_2020", medlemsnummer: 1025, lokallag_id: 1, år: 2020, betalingsdato: "2020-02-09" },
    { _id: "1025_2021", medlemsnummer: 1025, lokallag_id: 1, år: 2021, betalingsdato: "2021-02-09" },
    { _id: "1025_2022", medlemsnummer: 1025, lokallag_id: 1, år: 2022, betalingsdato: "2022-02-09" },
    { _id: "1025_2023", medlemsnummer: 1025, lokallag_id: 1, år: 2023, betalingsdato: "2023-02-09" },
    { _id: "1025_2024", medlemsnummer: 1025, lokallag_id: 1, år: 2024, betalingsdato: "2024-02-09" },

    // Medlem 1026 – Victoria Berntsen
    { _id: "1026_2017", medlemsnummer: 1026, lokallag_id: 1, år: 2017, betalingsdato: "2017-02-10" },
    { _id: "1026_2018", medlemsnummer: 1026, lokallag_id: 1, år: 2018, betalingsdato: "2018-02-10" },
    { _id: "1026_2019", medlemsnummer: 1026, lokallag_id: 1, år: 2019, betalingsdato: "2019-02-10" },
    { _id: "1026_2020", medlemsnummer: 1026, lokallag_id: 1, år: 2020, betalingsdato: "2020-02-10" },
    { _id: "1026_2021", medlemsnummer: 1026, lokallag_id: 1, år: 2021, betalingsdato: "2021-02-10" },
    { _id: "1026_2022", medlemsnummer: 1026, lokallag_id: 1, år: 2022, betalingsdato: "2022-02-10" },
    { _id: "1026_2023", medlemsnummer: 1026, lokallag_id: 1, år: 2023, betalingsdato: "2023-02-10" },
    { _id: "1026_2024", medlemsnummer: 1026, lokallag_id: 1, år: 2024, betalingsdato: "2024-02-10" },

    // Medlem 1027 – Daniel Larsen
    { _id: "1027_2017", medlemsnummer: 1027, lokallag_id: 1, år: 2017, betalingsdato: "2017-02-11" },
    { _id: "1027_2018", medlemsnummer: 1027, lokallag_id: 1, år: 2018, betalingsdato: "2018-02-11" },
    { _id: "1027_2019", medlemsnummer: 1027, lokallag_id: 1, år: 2019, betalingsdato: "2019-02-11" },
    { _id: "1027_2020", medlemsnummer: 1027, lokallag_id: 1, år: 2020, betalingsdato: "2020-02-11" },
    { _id: "1027_2021", medlemsnummer: 1027, lokallag_id: 1, år: 2021, betalingsdato: "2021-02-11" },
    { _id: "1027_2022", medlemsnummer: 1027, lokallag_id: 1, år: 2022, betalingsdato: "2022-02-11" },
    { _id: "1027_2023", medlemsnummer: 1027, lokallag_id: 1, år: 2023, betalingsdato: "2023-02-11" },
    { _id: "1027_2024", medlemsnummer: 1027, lokallag_id: 1, år: 2024, betalingsdato: "2024-02-11" },

    // Medlem 1028 – Ida Kristiansen
    { _id: "1028_2017", medlemsnummer: 1028, lokallag_id: 1, år: 2017, betalingsdato: "2017-02-12" },
    { _id: "1028_2018", medlemsnummer: 1028, lokallag_id: 1, år: 2018, betalingsdato: "2018-02-12" },
    { _id: "1028_2019", medlemsnummer: 1028, lokallag_id: 1, år: 2019, betalingsdato: "2019-02-12" },
    { _id: "1028_2020", medlemsnummer: 1028, lokallag_id: 1, år: 2020, betalingsdato: "2020-02-12" },
    { _id: "1028_2021", medlemsnummer: 1028, lokallag_id: 1, år: 2021, betalingsdato: "2021-02-12" },
    { _id: "1028_2022", medlemsnummer: 1028, lokallag_id: 1, år: 2022, betalingsdato: "2022-02-12" },
    { _id: "1028_2023", medlemsnummer: 1028, lokallag_id: 1, år: 2023, betalingsdato: "2023-02-12" },
    { _id: "1028_2024", medlemsnummer: 1028, lokallag_id: 1, år: 2024, betalingsdato: "2024-02-12" },

    // Medlem 1029 – Sebastian Pedersen
    { _id: "1029_2017", medlemsnummer: 1029, lokallag_id: 1, år: 2017, betalingsdato: "2017-02-13" },
    { _id: "1029_2018", medlemsnummer: 1029, lokallag_id: 1, år: 2018, betalingsdato: "2018-02-13" },
    { _id: "1029_2019", medlemsnummer: 1029, lokallag_id: 1, år: 2019, betalingsdato: "2019-02-13" },
    { _id: "1029_2020", medlemsnummer: 1029, lokallag_id: 1, år: 2020, betalingsdato: "2020-02-13" },
    { _id: "1029_2021", medlemsnummer: 1029, lokallag_id: 1, år: 2021, betalingsdato: "2021-02-13" },
    { _id: "1029_2022", medlemsnummer: 1029, lokallag_id: 1, år: 2022, betalingsdato: "2022-02-13" },
    { _id: "1029_2023", medlemsnummer: 1029, lokallag_id: 1, år: 2023, betalingsdato: "2023-02-13" },
    { _id: "1029_2024", medlemsnummer: 1029, lokallag_id: 1, år: 2024, betalingsdato: "2024-02-13" },

    // Medlem 1030 – Linnea Johannessen
    { _id: "1030_2017", medlemsnummer: 1030, lokallag_id: 1, år: 2017, betalingsdato: "2017-02-14" },
    { _id: "1030_2018", medlemsnummer: 1030, lokallag_id: 1, år: 2018, betalingsdato: "2018-02-14" },
    { _id: "1030_2019", medlemsnummer: 1030, lokallag_id: 1, år: 2019, betalingsdato: "2019-02-14" },
    { _id: "1030_2020", medlemsnummer: 1030, lokallag_id: 1, år: 2020, betalingsdato: "2020-02-14" },
    { _id: "1030_2021", medlemsnummer: 1030, lokallag_id: 1, år: 2021, betalingsdato: "2021-02-14" },
    { _id: "1030_2022", medlemsnummer: 1030, lokallag_id: 1, år: 2022, betalingsdato: "2022-02-14" },
    { _id: "1030_2023", medlemsnummer: 1030, lokallag_id: 1, år: 2023, betalingsdato: "2023-02-14" },
    { _id: "1030_2024", medlemsnummer: 1030, lokallag_id: 1, år: 2024, betalingsdato: "2024-02-14" }
]);

// =============================================================
// Indekser
// =============================================================
db.medlemmer.createIndex({ lokallag_id: 1 });
db.medlemmer.createIndex({ aktiv: 1 });
db.medlemsavgift_historie.createIndex({ medlemsnummer: 1, "år": 1 });

// =============================================================
// Verifikasjon
// =============================================================
print("\n--- Verifikasjon ---");
print("Antall lokallag:             " + db.lokallag.countDocuments());
print("Antall medlemmer:            " + db.medlemmer.countDocuments());
print("Antall avgifter i historie:  " + db.medlemsavgift_historie.countDocuments());

print("\n--- Eksempel medlem (1001) ---");
printjson(db.medlemmer.findOne({ _id: 1001 }));

print("\n--- Eksempel medlem med ubetalte eldre avgifter (1010) ---");
printjson(db.medlemmer.findOne({ _id: 1010 }));

print("\n--- Historikk for medlem 1001 (3 første) ---");
printjson(db.medlemsavgift_historie.find({ medlemsnummer: 1001 }).sort({ "år": 1 }).limit(3).toArray());

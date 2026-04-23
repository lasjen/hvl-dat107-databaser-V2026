// =============================================================
// create-demo-data.js
// Oppretter samlinger i databasen "birken" med data fra
// birken-paamelding.xml (puljer og personer).
//
// Kjøres automatisk ved oppstart av docker-compose,
// eller manuelt:
//   mongosh birken create-demo-data.js
// =============================================================

db = db.getSiblingDB("birken");

db.puljer.drop();
db.personer.drop();

// ---- Puljer ----

db.puljer.insertMany([
    { _id: 1, startTid: "2026-03-15T08:00:00" },
    { _id: 2, startTid: "2026-03-15T08:30:00" },
    { _id: 3, startTid: "2026-03-15T09:00:00" },
    { _id: 4, startTid: "2026-03-15T09:30:00" },
    { _id: 5, startTid: "2026-03-15T10:00:00" }
]);

// ---- Personer ----

db.personer.insertMany([

    // Foresatt
    {
        _id: "h0001",
        navn: "Lasse Jenssen",
        fdato: "1983-05-12",
        fnr: "12058348217",
        medlem: true,
        poeng: 1200.01,
        hjemmeside: "https://www.jcon.no/blog",
        puljeId: 2
    },

    // Foresatt (merk: fdato i XML er ugyldig: 1975-03-00)
    {
        _id: "h0002",
        navn: "Ola Hansen",
        fdato: "1975-03-01",
        medlem: true,
        poeng: 4405.21,
        hjemmeside: "www.olahansen.no",
        puljeId: 1
    },

    // Barn under 16 år
    {
        _id: "d0005",
        navn: "Norah Jenssen",
        fdato: "2012-12-02",
        fnr: "02121250683",
        medlem: false,
        poeng: 621.23,
        hjemmeside: "https://www.jenssen.no/nora",
        puljeId: 5,
        foresattId: "h0001"
    },

    // --- Herrer ---

    { _id: "h0003", navn: "Jonas Berg",        fdato: "1988-01-14", fnr: "14018883725", medlem: true,  poeng: 980.12,  hjemmeside: "https://example.com/jonas-berg",        puljeId: 2 },
    { _id: "h0004", navn: "Mats Lunde",        fdato: "1990-04-21", fnr: "21049019357", medlem: false, poeng: 765.33,  hjemmeside: "https://example.com/mats-lunde",        puljeId: 3 },
    { _id: "h0005", navn: "Thomas Engen",      fdato: "1988-05-03", fnr: "03058862491", medlem: true,  poeng: 905.20,  hjemmeside: "https://example.com/thomas-engen",      puljeId: 2 },
    { _id: "h0006", navn: "Henrik Aas",        fdato: "1982-11-05", fnr: "05118228530", medlem: true,  poeng: 1105.44, hjemmeside: "https://example.com/henrik-aas",        puljeId: 1 },
    { _id: "h0007", navn: "Anders Lie",        fdato: "1979-09-18", fnr: "18097959372", medlem: false, poeng: 845.67,  hjemmeside: "https://example.com/anders-lie",        puljeId: 2 },
    { _id: "h0008", navn: "Kristoffer Moe",    fdato: "1995-02-10", fnr: "10029528463", medlem: true,  poeng: 930.22,  hjemmeside: "https://example.com/kristoffer-moe",    puljeId: 4 },
    { _id: "h0009", navn: "Sindre Johansen",   fdato: "1986-07-29", fnr: "29078613504", medlem: true,  poeng: 1010.50, hjemmeside: "https://example.com/sindre-johansen",   puljeId: 2 },
    { _id: "h0010", navn: "Emil Røed",         fdato: "1992-03-12", fnr: "12039202758", medlem: false, poeng: 720.84,  hjemmeside: "https://example.com/emil-rod",          puljeId: 3 },
    { _id: "h0011", navn: "Vetle Skaar",       fdato: "1984-05-22", fnr: "22058455370", medlem: true,  poeng: 990.77,  hjemmeside: "https://example.com/vetle-skaar",       puljeId: 1 },
    { _id: "h0012", navn: "Trym Eide",         fdato: "1981-10-09", fnr: "09108118065", medlem: false, poeng: 800.12,  hjemmeside: "https://example.com/trym-eide",         puljeId: 2 },
    { _id: "h0013", navn: "Leif Knutsen",      fdato: "1977-08-16", fnr: "16087720793", medlem: true,  poeng: 1055.66, hjemmeside: "https://example.com/leif-knutsen",      puljeId: 1 },
    { _id: "h0014", navn: "Petter Dahl",       fdato: "1993-06-03", fnr: "03069396218", medlem: false, poeng: 760.42,  hjemmeside: "https://example.com/petter-dahl",       puljeId: 3 },
    { _id: "h0015", navn: "Jørgen Hauge",      fdato: "1989-12-24", fnr: "24128953601", medlem: true,  poeng: 1005.90, hjemmeside: "https://example.com/jorgen-hauge",      puljeId: 2 },
    { _id: "h0016", navn: "Eirik Tangen",      fdato: "1987-02-27", fnr: "27028704215", medlem: false, poeng: 835.13,  hjemmeside: "https://example.com/eirik-tangen",      puljeId: 3 },
    { _id: "h0017", navn: "Sigurd Vik",        fdato: "1980-01-30", fnr: "30018075624", medlem: true,  poeng: 1120.88, hjemmeside: "https://example.com/sigurd-vik",         puljeId: 1 },
    { _id: "h0018", navn: "Filip Nymoen",      fdato: "1996-09-11", fnr: "11099669458", medlem: false, poeng: 745.25,  hjemmeside: "https://example.com/filip-nymoen",      puljeId: 4 },
    { _id: "h0019", navn: "Ulrik Foss",        fdato: "1978-04-07", fnr: "07047848516", medlem: true,  poeng: 990.31,  hjemmeside: "https://example.com/ulrik-foss",        puljeId: 2 },
    { _id: "h0020", navn: "Ruben Sand",        fdato: "1991-11-19", fnr: "19119119832", medlem: false, poeng: 780.64,  hjemmeside: "https://example.com/ruben-sand",        puljeId: 3 },
    { _id: "h0021", navn: "Kristian Lund",     fdato: "1985-03-23", fnr: "23038576014", medlem: true,  poeng: 1025.47, hjemmeside: "https://example.com/kristian-lund",     puljeId: 1 },
    { _id: "h0022", navn: "Kenneth Myhre",     fdato: "1983-07-02", fnr: "02078316275", medlem: false, poeng: 850.76,  hjemmeside: "https://example.com/kenneth-myhre",     puljeId: 2 },

    // --- Damer ---

    { _id: "d0006", navn: "Marie Solberg",       fdato: "1994-02-08", fnr: "08029472613", medlem: true,  poeng: 970.33,  hjemmeside: "https://example.com/marie-solberg",       puljeId: 4 },
    { _id: "d0007", navn: "Silje Haug",          fdato: "1990-10-15", fnr: "15109001349", medlem: false, poeng: 720.22,  hjemmeside: "https://example.com/silje-haug",          puljeId: 3 },
    { _id: "d0008", navn: "Line Karlsen",        fdato: "1988-06-19", fnr: "19068885403", medlem: true,  poeng: 990.55,  hjemmeside: "https://example.com/line-karlsen",        puljeId: 2 },
    { _id: "d0009", navn: "Nora Vik",            fdato: "1995-11-30", fnr: "30119551327", medlem: false, poeng: 740.68,  hjemmeside: "https://example.com/nora-vik",            puljeId: 3 },
    { _id: "d0010", navn: "Tuva Nilsen",         fdato: "1992-01-05", fnr: "05019213598", medlem: true,  poeng: 950.10,  hjemmeside: "https://example.com/tuva-nilsen",         puljeId: 4 },
    { _id: "d0011", navn: "Camilla Andersen",    fdato: "1987-03-28", fnr: "28038760941", medlem: false, poeng: 760.91,  hjemmeside: "https://example.com/camilla-andersen",    puljeId: 2 },
    { _id: "d0012", navn: "Ida Berg",            fdato: "1991-04-17", fnr: "17049174162", medlem: true,  poeng: 980.44,  hjemmeside: "https://example.com/ida-berg",            puljeId: 3 },
    { _id: "d0013", navn: "Emilie Larsen",       fdato: "1996-07-22", fnr: "22079680435", medlem: false, poeng: 740.21,  hjemmeside: "https://example.com/emilie-larsen",       puljeId: 4 },
    { _id: "d0014", navn: "Ragnhild Myklebust",  fdato: "1983-08-11", fnr: "11088343890", medlem: true,  poeng: 1015.32, hjemmeside: "https://example.com/ragnhild-myklebust",  puljeId: 2 },
    { _id: "d0015", navn: "Sara Holte",          fdato: "1989-09-09", fnr: "09098938157", medlem: false, poeng: 780.70,  hjemmeside: "https://example.com/sara-holte",          puljeId: 3 },
    { _id: "d0016", navn: "Helene Østby",        fdato: "1985-12-13", fnr: "13128526740", medlem: true,  poeng: 995.88,  hjemmeside: "https://example.com/helene-ostby",        puljeId: 2 },
    { _id: "d0017", navn: "Frida Sunde",         fdato: "1993-02-02", fnr: "02029314965", medlem: false, poeng: 760.10,  hjemmeside: "https://example.com/frida-sunde",         puljeId: 3 },
    { _id: "d0018", navn: "Karoline Fladmark",   fdato: "1987-06-25", fnr: "25068735219", medlem: true,  poeng: 985.11,  hjemmeside: "https://example.com/karoline-fladmark",   puljeId: 4 },
    { _id: "d0019", navn: "Hanna Rønning",       fdato: "1997-05-04", fnr: "04059747036", medlem: false, poeng: 735.44,  hjemmeside: "https://example.com/hanna-ronning",       puljeId: 3 },
    { _id: "d0020", navn: "Vilde Andreassen",    fdato: "1990-03-01", fnr: "01039090671", medlem: true,  poeng: 1000.12, hjemmeside: "https://example.com/vilde-andreassen",    puljeId: 2 },
    { _id: "d0021", navn: "Emma Bråthen",        fdato: "1994-11-07", fnr: "07119470825", medlem: false, poeng: 750.33,  hjemmeside: "https://example.com/emma-brathen",        puljeId: 3 },
    { _id: "d0022", navn: "Kristine Haugen",     fdato: "1986-08-18", fnr: "18088643910", medlem: true,  poeng: 995.44,  hjemmeside: "https://example.com/kristine-haugen",     puljeId: 1 },
    { _id: "d0023", navn: "Julie Storm",         fdato: "1992-09-29", fnr: "29099287613", medlem: false, poeng: 770.80,  hjemmeside: "https://example.com/julie-storm",         puljeId: 3 },
    { _id: "d0024", navn: "Malin Thorsen",       fdato: "1995-01-16", fnr: "16019501973", medlem: true,  poeng: 960.12,  hjemmeside: "https://example.com/malin-thorsen",       puljeId: 4 },
    { _id: "d0025", navn: "Andrea Olsen",        fdato: "1998-10-10", fnr: "10109815602", medlem: false, poeng: 740.22,  hjemmeside: "https://example.com/andrea-olsen",        puljeId: 3 }
]);

// ---- Indekser ----

db.personer.createIndex({ puljeId: 1 });
db.personer.createIndex({ medlem: 1 });
db.personer.createIndex({ poeng: -1 });

// ---- Verifikasjon ----

print("\n--- Verifikasjon ---");
print("Antall puljer:    " + db.puljer.countDocuments());
print("Antall personer:  " + db.personer.countDocuments());
print("Antall medlemmer: " + db.personer.countDocuments({ medlem: true }));
print("Antall med foresatt: " + db.personer.countDocuments({ foresattId: { $exists: true } }));


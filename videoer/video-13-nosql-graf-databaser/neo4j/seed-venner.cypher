// seed-venner.cypher
// Oppretter 20 personer med tilfeldige VENNER-relasjoner

// Slett alle eksisterende data
MATCH (n) DETACH DELETE n;

// Opprett 20 personer med brukernavn, fornavn, etternavn og by
CREATE (p1:Person {brukernavn: "olano", fornavn: "Ola", etternavn: "Nordmann", by: "Bergen"}),
       (p2:Person {brukernavn: "karih", fornavn: "Kari", etternavn: "Hansen", by: "Oslo"}),
       (p3:Person {brukernavn: "perj", fornavn: "Per", etternavn: "Johansen", by: "Stavanger"}),
       (p4:Person {brukernavn: "linea", fornavn: "Line", etternavn: "Andersen", by: "Trondheim"}),
       (p5:Person {brukernavn: "eriko", fornavn: "Erik", etternavn: "Olsen", by: "Bergen"}),
       (p6:Person {brukernavn: "annep", fornavn: "Anne", etternavn: "Pettersen", by: "Oslo"}),
       (p7:Person {brukernavn: "thomasb", fornavn: "Thomas", etternavn: "Berg", by: "Kristiansand"}),
       (p8:Person {brukernavn: "sarala", fornavn: "Sara", etternavn: "Larsen", by: "Bergen"}),
       (p9:Person {brukernavn: "jonask", fornavn: "Jonas", etternavn: "Kristiansen", by: "Tromsø"}),
       (p10:Person {brukernavn: "emmani", fornavn: "Emma", etternavn: "Nielsen", by: "Oslo"}),
       (p11:Person {brukernavn: "martinm", fornavn: "Martin", etternavn: "Martinsen", by: "Bergen"}),
       (p12:Person {brukernavn: "idab", fornavn: "Ida", etternavn: "Bakke", by: "Stavanger"}),
       (p13:Person {brukernavn: "henrikl", fornavn: "Henrik", etternavn: "Lie", by: "Trondheim"}),
       (p14:Person {brukernavn: "mariel", fornavn: "Marie", etternavn: "Lund", by: "Oslo"}),
       (p15:Person {brukernavn: "mortene", fornavn: "Morten", etternavn: "Eriksen", by: "Bergen"}),
       (p16:Person {brukernavn: "helenes", fornavn: "Helene", etternavn: "Solberg", by: "Drammen"}),
       (p17:Person {brukernavn: "andersl", fornavn: "Anders", etternavn: "Larsen", by: "Bergen"}),
       (p18:Person {brukernavn: "camillaf", fornavn: "Camilla", etternavn: "Fredriksen", by: "Oslo"}),
       (p19:Person {brukernavn: "danielh", fornavn: "Daniel", etternavn: "Haugen", by: "Kristiansand"}),
       (p20:Person {brukernavn: "noran", fornavn: "Nora", etternavn: "Nilsen", by: "Bergen"});

// Opprett tilfeldige VENNER-relasjoner
// Ola er venner med flere
MATCH (p1:Person {brukernavn: "olano"}), (p2:Person {brukernavn: "karih"})
CREATE (p1)-[:VENNER]->(p2);

MATCH (p1:Person {brukernavn: "olano"}), (p5:Person {brukernavn: "eriko"})
CREATE (p1)-[:VENNER]->(p5);

MATCH (p1:Person {brukernavn: "olano"}), (p8:Person {brukernavn: "sarala"})
CREATE (p1)-[:VENNER]->(p8);

MATCH (p1:Person {brukernavn: "olano"}), (p11:Person {brukernavn: "martinm"})
CREATE (p1)-[:VENNER]->(p11);

// Kari er venner med flere
MATCH (p2:Person {brukernavn: "karih"}), (p6:Person {brukernavn: "annep"})
CREATE (p2)-[:VENNER]->(p6);

MATCH (p2:Person {brukernavn: "karih"}), (p10:Person {brukernavn: "emmani"})
CREATE (p2)-[:VENNER]->(p10);

MATCH (p2:Person {brukernavn: "karih"}), (p14:Person {brukernavn: "mariel"})
CREATE (p2)-[:VENNER]->(p14);

// Per er venner med flere
MATCH (p3:Person {brukernavn: "perj"}), (p4:Person {brukernavn: "linea"})
CREATE (p3)-[:VENNER]->(p4);

MATCH (p3:Person {brukernavn: "perj"}), (p12:Person {brukernavn: "idab"})
CREATE (p3)-[:VENNER]->(p12);

// Line er venner med flere
MATCH (p4:Person {brukernavn: "linea"}), (p13:Person {brukernavn: "henrikl"})
CREATE (p4)-[:VENNER]->(p13);

MATCH (p4:Person {brukernavn: "linea"}), (p9:Person {brukernavn: "jonask"})
CREATE (p4)-[:VENNER]->(p9);

// Erik er venner med flere fra Bergen
MATCH (p5:Person {brukernavn: "eriko"}), (p8:Person {brukernavn: "sarala"})
CREATE (p5)-[:VENNER]->(p8);

MATCH (p5:Person {brukernavn: "eriko"}), (p15:Person {brukernavn: "mortene"})
CREATE (p5)-[:VENNER]->(p15);

MATCH (p5:Person {brukernavn: "eriko"}), (p20:Person {brukernavn: "noran"})
CREATE (p5)-[:VENNER]->(p20);

// Anne er venner med flere fra Oslo
MATCH (p6:Person {brukernavn: "annep"}), (p10:Person {brukernavn: "emmani"})
CREATE (p6)-[:VENNER]->(p10);

MATCH (p6:Person {brukernavn: "annep"}), (p18:Person {brukernavn: "camillaf"})
CREATE (p6)-[:VENNER]->(p18);

// Thomas er venner med flere
MATCH (p7:Person {brukernavn: "thomasb"}), (p19:Person {brukernavn: "danielh"})
CREATE (p7)-[:VENNER]->(p19);

MATCH (p7:Person {brukernavn: "thomasb"}), (p15:Person {brukernavn: "mortene"})
CREATE (p7)-[:VENNER]->(p15);

// Sara er venner med flere
MATCH (p8:Person {brukernavn: "sarala"}), (p11:Person {brukernavn: "martinm"})
CREATE (p8)-[:VENNER]->(p11);

MATCH (p8:Person {brukernavn: "sarala"}), (p17:Person {brukernavn: "andersl"})
CREATE (p8)-[:VENNER]->(p17);

// Jonas er venner med flere
MATCH (p9:Person {brukernavn: "jonask"}), (p13:Person {brukernavn: "henrikl"})
CREATE (p9)-[:VENNER]->(p13);

// Emma er venner med flere
MATCH (p10:Person {brukernavn: "emmani"}), (p14:Person {brukernavn: "mariel"})
CREATE (p10)-[:VENNER]->(p14);

MATCH (p10:Person {brukernavn: "emmani"}), (p18:Person {brukernavn: "camillaf"})
CREATE (p10)-[:VENNER]->(p18);

// Martin er venner med flere
MATCH (p11:Person {brukernavn: "martinm"}), (p15:Person {brukernavn: "mortene"})
CREATE (p11)-[:VENNER]->(p15);

MATCH (p11:Person {brukernavn: "martinm"}), (p17:Person {brukernavn: "andersl"})
CREATE (p11)-[:VENNER]->(p17);

// Ida er venner med flere
MATCH (p12:Person {brukernavn: "idab"}), (p16:Person {brukernavn: "helenes"})
CREATE (p12)-[:VENNER]->(p16);

// Henrik er venner med flere
MATCH (p13:Person {brukernavn: "henrikl"}), (p4:Person {brukernavn: "linea"})
CREATE (p13)-[:VENNER]->(p4);

// Marie er venner med flere
MATCH (p14:Person {brukernavn: "mariel"}), (p18:Person {brukernavn: "camillaf"})
CREATE (p14)-[:VENNER]->(p18);

MATCH (p14:Person {brukernavn: "mariel"}), (p6:Person {brukernavn: "annep"})
CREATE (p14)-[:VENNER]->(p6);

// Morten er venner med flere
MATCH (p15:Person {brukernavn: "mortene"}), (p17:Person {brukernavn: "andersl"})
CREATE (p15)-[:VENNER]->(p17);

MATCH (p15:Person {brukernavn: "mortene"}), (p20:Person {brukernavn: "noran"})
CREATE (p15)-[:VENNER]->(p20);

MATCH (p15:Person {brukernavn: "mortene"}), (p17:Person {brukernavn: "martinm"})
CREATE (p15)-[:VENNER]->(p17), (p17)-[:VENNER]->(p15);

// Helene er venner med flere
MATCH (p16:Person {brukernavn: "helenes"}), (p18:Person {brukernavn: "camillaf"})
CREATE (p16)-[:VENNER]->(p18);

// Anders er venner med flere
MATCH (p17:Person {brukernavn: "andersl"}), (p20:Person {brukernavn: "noran"})
CREATE (p17)-[:VENNER]->(p20);

MATCH (p17:Person {brukernavn: "andersl"}), (p5:Person {brukernavn: "eriko"})
CREATE (p17)-[:VENNER]->(p5);

// Camilla er venner med flere
MATCH (p18:Person {brukernavn: "camillaf"}), (p2:Person {brukernavn: "karih"})
CREATE (p18)-[:VENNER]->(p2);

// Daniel er venner med flere
MATCH (p19:Person {brukernavn: "danielh"}), (p16:Person {brukernavn: "helenes"})
CREATE (p19)-[:VENNER]->(p16);

// Nora er venner med flere fra Bergen
MATCH (p20:Person {brukernavn: "noran"}), (p1:Person {brukernavn: "olano"})
CREATE (p20)-[:VENNER]->(p1);

MATCH (p20:Person {brukernavn: "noran"}), (p11:Person {brukernavn: "martinm"})
CREATE (p20)-[:VENNER]->(p11);


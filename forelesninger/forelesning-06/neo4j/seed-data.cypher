// seed-data.cypher
// Initiell data for HVL Neo4j-databasen
// Inneholder: Forelesere, Studenter, Emner og relasjoner

// Slette eksisterende data
MATCH (n) DETACH DELETE n;

// Opprett Forelesere
CREATE (p:Person:Foreleser {fornavn: "Lasse", etternavn: "Jenssen"});

CREATE (p1:Person:Foreleser {fornavn: "Dag", etternavn: "Toppe Larsen"}),
       (p2:Person:Foreleser {fornavn: "Lars-Petter", etternavn: "Helland"});

// Opprett Student
CREATE (s:Person:Student {fornavn: "Ola", etternavn: "Nordmann"}),
       (s2:Person:Student {fornavn: "Kari", etternavn: "Nordkvinne"}),
       (s3:Person:Student {fornavn: "Nils", etternavn: "Nilsen"}),
       (s4:Person:Student {fornavn: "Eva", etternavn: "Evansdatter"});

// Opprett Emner
CREATE (e1:Emne {kode: "DAT100", navn: "Grunnleggende programmering"}),
       (e2:Emne {kode: "DAT107", navn: "Databaser"}),
       (e3:Emne {kode: "DAT201", navn: "Drift av Oracle databaser"});

// Opprett UNDERVISER-relasjoner
MATCH (p1:Foreleser {fornavn: "Lars-Petter"}), (e1:Emne {kode: "DAT100"})
CREATE (p1)-[:UNDERVISER]->(e1);

MATCH (p1:Foreleser {fornavn: "Dag"}), (e1:Emne {kode: "DAT107"})
CREATE (p1)-[:UNDERVISER]->(e1);

MATCH (p1:Foreleser {fornavn: "Lasse"}), (e1:Emne {kode: "DAT107"})
CREATE (p1)-[:UNDERVISER]->(e1);

MATCH (p1:Foreleser {fornavn: "Lars-Petter"}), (e1:Emne {kode: "DAT107"})
CREATE (p1)-[:UNDERVISER]->(e1);

// Opprett ANSVARLIG-relasjon
MATCH (p1:Foreleser {fornavn: "Dag"}), (e1:Emne {kode: "DAT107"})
CREATE (p1)-[:ANSVARLIG]->(e1);
MATCH (p1:Foreleser {fornavn: "Lars-Petter"}), (e1:Emne {kode: "DAT100"})
CREATE (p1)-[:ANSVARLIG]->(e1);

// Opprett STUDERER-relasjon
MATCH (s:Student {fornavn: "Ola"}), (e1:Emne {kode: "DAT100"})
CREATE (s)-[:STUDERER]->(e1);
MATCH (s2:Student {fornavn: "Kari"}), (e1:Emne {kode: "DAT100"})
CREATE (s2)-[:STUDERER]->(e1);
MATCH (s3:Student {fornavn: "Nils"}), (e1:Emne {kode: "DAT107"})
CREATE (s3)-[:STUDERER]->(e1);
MATCH (s4:Student {fornavn: "Eva"}), (e1:Emne {kode: "DAT107"})
CREATE (s4)-[:STUDERER]->(e1);

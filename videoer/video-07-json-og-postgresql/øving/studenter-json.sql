-- ---------------------------------------------
-- Datatype: Create schema and set search path
-- ---------------------------------------------
CREATE SCHEMA if not exists video07;
SET search_path = video07;

-- ---------------------------------------------
-- Datatype: JSONB
-- ---------------------------------------------
drop table if exists studenter;
CREATE TABLE studenter (
  student_id integer,
  student_data jsonb NOT NULL,
  PRIMARY KEY (student_id)
);

select * from studenter;
-- ---------------------------------------------
-- Insert data
-- ---------------------------------------------
INSERT INTO studenter (student_id, student_data)
   VALUES
   (101, '{"fornavn": "Ola",
            "etternavn": "Nordmann",
            "studiestart": { "semester": "H", "år": 2023 },
            "studieprogram": "Datateknologi",
            "emner": [
               {"kode": "DAT100", "poeng": 86},
               {"kode": "MAT101", "poeng": 92},
               {"kode": "ING100", "poeng": 77},
               {"kode": "DAT111", "poeng": 81}
            ]
         }'),
   (202, '{"fornavn": "Kari",
            "etternavn": "Kylling",
            "studiestart": { "semester": "H", "år": 2023 },
            "studieprogram": "Datateknologi",
            "emner": [
               {"kode": "DAT100", "poeng": 59},
               {"kode": "MAT101", "poeng": 82},
               {"kode": "ING100", "poeng": 84},
               {"kode": "DAT111", "poeng": 74}
            ]
         }'),
   (303, '{"fornavn": "Nils",
            "etternavn": "Nilsen",
            "studiestart": { "semester": "H", "år": 2022 },
            "studieprogram": "Datateknologi",
            "emner": [
               {"kode": "DAT100", "poeng": 95},
               {"kode": "MAT101", "poeng": 92},
               {"kode": "ING100", "poeng": 89},
               {"kode": "DAT111", "poeng": 96},
               {"kode": "DAT152", "poeng": 91},
               {"kode": "DAT156", "poeng": 82},
               {"kode": "DAT109", "poeng": 71}
            ]
         }');

commit;

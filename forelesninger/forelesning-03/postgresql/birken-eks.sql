SET search_path = video06;
-- =====================================================
-- XML-GENERERING I POSTGRESQL: EKSEMPLER
-- =====================================================
select * from pulje where p_id=1;
select * from deltaker;
-- =====================================================
-- EKSEMPEL 1: Generer enkel XML for én pulje
-- =====================================================
SELECT xmlelement(
             NAME pulje,
             xmlattributes(x.p_id AS "pId", x.start_tid AS "startTid")
       ) AS pulje_xml
FROM pulje x
WHERE x.p_id = 1;

-- =====================================================
-- EKSEMPEL 2: Generer XML-listen med alle puljer
-- =====================================================
SELECT xmlelement(
             NAME puljer,
             xmlagg(
                   xmlelement(
                         NAME pulje,
                         xmlattributes(p_id AS "pId", start_tid AS "startTid")
                   )
                      ORDER BY p_id
             )
       ) AS puljer_xml
FROM pulje;

-- =====================================================
-- EKSEMPEL 3: Generer enkel XML for én deltaker
-- =====================================================
SELECT xmlelement(
             NAME deltaker,
             xmlforest(
                   d.id,
                   d.navn,
                   d.fdato,
                   d.fnr,
                   d.medlem,
                   d.poeng,
                   d.hjemmeside,
                   d.pulje_id AS "puljeId",
                   d.foresatt_id AS "foresattId"
             )
       ) AS deltaker_xml
FROM deltaker d
WHERE id = 'h0001';

-- Det samme med id som attributt:
SELECT xmlelement(
             NAME deltaker,
             xmlattributes(id as "id"),
             xmlforest(
                   navn,
                   fdato,
                   fnr,
                   medlem,
                   poeng,
                   hjemmeside,
                   pulje_id AS "puljeId",
                   foresatt_id AS "foresattId"
             )
       ) AS deltaker_xml
FROM deltaker
WHERE id = 'h0001';

-- =====================================================
-- EKSEMPEL 4: Generer XML-liste med alle deltakere
-- =====================================================
SELECT xmlelement(
             NAME deltakere,
             xmlagg(
                   xmlelement(
                         NAME deltaker,
                         xmlforest(
                               id,
                               navn,
                               fdato,
                               fnr,
                               medlem,
                               poeng,
                               hjemmeside,
                               pulje_id AS "puljeId",
                               foresatt_id AS "foresattId"
                         )
                   )
                      ORDER BY id
             )
       ) AS deltakere_xml
FROM deltaker;

-- =====================================================
-- EKSEMPEL 5: Generer XML med bare aktive medlemmer
-- =====================================================
SELECT xmlelement(
             NAME medlemmer,
             xmlagg(
                   xmlelement(
                         NAME deltaker,
                         xmlattributes(id AS "id"),
                         xmlforest(navn, poeng)
                   )
                      ORDER BY poeng DESC
             )
       ) AS medlemmer_xml
FROM deltaker
WHERE medlem = TRUE;

-- =====================================================
-- EKSEMPEL 6: Generer XML for alle puljer med deltakere
-- =====================================================
SELECT xmlelement(
             NAME puljer,
             xmlagg(
                   xmlelement(
                         NAME pulje,
                         xmlattributes(p.p_id AS "pId", p.start_tid AS "startTid"),
                         (
                            SELECT xmlelement(
                                         NAME deltakere,
                                         xmlagg(
                                               xmlelement(
                                                     NAME deltaker,
                                                     xmlattributes(d.id AS "id"),
                                                     xmlforest(d.navn, d.poeng, d.medlem)
                                               )
                                                  ORDER BY d.id
                                         )
                                   )
                            FROM deltaker d
                            WHERE d.pulje_id = p.p_id
                         )
                   )
                      ORDER BY p.p_id
             )
       ) AS puljer_med_deltakere_xml
FROM pulje p;

-- =====================================================
-- EKSEMPEL 7: Generer komplett birken-dokument (puljer + deltakere)
-- =====================================================
SELECT
   xmlelement(
      NAME birken,
      (
         SELECT
            xmlelement(
               NAME puljer,
               xmlagg(
                  xmlelement(
                     NAME pulje,
                     xmlattributes(p_id AS "pId", start_tid AS "startTid")
                  ) ORDER BY p_id
               )
            )
         FROM pulje
      ),
      (
         SELECT
            xmlagg(
               xmlelement(
                  NAME person,
                  xmlforest(id,navn,fdato,fnr),
                  CASE WHEN medlem = true THEN xmlelement(NAME medlem) END,
                  xmlforest(poeng,hjemmeside, pulje_id AS "puljeId", foresatt_id AS "foresattId"
                  )
               ) ORDER BY id
            )
         FROM deltaker
      )
   ) AS birken_xml;

-- =====================================================
-- JSON-GENERERING I POSTGRESQL: EKSEMPLER
-- =====================================================

-- =====================================================
-- EKSEMPEL 9: Generer enkel JSON for én pulje
-- =====================================================
SELECT jsonb_build_object(
  'pId', p_id,
  'startTid', start_tid
) AS pulje_json
FROM pulje
WHERE p_id = 1;

-- =====================================================
-- EKSEMPEL 10: Generer JSON-array med alle puljer
-- =====================================================
SELECT jsonb_build_object(
  'puljer', jsonb_agg(
    jsonb_build_object(
      'pId', p_id,
      'startTid', start_tid
    )
    ORDER BY p_id
  )
) AS puljer_json
FROM pulje;

SELECT jsonb_agg(
            jsonb_build_object(
                  'pId', p_id,
                  'startTid', start_tid
            )
            ORDER BY p_id
      )
       AS puljer_json
FROM pulje;

-- =====================================================
-- EKSEMPEL 11: Generer enkel JSON for én deltaker
-- =====================================================
SELECT jsonb_build_object(
  'id', d.id,
  'navn', d.navn,
  'fdato', fdato,
  'fnr', fnr,
  'medlem', medlem,
  'poeng', poeng,
  'hjemmeside', hjemmeside,
  'puljeId', pulje_id,
  'foresattId', foresatt_id
) AS deltaker_json
FROM deltaker d
WHERE id = 'h0001';

-- =====================================================
-- EKSEMPEL 12: Generer JSON-array med alle deltakere
-- =====================================================
SELECT jsonb_build_object(
  'deltakere', jsonb_agg(
    jsonb_build_object(
      'id', id,
      'navn', navn,
      'fdato', fdato,
      'fnr', fnr,
      'medlem', medlem,
      'poeng', poeng,
      'hjemmeside', hjemmeside,
      'puljeId', pulje_id,
      'foresattId', foresatt_id
    )
    ORDER BY id
  )
) AS deltakere_json
FROM deltaker;

-- =====================================================
-- EKSEMPEL 13: Generer JSON med bare aktive medlemmer
-- =====================================================
SELECT jsonb_build_object(
  'medlemmer', jsonb_agg(
    jsonb_build_object(
      'id', id,
      'navn', navn,
      'poeng', poeng
    )
    ORDER BY poeng DESC
  )
) AS medlemmer_json
FROM deltaker
WHERE medlem = TRUE;

-- =====================================================
-- EKSEMPEL 14: Generer JSON for alle puljer med deltakere
-- =====================================================
SELECT jsonb_build_object(
  'puljer', jsonb_agg(
    jsonb_build_object(
      'pId', p.p_id,
      'startTid', p.start_tid,
      'deltakere', (
        SELECT jsonb_agg(
          jsonb_build_object(
            'id', d.id,
            'navn', d.navn,
            'poeng', d.poeng,
            'medlem', d.medlem
          )
          ORDER BY d.id
        )
        FROM deltaker d
        WHERE d.pulje_id = p.p_id
      )
    )
    ORDER BY p.p_id
  )
) AS puljer_med_deltakere_json
FROM pulje p;

-- =====================================================
-- EKSEMPEL 15: Generer komplett birken-dokument (puljer + deltakere)
-- =====================================================
SELECT jsonb_build_object(
    'puljer', (
      SELECT jsonb_agg(
        jsonb_build_object(
          'pId', p_id,
          'startTid', start_tid
        )
        ORDER BY p_id
      )
      FROM pulje
    ),
    'personer', (
      SELECT jsonb_agg(
        jsonb_build_object(
          'id', id,
          'navn', navn,
          'fdato', fdato,
          'fnr', fnr,
          'medlem', medlem,
          'poeng', poeng,
          'hjemmeside', hjemmeside,
          'puljeId', pulje_id,
          'foresattId', foresatt_id
        )
        ORDER BY id
      )
      FROM deltaker
    )
) AS birken_json;

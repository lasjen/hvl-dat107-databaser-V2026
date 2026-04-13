-- =====================================================
-- Schema and setup
-- =====================================================
CREATE SCHEMA if not exists video06;
SET search_path = video06;

    -- Rerun-friendly cleanup
DROP TABLE IF EXISTS deltaker;
DROP TABLE IF EXISTS pulje;

-- =====================================================
-- Table: pulje
-- =====================================================
CREATE TABLE pulje (
  pId       INTEGER,
  startTid  TIMESTAMP,
  CONSTRAINT pulje_pk PRIMARY KEY (pId)
);

-- =====================================================
-- Table: deltaker
-- =====================================================
CREATE TABLE deltaker (
  id VARCHAR(10),
  puljeId INTEGER,
  xml_info  XML,
  CONSTRAINT deltaker_pk PRIMARY KEY (id),
  CONSTRAINT deltaker_pulje_fk FOREIGN KEY (puljeId) REFERENCES pulje(pId)
);

-- =====================================================
-- Insert data: pulje
-- =====================================================
INSERT INTO pulje (pId, startTid)
VALUES
  (1, '2026-03-15T08:00:00'),
  (2, '2026-03-15T08:30:00'),
  (3, '2026-03-15T09:00:00'),
  (4, '2026-03-15T09:30:00'),
  (5, '2026-03-15T10:00:00');

-- =====================================================
-- Insert data: deltaker
-- =====================================================
INSERT INTO deltaker (id, puljeId, xml_info)
VALUES
  ('h0001', 1, '<deltaker lisens="helårs"><navn>Lasse Jenssen</navn><fdato>1983-05-12</fdato><fnr>12058348217</fnr><poeng>1200.01</poeng><hjemmeside>https://www.jcon.no/blog</hjemmeside></deltaker>'),
  ('h0002', 1, '<deltaker lisens="enkel"><navn>Ola Hansen</navn><fdato>1975-03-00</fdato><medlem/><poeng>4405.21</poeng><hjemmeside>www.olahansen.no</hjemmeside></deltaker>'),
  ('d0005', 1, '<deltaker lisens="ikke registrert"><navn>Norah Jenssen</navn><fdato>2012-12-02</fdato><fnr>02121250683</fnr><poeng>621.23</poeng><hjemmeside>https://www.jenssen.no/nora</hjemmeside><foresattId>h0001</foresattId></deltaker>'),
  ('h0003', 1, '<deltaker lisens="helårs"><navn>Jonas Berg</navn><fdato>1988-01-14</fdato><fnr>14018883725</fnr><medlem/><poeng>980.12</poeng><hjemmeside>https://example.com/jonas-berg</hjemmeside></deltaker>'),
  ('h0004', 1, '<deltaker lisens="enkel"><navn>Mats Lunde</navn><fdato>1990-04-21</fdato><fnr>21049019357</fnr><poeng>765.33</poeng><hjemmeside>https://example.com/mats-lunde</hjemmeside></deltaker>'),
  ('h0005', 1, '<deltaker lisens="ikke registrert"><navn>Thomas Engen</navn><fdato>1988-05-03</fdato><fnr>03058862491</fnr><medlem/><poeng>905.20</poeng><hjemmeside>https://example.com/thomas-engen</hjemmeside></deltaker>'),
  ('h0006', 1, '<deltaker lisens="helårs"><navn>Henrik Aas</navn><fdato>1982-11-05</fdato><fnr>05118228530</fnr><medlem/><poeng>1105.44</poeng><hjemmeside>https://example.com/henrik-aas</hjemmeside></deltaker>'),
  ('h0007', 1, '<deltaker lisens="enkel"><navn>Anders Lie</navn><fdato>1971-09-18</fdato><fnr>18097959372</fnr><poeng>845.67</poeng><hjemmeside>https://example.com/anders-lie</hjemmeside></deltaker>'),
  ('h0008', 1, '<deltaker lisens="ikke registrert"><navn>Kristoffer Lie</navn><fdato>1995-02-10</fdato><fnr>10029528463</fnr><medlem/><poeng>930.22</poeng><hjemmeside>https://example.com/kristoffer-moe</hjemmeside><foresattId>h0007</foresattId></deltaker>'),
  ('h0009', 1, '<deltaker lisens="helårs"><navn>Sindre Johansen</navn><fdato>1986-07-29</fdato><fnr>29078613504</fnr><medlem/><poeng>1010.50</poeng><hjemmeside>https://example.com/sindre-johansen</hjemmeside></deltaker>'),
  ('h0010', 1, '<deltaker lisens="enkel"><navn>Emil Røed</navn><fdato>1992-03-12</fdato><fnr>12039202758</fnr><poeng>720.84</poeng><hjemmeside>https://example.com/emil-rod</hjemmeside></deltaker>'),
  ('h0011', 1, '<deltaker lisens="ikke registrert"><navn>Vetle Skaar</navn><fdato>1984-05-22</fdato><fnr>22058455370</fnr><medlem/><poeng>990.77</poeng><hjemmeside>https://example.com/vetle-skaar</hjemmeside></deltaker>'),
  ('h0012', 1, '<deltaker lisens="helårs"><navn>Trym Eide</navn><fdato>1981-10-09</fdato><fnr>09108118065</fnr><poeng>800.12</poeng><hjemmeside>https://example.com/trym-eide</hjemmeside></deltaker>'),
  ('h0013', 1, '<deltaker lisens="enkel"><navn>Leif Knutsen</navn><fdato>1977-08-16</fdato><fnr>16087720793</fnr><medlem/><poeng>1055.66</poeng><hjemmeside>https://example.com/leif-knutsen</hjemmeside></deltaker>'),
  ('h0014', 1, '<deltaker lisens="ikke registrert"><navn>Petter Dahl</navn><fdato>1993-06-03</fdato><fnr>03069396218</fnr><poeng>760.42</poeng><hjemmeside>https://example.com/petter-dahl</hjemmeside></deltaker>'),
  ('h0015', 1, '<deltaker lisens="helårs"><navn>Jørgen Hauge</navn><fdato>1989-12-24</fdato><fnr>24128953601</fnr><medlem/><poeng>1005.90</poeng><hjemmeside>https://example.com/jorgen-hauge</hjemmeside></deltaker>'),
  ('h0016', 1, '<deltaker lisens="enkel"><navn>Eirik Tangen</navn><fdato>1987-02-27</fdato><fnr>27028704215</fnr><poeng>835.13</poeng><hjemmeside>https://example.com/eirik-tangen</hjemmeside></deltaker>'),
  ('h0017', 1, '<deltaker lisens="ikke registrert"><navn>Sigurd Vik</navn><fdato>1980-01-30</fdato><fnr>30018075624</fnr><medlem/><poeng>1120.88</poeng><hjemmeside>https://example.com/sigurd-vik</hjemmeside></deltaker>'),
  ('h0018', 1, '<deltaker lisens="helårs"><navn>Filip Nymoen</navn><fdato>1996-09-11</fdato><fnr>11099669458</fnr><poeng>745.25</poeng><hjemmeside>https://example.com/filip-nymoen</hjemmeside></deltaker>'),
  ('h0019', 1, '<deltaker lisens="enkel"><navn>Ulrik Foss</navn><fdato>1978-04-07</fdato><fnr>07047848516</fnr><medlem/><poeng>990.31</poeng><hjemmeside>https://example.com/ulrik-foss</hjemmeside></deltaker>'),
  ('h0020', 1, '<deltaker lisens="ikke registrert"><navn>Ruben Sand</navn><fdato>1991-11-19</fdato><fnr>19119119832</fnr><poeng>780.64</poeng><hjemmeside>https://example.com/ruben-sand</hjemmeside></deltaker>'),
  ('h0021', 1, '<deltaker lisens="helårs"><navn>Kristian Lund</navn><fdato>1985-03-23</fdato><fnr>23038576014</fnr><medlem/><poeng>1025.47</poeng><hjemmeside>https://example.com/kristian-lund</hjemmeside></deltaker>'),
  ('h0022', 1, '<deltaker lisens="enkel"><navn>Kenneth Myhre</navn><fdato>1983-07-02</fdato><fnr>02078316275</fnr><poeng>850.76</poeng><hjemmeside>https://example.com/kenneth-myhre</hjemmeside></deltaker>'),
  ('d0006', 1, '<deltaker lisens="ikke registrert"><navn>Marie Solberg</navn><fdato>1994-02-08</fdato><fnr>08029472613</fnr><medlem/><poeng>970.33</poeng><hjemmeside>https://example.com/marie-solberg</hjemmeside></deltaker>'),
  ('d0007', 1, '<deltaker lisens="helårs"><navn>Silje Haug</navn><fdato>1990-10-15</fdato><fnr>15109001349</fnr><poeng>720.22</poeng><hjemmeside>https://example.com/silje-haug</hjemmeside></deltaker>'),
  ('d0008', 1, '<deltaker lisens="enkel"><navn>Line Karlsen</navn><fdato>1988-06-19</fdato><fnr>19068885403</fnr><medlem/><poeng>990.55</poeng><hjemmeside>https://example.com/line-karlsen</hjemmeside></deltaker>'),
  ('d0009', 1, '<deltaker lisens="ikke registrert"><navn>Nora Vik</navn><fdato>1975-11-30</fdato><fnr>30119551327</fnr><poeng>740.68</poeng><hjemmeside>https://example.com/nora-vik</hjemmeside></deltaker>'),
  ('d0010', 1, '<deltaker lisens="helårs"><navn>Tuva Nilsen</navn><fdato>1998-01-05</fdato><fnr>05019213598</fnr><medlem/><poeng>950.10</poeng><hjemmeside>https://example.com/tuva-nilsen</hjemmeside><foresattId>d0009</foresattId></deltaker>'),
  ('d0011', 1, '<deltaker lisens="enkel"><navn>Camilla Andersen</navn><fdato>1987-03-28</fdato><fnr>28038760941</fnr><poeng>760.91</poeng><hjemmeside>https://example.com/camilla-andersen</hjemmeside></deltaker>'),
  ('d0012', 1, '<deltaker lisens="ikke registrert"><navn>Ida Berg</navn><fdato>1991-04-17</fdato><fnr>17049174162</fnr><medlem/><poeng>980.44</poeng><hjemmeside>https://example.com/ida-berg</hjemmeside></deltaker>'),
  ('d0013', 1, '<deltaker lisens="helårs"><navn>Emilie Larsen</navn><fdato>1996-07-22</fdato><fnr>22079680435</fnr><poeng>740.21</poeng><hjemmeside>https://example.com/emilie-larsen</hjemmeside></deltaker>'),
  ('d0014', 1, '<deltaker lisens="enkel"><navn>Ragnhild Myklebust</navn><fdato>1983-08-11</fdato><fnr>11088343890</fnr><medlem/><poeng>1015.32</poeng><hjemmeside>https://example.com/ragnhild-myklebust</hjemmeside></deltaker>'),
  ('d0015', 1, '<deltaker lisens="ikke registrert"><navn>Sara Holte</navn><fdato>1989-09-09</fdato><fnr>09098938157</fnr><poeng>780.70</poeng><hjemmeside>https://example.com/sara-holte</hjemmeside></deltaker>'),
  ('d0016', 1, '<deltaker lisens="helårs"><navn>Helene Østby</navn><fdato>1985-12-13</fdato><fnr>13128526740</fnr><medlem/><poeng>995.88</poeng><hjemmeside>https://example.com/helene-ostby</hjemmeside></deltaker>'),
  ('d0017', 1, '<deltaker lisens="enkel"><navn>Frida Sunde</navn><fdato>1993-02-02</fdato><fnr>02029314965</fnr><poeng>760.10</poeng><hjemmeside>https://example.com/frida-sunde</hjemmeside></deltaker>'),
  ('d0018', 1, '<deltaker lisens="ikke registrert"><navn>Karoline Fladmark</navn><fdato>1987-06-25</fdato><fnr>25068735219</fnr><medlem/><poeng>985.11</poeng><hjemmeside>https://example.com/karoline-fladmark</hjemmeside></deltaker>'),
  ('d0019', 1, '<deltaker lisens="helårs"><navn>Hanna Rønning</navn><fdato>1997-05-04</fdato><fnr>04059747036</fnr><poeng>735.44</poeng><hjemmeside>https://example.com/hanna-ronning</hjemmeside></deltaker>'),
  ('d0020', 1, '<deltaker lisens="enkel"><navn>Vilde Andreassen</navn><fdato>1990-03-01</fdato><fnr>01039090671</fnr><medlem/><poeng>1000.12</poeng><hjemmeside>https://example.com/vilde-andreassen</hjemmeside></deltaker>'),
  ('d0021', 1, '<deltaker lisens="ikke registrert"><navn>Emma Bråthen</navn><fdato>1994-11-07</fdato><fnr>07119470825</fnr><poeng>750.33</poeng><hjemmeside>https://example.com/emma-brathen</hjemmeside></deltaker>'),
  ('d0022', 1, '<deltaker lisens="helårs"><navn>Kristine Haugen</navn><fdato>1986-08-18</fdato><fnr>18088643910</fnr><medlem/><poeng>995.44</poeng><hjemmeside>https://example.com/kristine-haugen</hjemmeside></deltaker>'),
  ('d0023', 1, '<deltaker lisens="enkel"><navn>Julie Storm</navn><fdato>1992-09-29</fdato><fnr>29099287613</fnr><poeng>770.80</poeng><hjemmeside>https://example.com/julie-storm</hjemmeside></deltaker>'),
  ('d0024', 1, '<deltaker lisens="ikke registrert"><navn>Malin Thorsen</navn><fdato>1995-01-16</fdato><fnr>16019501973</fnr><medlem/><poeng>960.12</poeng><hjemmeside>https://example.com/malin-thorsen</hjemmeside></deltaker>'),
  ('d0025', 1, '<deltaker lisens="helårs"><navn>Andrea Olsen</navn><fdato>1998-10-10</fdato><fnr>10109815602</fnr><poeng>740.22</poeng><hjemmeside>https://example.com/andrea-olsen</hjemmeside></deltaker>');

-- Fordel deltakere jevnt mellom puljer basert pa poeng.
-- Hoyest poengsum havner i laveste puljeId.
WITH scored AS (
  SELECT
    id,
    ((xpath('//poeng/text()', xml_info))[1]::text)::numeric AS poeng
  FROM deltaker
), assigned AS (
  SELECT
    id,
    ntile(5) OVER (ORDER BY poeng DESC, id) AS ny_pulje
  FROM scored
)
UPDATE deltaker d
SET puljeId = a.ny_pulje
FROM assigned a
WHERE d.id = a.id;

COMMIT;

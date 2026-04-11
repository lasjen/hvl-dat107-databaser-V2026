-- ---------------------------------------------
-- Datatype: Create schema and set search path
-- ---------------------------------------------
CREATE SCHEMA if not exists video06;
SET search_path = video06;

-- ---------------------------------------------
-- Datatype: XML
-- ---------------------------------------------
CREATE TABLE studenter (
  student_no INTEGER,
  xml_info   XML,
  CONSTRAINT studenter_pk PRIMARY KEY (student_no)
);

-- ---------------------------------------------
-- Insert data
-- ---------------------------------------------
INSERT INTO studenter (student_no, xml_info)
VALUES
   (101, '<student>
      <fornavn>Ola</fornavn>
      <etternavn>Nordmann</etternavn>
      <emner>
         <emne><kode>DAT100</kode><poeng>86</poeng></emne>
         <emne><kode>MAT101</kode><poeng>92</poeng></emne>
         <emne><kode>ING100</kode><poeng>77</poeng></emne>
         <emne><kode>DAT111</kode><poeng>81</poeng></emne>
      </emner>
   </student>'),
   (202, '<student>
      <fornavn>Kari</fornavn>
      <etternavn>Kylling</etternavn>
      <emner>
         <emne><kode>DAT100</kode><poeng>59</poeng></emne>
         <emne><kode>MAT101</kode><poeng>82</poeng></emne>
         <emne><kode>ING100</kode><poeng>84</poeng></emne>
         <emne><kode>DAT111</kode><poeng>74</poeng></emne>
      </emner>
   </student>'),
   (303, '<student>
      <fornavn>Nils</fornavn>
      <etternavn>Nilsen</etternavn>
      <emner>
         <emne><kode>DAT100</kode><poeng>95</poeng></emne>
         <emne><kode>MAT101</kode><poeng>92</poeng></emne>
         <emne><kode>ING100</kode><poeng>89</poeng></emne>
         <emne><kode>DAT111</kode><poeng>96</poeng></emne>
      </emner>
   </student>');

commit;

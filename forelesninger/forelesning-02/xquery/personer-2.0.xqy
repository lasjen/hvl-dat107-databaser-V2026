xquery version "1.0";

(: XQuery med XPath 2.0 funksjonalitet :)

let $doc := doc("personer.xml")

return
<resultat>
  <seksjon tittel="1. Sortering med order by (XPath 2.0)">
  <beskrivelse>Sorterer personer etter etternavn</beskrivelse>
    {
      for $person in $doc//person
      order by $person/etternavn
      return <person>{concat($person/fornavn/text(), " ", $person/etternavn/text())}</person>
    }
  </seksjon>

  <seksjon tittel="2. Bruk av name() funksjon for alle elementer">
  <beskrivelse>Henter navn på alle unike element-typer</beskrivelse>
    {
      for $name in distinct-values($doc//person/*/name())
      order by $name
      return <element>{$name}</element>
    }
  </seksjon>

  <seksjon tittel="3. String funksjoner (XPath 2.0)">
  <beskrivelse>Upper-case etternavn og lower-case fornavn</beskrivelse>
    {
      for $person in $doc//person[position() <= 3]
      return <person>
        <fornavn>{lower-case($person/fornavn)}</fornavn>
        <etternavn>{upper-case($person/etternavn)}</etternavn>
      </person>
    }
  </seksjon>

  <seksjon tittel="4. Regex matching (XPath 2.0)">
  <beskrivelse>Finn personer med navn som inneholder 'er'</beskrivelse>
    {
      for $person in $doc//person
      where matches($person/etternavn, "er", "i")
      return <person>{concat($person/fornavn/text(), " ", $person/etternavn/text())}</person>
    }
  </seksjon>

  <seksjon tittel="5. Dato-beregninger (XPath 2.0)">
    <beskrivelse>Finn personer født på 1980-tallet</beskrivelse>
    {
      for $person in $doc//person
      let $aar := year-from-date(xs:date($person/fodselsdato))
      where $aar >= 1980 and $aar <= 1989
      order by $person/fodselsdato
      return <person>
        <navn>{concat($person/fornavn/text(), " ", $person/etternavn/text())}</navn>
        <fodselsdato>{$person/fodselsdato/text()}</fodselsdato>
        <aar>{$aar}</aar>
      </person>
    }
  </seksjon>

  <seksjon tittel="6. Aggregering med statistikk">
    <beskrivelse>Statistikk over antall barn</beskrivelse>
    <totalt-personer>{count($doc//person)}</totalt-personer>
    <personer-med-barn>{count($doc//person[barn])}</personer-med-barn>
    <totalt-barn>{sum($doc//person/barn)}</totalt-barn>
    <gjennomsnitt-barn>{avg($doc//person/barn)}</gjennomsnitt-barn>
    <max-barn>{max($doc//person/barn)}</max-barn>
  </seksjon>

  <seksjon tittel="7. Conditional expressions (if-then-else)">
    <beskrivelse>Kategoriser personer etter alder</beskrivelse>
    {
      for $person in $doc//person
      let $aar := year-from-date(xs:date($person/fodselsdato))
      let $alder := 2026 - $aar
      let $kategori := if ($alder < 30) then "Ung"
                       else if ($alder < 40) then "Middelaldrende"
                       else "Senior"
      order by $person/fodselsdato descending
      return <person>
        <navn>{concat($person/fornavn/text(), " ", $person/etternavn/text())}</navn>
        <alder>{$alder}</alder>
        <kategori>{$kategori}</kategori>
      </person>
    }
  </seksjon>

  <seksjon tittel="8. Sekvens operasjoner">
    <beskrivelse>Arbeide med sekvenser og ranges</beskrivelse>
    <range>{1 to 5}</range>
    <eksempel-navn>{subsequence($doc//person/fornavn, 1, 3)}</eksempel-navn>
    <reversed>{reverse($doc//person[position() <= 3]/fornavn)}</reversed>
  </seksjon>

  <seksjon tittel="9. String-join med separator">
    <beskrivelse>Alle fornavn separert med komma</beskrivelse>
    <alle-fornavn>{string-join($doc//person/fornavn, ", ")}</alle-fornavn>
  </seksjon>

  <seksjon tittel="10. Tokenize (regex splitting)">
    <beskrivelse>Split fødselsdato i komponenter</beskrivelse>
    {
      let $person := $doc//person[1]
      let $tokens := tokenize($person/fodselsdato, "-")
      return <dato>
        <original>{$person/fodselsdato/text()}</original>
        <aar>{$tokens[1]}</aar>
        <maaned>{$tokens[2]}</maaned>
        <dag>{$tokens[3]}</dag>
      </dato>
    }
  </seksjon>
  <seksjon tittel="11. Processing-Instructions">
      <beskrivelse>Henter P-I av typen xml-stylesheet</beskrivelse>
      {
        let $pi := $doc/processing-instruction("xml-stylesheet")
        return $pi
      }
    </seksjon>
</resultat>


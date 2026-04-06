# XPath Eksempler for Birken Påmelding
Dette dokumentet inneholder XPath-eksempler fra enkle til avanserte for å søke i `birken-paamelding.xml`.
**Tips:** Klikk på "Vis løsning" for å se svaret på hver oppgave.
---
## Grunnleggende XPath (Lett)
### Oppgave 1: Finn alle personer
**Oppgave:** Finn alle `<person>` elementer i dokumentet.
<details>
<summary>Vis løsning(er)</summary>
//person <br>
/birken/person
</details>

### Oppgave 2: Finn alle puljer
**Oppgave:** Finn alle `<pulje>` elementer.
<details>
<summary>Vis løsning(er)</summary>

//pulje <br>
/birken/puljer/pulje
</details>

### Oppgave 3: Finn alle navn
**Oppgave:** Finn alle `<navn>` elementer for alle personer.
<details>
<summary>Vis løsning(er)</summary>

//person/navn <br>

/birken/person/navn

</details>

### Oppgave 4: Finn informasjon om puljer
**Oppgave:** Finn alle informasjon om de ulike puljene.
<details>
<summary>Vis løsning(er)</summary>

/birken/puljer/pulje

</details>

## Posisjon og Rekkefølge (Lett til Middels)
### Oppgave 5: Finn første person
**Oppgave:** Finn den første påmeldte personen i dokumentet.
<details>
<summary>Vis løsning(er)</summary>
//person[1] <br>
Alternativt: <br>
//person[position()=1] 
</details>

### Oppgave 6: Finn de 5 første personene
**Oppgave:** Finn de 5 første påmeldte personene.
<details>
<summary>Vis løsning(er)</summary>
//person[position() <= 5]
</details>

### Oppgave 7: Finn siste person
**Oppgave:** Finn den siste påmeldte personen.
<details>
<summary>Vis løsning(er)</summary>
//person[last()]
</details>

### Oppgave 8: Finn de tre siste personene
**Oppgave:** Finn de tre siste påmeldte personene.
<details>
<summary>Vis løsning(er)</summary>
//person[position() > last() - 3]<br>
Alternativt:<br>
//person[last()-2] | //person[last()-1] | //person[last()]
</details>

## Attributter (Middels)
### Oppgave 9: Finn alle puljer med deres pId
**Oppgave:** Finn alle `<pulje>` elementer som har et `pId` attributt.
<details>
<summary>Vis løsning(er)</summary>
//pulje[@pId]
</details>

### Oppgave 10: Finn pulje med spesifikk pId
**Oppgave:** Finn puljen med `pId="3"`.
<details>
<summary>Vis løsning(er)</summary>
//pulje[@pId="3"]
</details>

### Oppgave 11: Finn startTid for pulje 2
**Oppgave:** Finn `startTid` attributtet for puljen med `pId="2"`.
<details>
<summary>Vis løsning(er)</summary>
//pulje[@pId="2"]/@startTid
</details>

## Filtrering på Verdier (Middels)
### Oppgave 12: Finn alle medlemmer
**Oppgave:** Finn alle personer hvor `<medlem>` er `true`.
<details>
<summary>Vis løsning(er)</summary>
//person[medlem='true']
</details>

### Oppgave 13: Finn alle med foresatt
**Oppgave:** Finn alle personer som har relasjon til foresatt deltaker.
<details>
<summary>Vis løsning(er)</summary>
<i>Tips! Her er det nok å sjekke at <person> elementet har et under element <foresattId>.</i><br>
//person[foresattId]
</details>

### Oppgave 14: Finn personer i pulje 1
**Oppgave:** Finn alle personer som tilhører pulje 1.
<details>
<summary>Vis løsning(er)</summary>
//person[puljeId='1']
</details>

### Oppgave 15: Finn personer født i 1990-årene
**Oppgave:** Finn alle personer født mellom 1990 og 1999.
<details>
<summary>Tips: </summary>
<i>- Bruk "start-with(string, prefix)" funksjonen for å sjekke om fødselsdatoen starter med "199".</i>
</details>
<details>
<summary>Vis løsning(er)</summary>
//person[starts-with(fdato, '199')]
</details>

## Sammenligning og Logiske Operatorer (Middels)
### Oppgave 16: Finn personer med mer enn 1000 poeng
**Oppgave:** Finn alle personer med `<poeng>` større enn 1000.
<details>
<summary>Vis løsning(er)</summary>
//person[poeng > 1000]
</details>

### Oppgave 17: Finn personer med mellom 700 og 900 poeng
**Oppgave:** Finn alle personer med poeng mellom 700 og 900 (inklusiv).
<details>
<summary>Vis løsning(er)</summary>
//person[poeng >= 700 and poeng <= 900]
</details>

### Oppgave 18: Finn medlemmer med mer enn 1000 poeng
**Oppgave:** Finn alle personer som er medlemmer OG har mer enn 1000 poeng.
<details>
<summary>Vis løsning(er)</summary>
//person[medlem='true' and poeng > 1000]
</details>

### Oppgave 19: Finn personer i pulje 1 eller pulje 2
**Oppgave:** Finn alle personer som tilhører pulje 1 eller pulje 2.
<details>
<summary>Vis løsning(er)</summary>
//person[puljeId='1' or puljeId='2']
</details>

## Tekstsøk (Middels)
### Oppgave 20: Finn personer med "Jensen" i navnet
**Oppgave:** Finn alle personer hvis navn inneholder "ens".
<details>
<summary>Vis løsning(er)</summary>
//person[contains(navn, 'ens')]
</details>

### Oppgave 21: Finn personer med navn som starter med "M"
**Oppgave:** Finn alle personer hvis navn starter med bokstaven "M".
<details>
<summary>Vis løsning(er)</summary>
//person[starts-with(navn, 'M')] <br>
//person[navn[starts-with(., 'M')]]
</details>

### Oppgave 22: Finn personer med "example.com" i hjemmeside
**Oppgave:** Finn alle personer med "example.com" i `<hjemmeside>`.
<details>
<summary>Vis løsning(er)</summary>
//person[contains(hjemmeside, 'example.com')]
</details>

## ID og Referanser (Middels til Avansert)
### Oppgave 23: Finn alle herreklassen (h-id)
**Oppgave:** Finn navnet (og kun navnet) på alle personer med id som starter med "h" (dvs. alle Herre deltagere).
<details>
<summary>Vis løsning(er)</summary>
//person[starts-with(id, 'h')]/navn/text()
</details>

### Oppgave 24: Finn alle dameklassen (d-id)
**Oppgave:** Finn alle personer med id som starter med "d" (dvs. alle Dame deltagere).
<details>
<summary>Vis løsning(er)</summary>
//person[starts-with(id, 'd')]
</details>

### Oppgave 25: Finn person med spesifikk id
**Oppgave:** Finn personen med id "h0001".
<details>
<summary>Vis løsning(er)</summary>
//person[id='h0001']
</details>

### Oppgave 26: Finn alle barn (personer med foresattId)
**Oppgave:** Finn alle personer som har et `<foresattId>` element (barn under 16 år).
<details>
<summary>Vis løsning(er)</summary>
//person[foresattId]
</details>

### Oppgave 27: Finn alle voksne (personer uten foresattId)
**Oppgave:** Finn alle personer som IKKE har et `<foresattId>` element.
<details>
<summary>Vis løsning(er)</summary>
//person[not(foresattId)]
</details>

### Oppgave 28: Finn barn av en spesifikk foresatt
**Oppgave:** Finn alle barn (personer) som har "h0001" som foresatt.
<details>
<summary>Vis løsning(er)</summary>
//person[foresattId='h0001']
</details>

## Telling og Aggregering (Avansert)
### Oppgave 29: Tell antall personer
**Oppgave:** Tell totalt antall påmeldte personer.
<details>
<summary>Vis løsning(er)</summary>
count(//person)
</details>

### Oppgave 30: Tell antall medlemmer
**Oppgave:** Tell hvor mange personer som er medlemmer.
<details>
<summary>Vis løsning(er)</summary>
count(//person[medlem='true'])
</details>

### Oppgave 31: Tell antall personer i hver pulje
**Oppgave:** Tell antall personer i pulje 1.
<details>
<summary>Vis løsning(er)</summary>
count(//person[puljeId='1']) <br>
Gjenta for andre puljer ved å endre tallet.
</details>

### Oppgave 32: Tell antall menn
**Oppgave:** Tell antall menn (id starter med "h").
<details>
<summary>Vis løsning(er)</summary>
count(//person[starts-with(id, 'h')])
</details>

### Oppgave 33: Tell antall kvinner
**Oppgave:** Tell antall kvinner (id starter med "d").
<details>
<summary>Vis løsning(er)</summary>
count(//person[starts-with(id, 'd')])
</details>

## Avanserte Søk

### Oppgave 34: Finn personer født i en bestemt måned
**Oppgave:** Finn alle personer født i desember (måned 12).
<details>
<summary>Tips</summary>
<i><li>Bruk metoden substring(string, start, length) for å hente ut månedsdelen av fødselsdatoen.</li></i>
</details>
<details>
<summary>Vis løsning(er)</summary>
//person[substring(fdato, 6, 2) = '12']
</details>

### Oppgave 35: Finn personer født på 1980-tallet
**Oppgave:** Finn alle personer født mellom 1980 og 1989.
<details>
<summary>Tips</summary>
<i><li>Her kan du også bruke substring metoden.</li></i>
</details>
<details>
<summary>Vis løsning(er)</summary>
//person[substring(fdato, 1, 4) >= '1980' and substring(fdato, 1, 4) <= '1989']
</details>


### Oppgave 36: Finn personer med lavest poengsum
**Oppgave:** Finn personen(e) med lavest poengsum.
<details>
<summary>Vis løsning(er)</summary>

**XPath 2.0+:**<br>
//person[poeng = min(//person/poeng)]<br>

**XPath 1.0:**<br>
//person[not(../person/poeng < poeng)]<br>

Merk: `min()` fungerer kun i XPath 2.0+, ikke i XPath 1.0 som benyttes i IntelliJ.
</details>

### Oppgave 37: Finn personer med høyest poengsum
**Oppgave:** Finn personen(e) med høyest poengsum.
<details>
<summary>Vis løsning(er)</summary>

**XPath 2.0+:** <br>
//person[poeng = max(//person/poeng)] <br>

**XPath 1.0:** <br>
//person[not(../person/poeng > poeng)] 
</details>

## Kombinerte og Komplekse Søk (Svært Avansert)
### Oppgave 38: Finn ikke-medlemmer i pulje 3 eller 4
**Oppgave:** Finn alle ikke-medlemmer som er i pulje 3 eller pulje 4.
<details>
<summary>Vis løsning(er)</summary>
//person[medlem='false' and (puljeId='3' or puljeId='4')]
</details>

### Oppgave 39: Finn navn på alle i pulje 1
**Oppgave:** Finn navnene (kun tekst) på alle personer i pulje 1.
<details>
<summary>Vis løsning(er)</summary>
//person[puljeId='1']/navn/text()
</details>

### Oppgave 40: Finn id-en til alle barn
**Oppgave:** Finn id-ene til alle personer som har en foresatt.
<details>
<summary>Vis løsning(er)</summary>
//person[foresattId]/id/text()
</details>

### Oppgave 41: Finn alle hjemmesider som IKKE er example.com
**Oppgave:** Finn alle hjemmesider som ikke inneholder "example.com".
<details>
<summary>Vis løsning(er)</summary>
//person[not(contains(hjemmeside, 'example.com'))]/hjemmeside/text()
</details>

### Oppgave 42: Finn personer uten medlem-status
**Oppgave:** Finn hvor mange personer som mangler `<medlem>` elementet.
<details>
<summary>Vis løsning(er)</summary>
count(//person[not(medlem)])
</details>

### Oppgave 43: Finn alle menn med mindre enn 800 poeng
**Oppgave:** Finn alle mannlige deltakere (id starter med "h") som har mindre enn 800 poeng.
<details>
<summary>Vis løsning(er)</summary>
//person[starts-with(id, 'h') and poeng < 800]
</details>

### Oppgave 44: Finn alle kvinner som er medlemmer
**Oppgave:** Finn alle kvinnelige deltakere (id starter med "d") som er medlemmer.
<details>
<summary>Vis løsning(er)</summary>
//person[starts-with(id, 'd') and medlem='true']
</details>

### Oppgave 45: Finn person etter fødselsnummer
**Oppgave:** Finn personen med fødselsnummer "12058348217".
<details>
<summary>Vis løsning(er)</summary>
//person[fnr='12058348217']
</details>

## Akser og Navigasjon (Meget Avansert)
### Oppgave 46: Finn foreldrenoden til en person
**Oppgave:** Finn navnet på foreldrenoden til første person.
<details>
<summary>Vis løsning(er)</summary>
name(//person[1]/..)
</details>

### Oppgave 47: Finn forrige person før d0025
**Oppgave:** Finn den personen som kommer rett før person med id "d0025".<br>

**NB! Dette får dere ikke på eksamen.**

<details>
<summary>Tips</summary>
<i><li>Bruke "preceding-sibling::person[1]".</li><br>
</details>

<details>
<summary>Vis løsning(er)</summary>
//person[id='d0025']/preceding-sibling::person[1]
</details>

### Oppgave 48: Finn alle elementer som er barn av person
**Oppgave:** Finn alle barn-elementer (id, navn, fdato, osv.) til første person.

<details>
<summary>Tips</summary>
<i><li>Bruk "child::*".</li></i>
</details>

<details>
<summary>Vis løsning(er)</summary>
//person[1]/* <br>
eller med relasjons-notasjon: <br>
//person[1]/child::*
</details>

## Union og Kombinasjoner (Meget Avansert)

### Oppgave 49: Finn første og siste person
**Oppgave:** Finn både den første og den siste personen.
<details>
<summary>Vis løsning(er)</summary>
//person[1] | //person[last()]
</details>

### Oppgave 50: Tell hvor mange puljer som finnes
**Oppgave:** Tell antall definerte puljer.
<details>
<summary>Vis løsning(er)</summary>
count(//pulje)
</details>

## Tips og Triks
### Wildcards
- `*` matcher alle elementer
- `@*` matcher alle attributter
- `node()` matcher alle noder (elementer, tekst, kommentarer, osv.)
### Funksjoner (XPath 1.0)
- `count()` - teller noder
- `sum()` - summerer verdier
- `contains()` - sjekker om en streng inneholder en annen
- `starts-with()` - sjekker om en streng starter med
- `substring()` - henter en delstreng
### Relasjonsakser
- `child::` - barn (standard akse)
- `parent::` - forelder (`..` er snarvei)
- `ancestor::` - alle forfedre
- `descendant::` - alle etterkommere
- `following-sibling::` - følgende søsken
- `preceding-sibling::` - foregående søsken
- `following::` - alle noder etter (i dokumentrekkefølge)
- `preceding::` - alle noder før (i dokumentrekkefølge)
- `attribute::` - attributter (`@` er snarvei)
- `self::` - noden selv
- 
### Operatorer
- **Sammenligning:** `=`, `!=`, `<`, `>`, `<=`, `>=`
- **Logiske:** `and`, `or`, `not()`
- **Matematiske:** `+`, `-`, `*`, `div`, `mod`
- **Union:** `|` (kombinerer node-sets)

## Testing av XPath
For å teste disse XPath-uttrykkene kan du bruke IntelliJ sin innebygde funksjon "Evaluate XPath". <br>
Høyreklikk på XML-filen, velg "Evaluate XPath", og skriv inn ditt XPath-uttrykk for å se resultatene direkte i verktøyet.

## Konklusjon
Dette dokumentet dekker XPath fra grunnleggende til avanserte søk. Start med de enkle eksemplene og arbeid deg oppover etter hvert som du blir mer komfortabel med syntaksen.

**Viktige punkter:**
- Bruk `<details>` tags for å holde løsninger skjult mens du øver
- Test uttrykkene dine i et verktøy (f.eks. IntelliJ) for å verifisere resultatene


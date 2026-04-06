xquery version "3.1";

(: personer-80-tallet.xqy
 : Finn alle personer som er født på 80-tallet (1980–1989).
 : Basert på personer.xml i samme katalog.
 :)

let $persons := doc("personer.xml")/personer/person[starts-with(fodselsdato, '198')]
return
  <personer80tallet count="{count($persons)}">
  {
    for $p in $persons
    order by $p/fodselsdato
    return $p
  }
  </personer80tallet>


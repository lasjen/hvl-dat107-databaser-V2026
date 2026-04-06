(: read all persons and persons with barn > 0 :)
let $personer := (doc("personer.xml")/personer/person)

let $results :=
<allPersons>
{
   for $x in $personer
   where 1=1
   (:$x/barn>0 :)
   order by $x/barn
   return <person>
    {$x/fornavn}
    {$x/etternavn}
    {$x/barn}
   </person>
}
</allPersons>

let $parents :=
<parents>
{
   for $y in $personer
   where $y/barn > 0
   order by $y/barn descending
   return
      <parent>
         { $y/fornavn }
         { $y/barn }
      </parent>
}
</parents>

return <result>
           { $results }
           { $parents }
       </result>
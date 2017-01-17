xquery version "1.0";

declare variable $employee-xml as xs:string := "v-emps.xml";
declare variable $department-xml as xs:string := "v-depts.xml";

(:Temporal Count. Print the history of employee count for the whole company:)

declare variable $empno := doc($employee-xml)//empno;
declare variable $dept-no := doc($employee-xml)//deptno;

declare variable $start-dates :=
    for $i in distinct-values($empno/@tstart)
        order by $i
        return xs:date($i);
    
declare variable $end-dates :=
    for $i in distinct-values($empno/@tend)
        order by $i
        return xs:date($i);

declare variable $combined-dates := 
	for $i in distinct-values(($start-dates, $end-dates))
		order by $i
		return $i;    

declare variable $empolyee-num :=
    for $start at $pos in $combined-dates 
        let $x := $empno[@tstart <= $start and $start < @tend]
        let $cnt := count($x)
        order by $start
        return <count date="{$start}">{xs:decimal($cnt)}</count>; 

declare variable $max := count($empolyee-num);

<whole-company>
{
     for $tstart at $pos in $empolyee-num
	      let $tend := $empolyee-num[$pos + 1]
	       where( $pos < $max )
	       return <count tstart="{$tstart/@date}" tend="{$tend/@date}">
	       {string($empolyee-num[$pos])}</count>
}
</whole-company>

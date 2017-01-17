xquery version "1.0";

declare variable $employee-xml as xs:string := "v-emps.xml";
declare variable $department-xml as xs:string := "v-depts.xml";

(:Temporal Count. Print the history of employee count for each department:)

declare variable $deptno := doc($department-xml)//deptno;
declare variable $emps := doc($employee-xml);
declare variable $departments := doc($department-xml);

declare variable $deptnos :=
        for $i in distinct-values($deptno)
        order by $i
        return xs:string($i);

<company>
{
    for $deptnumber in $deptnos
        let $depts := $emps/employees/employee[deptno=$deptnumber]/empno
        let $dates :=
            for $date in distinct-values(($depts/@tstart, $depts/@tend))
                order by $date
                return ($date)
        let $max := count($dates)
        let $name := $departments/departments/department[deptno=$deptnumber]/deptname
        return
        <dept>
                {
                    for $deptnocur in $deptno
                    where data($deptnocur) = $deptnumber
                    return $deptnocur
                }
                {$name}
                {
                    for $tstart at $pos in ($dates)
                        let $y := $depts[@tstart <= $tstart and $tstart < @tend],
                            $tend := $dates[$pos + 1]
                            where $pos < $max and not($tstart = "9999-12-31")
                        return <count tstart="{$tstart}" tend="{$tend}">{count($y)}</count>
                }
        </dept>
}
</company>




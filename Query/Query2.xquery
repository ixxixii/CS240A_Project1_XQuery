xquery version "1.0";

import module namespace helperFunctions = "helperFunctionsforXML" at "file:/Users/JohnZ/Desktop/Proj1/helperFunctions.xquery";

declare variable $employee-xml as xs:string := "v-emps.xml";
declare variable $department-xml as xs:string := "v-depts.xml";

declare variable $date := '1995-01-06';

(:Temporal Snapshot. Retrieve the name, salary and department of each employee who, on 1995-01-06, was making less than $44,000.:)
element snapshot
{
    for $emp in doc($employee-xml)//employee[@tstart <= $date and $date <= @tend]
        let $salary := $emp/salary[@tstart <= $date and $date <= @tend], $deptno := $emp/deptno[@tstart <= $date and $date <= @tend]
        where($salary and $deptno and $salary < 44000 )
        return element

        {node-name($emp)}
        {
            helperFunctions:snapshot(($emp/firstname, $emp/lastname, helperFunctions:deptNumber($deptno), $salary))
        }
}

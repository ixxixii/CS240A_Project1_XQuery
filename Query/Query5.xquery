xquery version "1.0";

import module namespace helperFunctions = "helperFunctionsforXML" at "file:/Users/JohnZ/Desktop/Proj1/helperFunctions.xquery";

declare variable $employee-xml as xs:string := "v-emps.xml";
declare variable $department-xml as xs:string := "v-depts.xml";

(:Temporal Join. For each employee show title history and his/her manager history.:)

element temporalJoin {
    for $emp in doc($employee-xml)//employee
        return element
        {node-name($emp)}
        {
            helperFunctions:slice($emp, '1900-01-01', '9999-12-31'),
            helperFunctions:untilChangedToAll2(($emp/empno,$emp/firstname,$emp/lastname)),
            helperFunctions:untilChangedToAll2(($emp/title, $emp/deptno)),

            element managers
            {
                for $deptno in $emp/deptno, $manager in doc($department-xml)//department[deptno=$deptno]/mgrno[@tstart<=$deptno/@tend and $deptno/@tstart<=@tend]
                            let $deptDuration := helperFunctions:slice($deptno, '1900-01-01','9999-12-31')
                            return helperFunctions:sliceAll(($manager),string($deptDuration[1]),string($deptDuration[2]))
            }
         }
}

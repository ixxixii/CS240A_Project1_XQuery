xquery version "1.0";

import module namespace helperFunctions = "helperFunctionsforXML" at "file:/Users/JohnZ/Desktop/Proj1/helperFunctions.xquery";

declare variable $employee-xml as xs:string := "v-emps.xml";
declare variable $department-xml as xs:string := "v-depts.xml";

(:Duration: For each employee, show the longest period during which he/she went with no change in salary and his/her salary during that time.:)

element durationCoalescing
{
    for $emp in doc($employee-xml)//employee
        let $durations :=
            for $salary in $emp/salary
            return helperFunctions:untilChangedToNow($salary/@tend) - xs:date($salary/@tstart)
        return element
    	
        {node-name($emp)}
    	
        {
            helperFunctions:slice($emp, '1900-01-01', helperFunctions:currentDate()),
            helperFunctions:untilChangedToAll(($emp/firstname, $emp/lastname)),
            element LongestPeriod {max($durations)},
            for $salary	in $emp/salary[helperFunctions:untilChangedToNow(@tend) - xs:date(@tstart)=max($durations)]
            order by $salary/@tstart, $salary/@tend
                {node-name($salary)}
                {
                    helperFunctions:slice($salary, '1900-01-01', helperFunctions:currentDate()),
                    string($salary)
                }
        }
}



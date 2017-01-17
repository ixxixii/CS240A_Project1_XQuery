
declare variable $employee-xml as xs:string := "v-emps.xml";
declare variable $department-xml as xs:string := "v-depts.xml";

(:Query 1 - Selection and Temporal Projection. Retrieve the employment history of employee "Anneke Preusig" (i.e., the departments where she worked and the periods during which she worked there).:)
element history
{
    for $emp in doc($employee-xml)/employees/employee
        where $emp/firstname="Anneke" and $emp/lastname="Preusig"
        return $emp/deptno
}



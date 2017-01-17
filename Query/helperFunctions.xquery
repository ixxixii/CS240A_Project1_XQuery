module namespace helperFunctions = "helperFunctionsforXML";

(:Return the current date - timestamp:)
    declare function helperFunctions:currentDate() as xs:string
{
xs:string(fn:adjust-date-to-timezone(current-date(), ()))
};

(:Convert 'Until Changed' to current timestamp:)
    declare function helperFunctions:untilChangedToNow($x as xs:string) as xs:date
{
    if( $x="9999-12-31" )
    then xs:date(helperFunctions:currentDate())
    else xs:date($x)
};

(:Return the minimum of two dates:)
    declare function helperFunctions:minDate($x1 as xs:string, $x2 as xs:string) as xs:date
{
    if(xs:date($x1)>xs:date($x2))
    then xs:date($x2)
    else xs:date($x1)
};

(:Return Maximum of two dates:)
    declare function helperFunctions:maxDate($x1 as xs:string, $x2 as xs:string) as xs:date
{
    if(xs:date($x1)>xs:date($x2))
    then xs:date($x1)
    else xs:date($x2)
};

(:Convert all elements from Until Changed to Current-Timestamp:)
declare function helperFunctions:untilChangedToAll($elements as element()*) as element()*
{
    for $element in $elements
    order by $element/@tstart, $element/@tend
    return element
    {node-name($element)}
    {
        helperFunctions:slice($element, '1900-01-01', helperFunctions:currentDate()),
        string($element)
    }
};

(:V2: Convert all elements from Until Changed to Current-Timestamp:)
declare function helperFunctions:untilChangedToAll2($elements as element()*) as element()*
{
for $element in $elements
order by $element/@tstart, $element/@tend
return element
{node-name($element)}
{
helperFunctions:slice($element, '1900-01-01', '9999-12-31'),
string($element)
}
};

(:Return the snapshot of the data:)
declare function helperFunctions:snapshot($elements as element()*) as element()*
{
    for $element in $elements
    return element
    {node-name($element)}
    {
        $element/@*[name(.)!="tend" and name(.)!="tstart"],
        data($element)
    }
};

(:Get the department number of each element:)
declare function helperFunctions:deptNumber( $deptnos as element()* ) as element()*
{
    for $deptno in $deptnos
    return element
    {node-name($deptno)}
    {
        $deptno/@*,
        attribute deptname {string(doc("v-depts.xml")//department[deptno=$deptno]/deptname)},
        string($deptno)
    }
};

(:Return element which lie between start & end date:)
declare function helperFunctions:slice( $element as element(), $start as xs:string, $stop as xs:string ) as attribute()*
{
    attribute tstart {helperFunctions:maxDate($start,$element/@tstart)},
    attribute tend   {helperFunctions:minDate($stop,$element/@tend)},
    $element/@*[name(.)!="tend" and name(.)!="tstart"]
};


declare function helperFunctions:sliceAll( $elements as element()*,
$start as xs:string, $stop as xs:string ) as element()*
{
    for $element in $elements
    return
    element {node-name($element)}
    {
        helperFunctions:slice($element, $start, $stop),
        string($element)
    }
};

# CS240A_XQuery
Final Project1 : CS240A - Advanced Databases &amp; Knowledge Bases 

The transaction-time history of employees and departments for the XYZ corporation are in the stored in the following XML documents: v-emps.xml and v-depts.xml. (Download them rather than trying to see them in your broswer.)

This project is to write the following queries using XQuery:

1.Selection and Temporal Projection. Retrieve the employment history of employee "Anneke Preusig" (i.e., the departments where she worked and the periods during which she worked there).

2.Temporal Snapshot. Retrieve the name, salary and department of each employee who, on 1995-01-06 was making less than $44000.

3.Temporal Slicing. For all departments, show their history in the period starting on 1994-05-01 and ending 1996-05-06.

4.Duration: For each employee, show the longest period during which he/she went with no change in salary and his/her salary during that time.

5.Temporal Join. For each employee show title history and his/her manager history.

6.Temporal Count. Print the history of employee count for (i) each department, and (ii) the whole company.

7.Temporal Max. For the employees  in department d005,  find the maximum of their salaries over time, and print the history of such a maximum.

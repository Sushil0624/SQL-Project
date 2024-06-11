show databases;
use employees;

/*1. From the following table, write a SQL query to find those employees who receive a higher salary than the 
employee with ID 163. 
Return first name, last name.*/
select emp_id,concat(first_name,' ',last_name)as 'Full Name' from employee where salary >
(select salary from employee where emp_id=163);

/*2. From the following table, write a SQL query to find out which employees have the same designation as the 
employee whose ID is 169. 
Return first name, last name, department ID and job ID.*/
select first_name,last_name,department_id,job_id from employee where department_id=
(select department_id from employee where emp_id=169);

/*3. From the following table, write a SQL query to find those employees whose salary matches the lowest salary 
of any of the departments. 
Return first name, last name and department ID.*/
select first_name,last_name,salary,department_id from employee where salary in
(select min(salary) from employee group by department_id); 

/*4. From the following table, write a SQL query to find those employees who earn more than the average salary. 
Return employee ID, first name, last name.*/
select emp_id,first_name,last_name,salary from employee where salary > (select avg(salary) from employee);

/*5. From the following table, write a SQL query to find those employees who report to that manager whose first 
name is ‘Payam’. 
Return first name, last name, employee ID and salary.*/
select first_name,last_name,emp_id,salary from employee where manager_id=
(select emp_id from employee where first_name='payam');

/*6. From the following tables, write a SQL query to find all those employees who work in the Finance department. 
Return department ID, name (first), job ID and department name*/
#using joins
select d.department_id,e.first_name,e.job_id,d.department_name from employee e join department d using(department_id)
where d.department_name='finance';
#using subquery
select e.department_id,e.first_name,e.job_id,d.department_name from employee e, department d 
where e.department_id=d.department_id and d.department_name='finance';


/*7. From the following table, write a SQL query to find the employee whose salary is 3000 and reporting person’s 
ID is 121. 
Return all fields.*/
select * from employee where emp_id=(select emp_id from employee where salary=3000 and manager_id=121);


/*8. From the following table, write a SQL query to find those employees whose ID matches 
any of the numbers 134, 159 and 183. 
Return all the fields.*/
select * from employee where emp_id in (134,159,183);

/*9. From the following table, write a SQL query to find those employees whose salary is in the 
range of 1000, and 3000 (Begin and end values have included.). 
Return all the fields.*/
select * from employee where salary between 1000 and 3000;

/*10. From the following table and write a SQL query to find those employees whose salary falls within the range of 
the smallest salary and 2500. Return all the fields.*/
select * from employee where salary between (select min(salary) from employee) and 2500;


/*11. From the following tables, write a SQL query to find those employees who do not work in the departments 
where managers’ IDs are between 100 and 200 (Begin and end values are included.). 
Return all the fields of the employeess.*/
select * from employee where department_id not in 
(select department_id from department where manager_id between 100 and 200);

/*12. From the following table, write a SQL query to find those employees who get second-highest salary. 
Return all the fields of the employees.*/
select * from employee where salary=
(select max(salary) from employee where salary != (select max(salary) from employee));

select * from employee order by salary desc limit 2 offset 1;

/*13. From the following tables, write a SQL query to find those employees who work in the same department as ‘Clara’. 
Exclude all those records where first name is ‘Clara’. 
Return first name, last name and hire date.*/
select first_name,last_name,hire_date from employee where department_id = 
(select department_id from employee where first_name = 'clara') and first_name != 'clara';

/*14. From the following tables, write a SQL query to find those employees who work in a department where the 
employee’s first name contains the letter 'T'. 
Return employee ID, first name and last name.*/
select emp_id,first_name,last_name from employee where department_id in 
(select department_id from employee where first_name like '%T%');

/*15. From the following tables, write a SQL query to find those employees who earn more than the average salary and 
work in the same department as an employee whose first name contains the letter 'J'. 
Return employee ID, first name and salary.*/
select department_id from employee where first_name like '%J%';
select avg(salary) from employee;
select emp_id,first_name,salary from employee where salary>(select avg(salary) from employee) and department_id in
(select department_id from employee where first_name like '%J%');

/*16. From the following table, write a SQL query to find those employees whose department is located at ‘Toronto’. 
Return first name, last name, employee ID, job ID.*/
select first_name,last_name,emp_id,job_id from employee where department_id=
(select department_id from department where location_id=(select location_id from locations where city = 'toronto'));

/*17. From the following table, write a SQL query to find those employees whose salary is lower than that of 
employees whose job title is ‘MK_MAN’. 
Return employee ID, first name, last name, job ID.*/
select emp_id,first_name,last_name,job_id from employee where salary < 
(select salary from employee where job_id = 'MK_MAN');

/*18. From the following table, write a SQL query to find those employees whose salary is lower than that of 
employees whose job title is "MK_MAN". Exclude employees of Job title ‘MK_MAN’. 
Return employee ID, first name, last name, job ID.*/
select emp_id,first_name,last_name,job_id from employee where salary < 
(select salary from employee where job_id='mk_man') and job_id != 'mk_man';


/*19. From the following table, write a SQL query to find those employees whose salary exceeds the salary of all 
those employees whose job title is "PU_MAN". Exclude job title ‘PU_MAN’. 
Return employee ID, first name, last name, job ID.*/
select emp_id,first_name,last_name,job_id from employee where salary > all 
(select salary from employee where job_id = 'pu_man') and job_id != 'pu_man';

/*20. From the following table, write a SQL query to find those employees whose salaries are higher than the 
average for all departments. 
Return employee ID, first name, last name, job ID.*/
select emp_id,first_name,last_name,job_id from employee where salary > all
(select avg(salary) from employee group by department_id) ;

/*21. From the following table, write a SQL query to check whether there are any employees with salaries 
exceeding 3700. 
Return first name, last name and department ID.*/
select first_name,last_name,department_id from employee where salary > 3700;

/*22. From the following table, write a SQL query to calculate total salary of the departments where at least one 
employee works. 
Return department ID, total salary.*/
select d.department_id,a.total_salary from department d, 
(select e.department_id,sum(e.salary) as 'total_salary' from employee e group by e.department_id) a 
where a.department_id=d.department_id; 

/*23. Write a query to display the employee id, name ( first name and last name ) and the 
job id column with a modified title SALESMAN for those employees whose job title is ST_MAN 
and DEVELOPER for whose job title is IT_PROG.*/
select emp_id,concat(first_name,' ',last_name) as 'Name',case when job_id='ST_MAN' then 'SALESMAN'
when job_id='IT_PROG' then 'Developer'  else job_id 
end as 'Modified Title' from employee ;

/*24. Write a query to display the employee id, name ( first name and last name ), salary and the SalaryStatus 
column with a title HIGH and LOW respectively for those employees whose salary is more than and 
less than the average salary of all employees.*/
select emp_id,concat(first_name,' ',last_name) as 'Name',salary,
case when salary <(select avg(salary) from employee) then 'Low' 
when salary >(select avg(salary) from employee) then 'High'
end as 'Salary Status'
from employee;

/*25. Write a query to display the employee id, name ( first name and last name ), SalaryDrawn, 
AvgCompare (salary - the average salary of all employees) and the SalaryStatus column with 
a title HIGH and LOW respectively for those employees whose salary is more than and less than 
the average salary of all employees.*/
select emp_id,concat(first_name,' ' ,last_name) as 'Name',salary as 'Salary_Drawn',
salary-(select avg(salary) from employee) as 'Avg_Compare',case 
when salary>(select avg(salary) from employee) then 'High'
When salary<(select avg(salary) from employee) then 'Low'
end as 'Salary_Status'
from employee;


/*26. From the following table, write a SQL query to find all those departments where at least one employee is 
employed. Return department name*/
select department_name from department where department_id in (select distinct department_id from employee);

/*27. From the following tables, write a SQL query to find employees who work in departments located in the 
United Kingdom. 
Return first name.*/
select e.first_name from employee e join department d using(department_id) join locations l using(location_id) 
where l.country_id='Uk';

select first_name from employee where department_id in (
select department_id from department where location_id in (select location_id from locations where country_id='UK'));

/*28. From the following table, write a SQL query to find out which employees are earning more than the average 
salary and who work in any of the IT departments. 
Return last name.*/
select last_name from employee where salary>(select avg(salary) from employee) and 
department_id=(select department_id from department where department_name='IT');

/*29. From the following table, write a SQL query to find all those employees who earn more than an employee 
whose last name is 'Ozer'. Sort the result in ascending order by last name. 
Return first name, last name and salary.*/
select first_name,last_name,salary from employee where salary >
(select salary from employee where last_name='ozer') order by last_name asc;

/*30. From the following tables, write a SQL query find the employees who report to a manager based in the 
United States. 
Return first name, last name.*/
select first_name,last_name from employee where emp_id in(select manager_id from department where location_id in 
(select location_id from locations where country_id = 'US'));

/*31. From the following tables, write a SQL query to find those employees whose salaries exceed 50% of their 
department's total salary bill. 
Return first name, last name.*/
select e1.first_name,e1.last_name from employee e1 where salary > 
(select sum(salary)*0.5 from employee e2 where e1.department_id=e2.department_id);

/*32. From the following tables, write a SQL query to find those employees who are managers. 
Return all the fields of employees table.*/
select *from employee where emp_id in (select distinct manager_id from employee);

/*33. From the following table, write a SQL query to find those employees who manage a department. 
Return all the fields of employees table.*/
select * from employee where emp_id in (select manager_id from department);


/*34. From the following table, write a SQL query to search for employees who receive such a salary, 
which is the maximum salary for salaried employees, hired between January 1st, 2002 and December 31st, 2003. 
Return employee ID, first name, last name, salary, department name and city.*/
select e.emp_id,e.first_name,e.last_name,max(e.salary),d.department_name,l.city from employee e join department d
using(department_id) join locations l using (location_id) where e.hire_date between '2002-01-01' and '2003-12-31';

/*35. From the following tables, write a SQL query to find those departments that are located in the city of London. 
Return department ID, department name.*/
select department_id,department_name from department where location_id=
(select location_id from locations where city = 'london');

/*36. From the following table, write a SQL query to find those employees who earn more than the average salary. 
Sort the result-set in descending order by salary. 
Return first name, last name, salary, and department ID.*/
select first_name,last_name,salary,department_id from employee where salary > 
(select avg(salary) from employee) order by  salary desc;

/*37. From the following table, write a SQL query to find those employees who earn more than the 
maximum salary for a department of ID 40. 
Return first name, last name and department ID.*/
select first_name,last_name,department_id from employee where salary >
(select max(salary) from employee where department_id=40);

/*38. From the following table, write a SQL query to find departments for a particular location. 
The location matches the location of the department of ID 30. 
Return department name and department ID.*/
select department_name,department_id from department where location_id=
(select location_id from department where department_id=30);


/*39. From the following table, write a SQL query to find employees who work for the department in 
which employee ID 201 is employed. 
Return first name, last name, salary, and department ID*/
select first_name,last_name,salary,department_id from employee where department_id=
(select department_id from employee where emp_id=201);

/*40. From the following table, write a SQL query to find those employees whose salary matches that 
of the employee who works in department ID 40. 
Return first name, last name, salary, and department ID.*/
select first_name,last_name,salary,department_id from employee where salary =
(select salary from employee where department_id=40);

/*41. From the following table, write a SQL query to find those employees who work in the 
department 'Marketing'. 
Return first name, last name and department ID.*/
select first_name,last_name,department_id from employee where department_id = 
(select department_id from department where department_name='marketing');

/*42. From the following table, write a SQL query to find those employees who earn more than the 
minimum salary of a department of ID 40. Return first name, last name, salary, and department ID.*/
select first_name,last_name,salary,department_id from employee where salary > 
(select min(salary) from employee where department_id=40);

/*43. From the following table, write a SQL query to find those employees who joined after the 
employee whose ID is 165. 
Return first name, last name and hire date.*/
select first_name,last_name,hire_date from employee where hire_date > 
(select hire_date from employee where emp_id=165);

/*44. From the following table, write a SQL query to find those employees who earn less than the 
minimum salary of a department of ID 70. 
Return first name, last name, salary, and department ID.*/
select first_name,last_name,salary,department_id from employee where salary <
(select min(salary) from employee where department_id=70);

/*45. From the following table, write a SQL query to find those employees who earn less than the 
average salary and work at the department where Laura (first name) is employed. 
Return first name, last name, salary, and department ID.*/
select first_name,last_name,salary,department_id from employee where salary <
(select avg(salary) from employee) and 
department_id=(select department_id from employee where first_name = 'laura');

/*46. From the following tables, write a SQL query to find all employees whose department is located 
in London. 
Return first name, last name, salary, and department ID.*/
select first_name,last_name,department_id from employee where department_id = 
(select department_id from department where location_id=
(select location_id from locations where city = 'london'));


/*47. From the following tables, write a SQL query to find the city of the employee of ID 134. 
Return city.*/
select city from locations where location_id = 
(select location_id from department where department_id =
(select department_id from employee where emp_id=134));

/*48. From the following tables, write a SQL query to find those departments where the starting salary 
is at least 8000. Return all the fields of departments.*/

select * from department where department_id in (
select department_id from employee  group by department_id having min(salary)>=8000);

/*50. From the following table, write a SQL query to find those managers who supervise four or 
more employees. 
Return manager name, department ID.*/
select concat(first_name,' ',last_name) as 'Manager_name',department_id from employee 
where emp_id in (select manager_id from employee group by manager_id having(manager_id)>=4);

/*52. From the following table, write a SQL query to find those employees who earn the second-lowest 
salary of all the employees. 
Return all the fields of employees.*/
select * from employee where salary=
(select min(salary) from employee where salary != (select min(salary) from employee));
select * from employee order by salary asc limit 2 offset 1;


/*53. From the following table, write a SQL query to find the departments managed by Susan. 
Return all the fields of departments.*/
select department_id from employee where first_name='susan';
select * from department where department_id = 
(select department_id from employee where first_name='susan');


/*54. From the following table, write a SQL query to find those employees who earn 
the highest salary in a department. 
Return department ID, employee name, and salary.*/
select department_id,concat(first_name,' ',last_name) as 'Employee_Name',salary from employee
where salary in (select max(salary) from employee group by department_id);

#Joins

/*55. From the following tables, write a SQL query to find the first name, last name, 
department number, and department name for each employee.*/
select e.first_name,e.last_name,e.department_id,d.department_name from employee e join department d 
using(department_id);

/*56. From the following tables, write a SQL query to find the first name, last name, department, 
city, and state province for each employee.*/
select e.first_name,e.last_name,d.department_name,l.city,l.state_province from employee e join 
department d using(department_id) join locations l using(location_id);

/*57. From the following table, write a SQL query to find the first name, last name, salary, and 
job grade for all employees.*/
select e.first_name,e.last_name,e.salary,j.grade_level from employee e 
join job_grade j on e.salary between j.lowest_salary and j.highest_salary order by j.grade_level;

/*58. From the following tables, write a SQL query to find all those employees who work in 
department ID 80 or 40. Return first name, last name, department number and department name.*/
select e.first_name,e.last_name,d.department_name,e.department_id from employee e 
join department d using(department_id) where e.department_id in (80,40);

/*59. From the following tables, write a SQL query to find those employees whose first name 
contains the letter ‘z’. 
Return first name, last name, department, city, and state province.*/
select e.first_name,e.last_name,d.department_name,l.city,l.state_province from employee e
join department d using(department_id) join locations l using (location_id) 
where e.first_name like '%Z%';

/*60. From the following tables, write a SQL query to find all departments, including those without 
employees. 
Return first name, last name, department ID, department name.*/
select e.first_name,e.last_name,d.department_id,d.department_name from department d left outer join
employee e on(d.department_id=e.department_id);

/*61. From the following table, write a SQL query to find the employees who earn less than the 
employee of ID 182. 
Return first name, last name and salary.*/
select first_name,last_name,salary from employee where salary <
(select salary from employee where emp_id=182);

/*62. From the following table, write a SQL query to find the employees and their managers. 
Return the first name of the employee and manager.*/
select e.first_name as 'Employee',m.first_name as 'Manager' from employee e join 
employee m on(e.manager_id=m.emp_id);


/*63.From the following tables, write a SQL query to display the department name, city, and 
state province for each department.*/
select d.department_name,l.city,l.state_province from department d join locations l using(location_id);

/*64.From the following tables, write a SQL query to find out which employees have or do not have a 
department. 
Return first name, last name, department ID, department name.*/
select e.first_name,e.last_name,d.department_id,d.department_id from employee e 
left outer join department d on(e.department_id=d.department_id);

/*65.From the following table, write a SQL query to find the employees and their managers. 
Those managers do not work under any manager also appear in the list. 
Return the first name of the employee and manager.*/
select e.first_name as 'Employee',m.first_name as 'Manager' from employee e left outer join 
employee m on(e.manager_id=m.emp_id);

/*66.From the following tables, write a SQL query to find the employees who work in the same 
department as the employee with the last name Taylor. 
Return first name, last name and department ID.*/
select first_name,last_name,department_id from employee where department_id in
(select department_id from employee where last_name = 'taylor');

/*67.From the following tables, write a SQL query to find all employees who joined on or after 
1st January 1993 and on or before 31 August 1997. 
Return job title, department name, employee name, and joining date of the job.*/
select j.job_title,d.department_name,concat(e.first_name,' ',e.last_name) as 'Employee Name',e.hire_date
from employee e join department d using(department_id) join job j using(job_id)
where e.hire_date between '1993-01-01' and '1997-08-31';

/*68.From the following tables, write a SQL query to calculate the difference between the maximum 
salary of the job and the employee's salary. 
Return job title, employee name, and salary difference.*/
select j.job_title,concat(e.first_name,' ',e.last_name) as 'Employee_name',
j.max_salary-e.salary as 'salary_difference' from employee e join department d using(department_id)
join job j using(job_id);

/*69. From the following table, write a SQL query to calculate the average salary, the number of 
employees receiving commissions in that department. 
Return department name, average salary and number of employees.*/
select d.department_name,avg(e.salary),count(e.commission_pct) as 'No.of Employees' from department d 
join employee e using(department_id) group by d.department_name;


/*70.From the following tables, write a SQL query to calculate the difference between the 
maximum salary and the salary of all the employees who work in the department of ID 80. 
Return job title, employee name and salary difference.*/
select j.job_title,concat(e.first_name,' ',e.last_name) as 'Employee Name',j.max_salary-e.salary
from employee e join department d using(department_id) join job j using(job_id) 
where d.department_id=80;

/*71. From the following table, write a SQL query to find the name of the country, city, and 
departments, which are running there.*/
select l.country_id,l.city,d.department_name from department d join locations l using (location_id);

/*72. From the following tables, write a SQL query to find the department name and the full name 
(first and last name) of the manager.*/
select d.department_name,concat(e.first_name,' ',e.last_name) as 'Manager' from employee e 
join department d on(d.manager_id=e.emp_id);

/*73. From the following table, write a SQL query to calculate the average salary of employees for 
each job title.*/
select j.job_title,avg(e.salary) from employee e join department d using(department_id) 
join job j using(job_id) group by j.job_title;

/*74. From the following table, write a SQL query to find the employees who earn $12000 or more. 
Return employee ID, starting date, end date, job ID and department ID.*/
select * from employee where salary >= 12000;

/*75. From the following tables, write a SQL query to find out which departments have at least 
two employees. Group the result set on country name and city. 
Return country name, city, and number.*/
select l.country_id,l.city,count(e.department_id) from employee e join department d 
using(department_id) join locations l using(location_id) where d.department_id in 
(select department_id from employee group by department_id 
having count(department_id)>=2) group by l.country_id,l.city;


/*76. From the following tables, write a SQL query to find the department name, 
full name (first and last name) of the manager and their city.*/
select d.department_name,concat(e.first_name,' ',e.last_name) as 'Manager',l.city from employee e 
join department d on (e.emp_id=d.manager_id) join locations l using(location_id);


/*77. From the following tables, write a SQL query to calculate the number of days worked by 
employees in a department of ID 80. 
Return employee ID, job title, number of days worked.*/
select e.emp_id,j.job_title,year(curdate())-year(e.hire_date) as 'No.of days worked' from employee e
join department d using(department_id) join job j using(job_id) 
where d.department_id=80;

/*78. From the following tables, write a SQL query to find full name (first and last name), 
and salary of all employees working in any department in the city of London.*/
select concat(e.first_name,' ',e.last_name) as 'Full_Name',e.salary from employee e join department d 
using(department_id) join locations l using(location_id) where l.city='london';

/*79. From the following tables, write a SQL query to find the department name, 
department ID, and number of employees in each department.*/
select d.department_name,e.department_id,count(e.emp_id) from employee e join department d 
using(department_id) group by e.department_id;

/*80. From the following tables, write a SQL query to find out the full name (first and last name) 
of the employee with an ID and the name of the country where he/she is currently employed.*/
select concat(e.first_name,' ',e.last_name) as 'Full_Name',e.emp_id,l.country_id from employee e join
department d using(department_id) join locations l using(location_id);

#Filtering and sorting
/*81. From the following table, write a SQL query to find those employees whose salaries are 
less than 6000. Return full name (first and last name), and salary.*/
select concat(first_name,' ',last_name) as 'Full Name',salary from employee where salary < 6000;

/*82. From the following table, write a SQL query to find those employees whose salary is higher 
than 8000. Return first name, last name and department number and salary.*/
select first_name,last_name,department_id,salary from employee where salary > 8000;

/*83. From the following table, write a SQL query to find those employees whose last name is "McEwen". 
Return first name, last name and department ID.*/
select first_name,last_name,department_id from employee where last_name='McEwen';

/*84. From the following table, write a SQL query to identify employees who do not have a department 
number. Return employee_id, first_name, last_name, email, phone_number, 
hire_date, job_id, salary,commission_pct, manager_id and department_id.*/
select * from employee where department_id is null;

/*85. From the following table, write a SQL query to find the details of 'Marketing' department. 
Return all fields.*/
select * from department where department_name='marketing';

/*86. From the following table, write a SQL query to find those employees whose first name does 
not contain the letter ‘M’. Sort the result-set in ascending order by department ID. 
Return full name (first and last name together), hire_date, salary and department_id.*/
select concat(first_name,' ',last_name) as 'Full Name',hire_date,salary,department_id from employee 
where first_name not like '%M%' order by department_id asc;

/*87. From the following table, write a SQL query to find those employees who earn between 
8000 and 12000 (Begin and end values are included.) and get some commission. 
These employees joined before ‘2003-06-05'’ and were not included in the department numbers 
40, 120 and 70. Return all fields.*/
select * from employee where salary between 8000 and 12000 and commission_pct is not null 
and hire_date < '2003-06-05' and department_id not in (40,120,70);

/*88. From the following table, write a SQL query to find those employees who do not earn any commission. 
Return full name (first and last name), and salary.*/
select concat(first_name,' ',last_name) as 'Full_Name',salary from employee where commission_pct is null;

/*89. From the following table, write a SQL query to find the employees whose salary is in the range 
9000,17000 (Begin and end values are included). Return full name, contact details and salary.*/
select concat(first_name,' ',last_name) as 'Full Name',phone_number as 'Contact_Details',salary 
from employee where salary between 9000 and 17000;

/*90. From the following table, write a SQL query to find the employees whose first name ends with 
the letter ‘m’. Return the first and last name, and salary.*/
select first_name,last_name,salary from employee where first_name like '%m';

/*91. From the following table, write a SQL query to find those employees whose salaries are not 
between 7000 and 15000 (Begin and end values are included). 
Sort the result-set in ascending order by the full name (first and last). 
Return full name and salary.*/
select concat(first_name,' ',last_name) as 'Full_Name',salary from employee where salary not between
7000 and 15000 order by Full_Name asc;

/*92. From the following table, write a SQL query to find those employees who were hired between 
November 5th, 2007 and July 5th, 2009. 
Return full name (first and last), job id and hire date*/
select concat(first_name,' ',last_name) as 'Full_Name',job_id,hire_date from employee 
where hire_date between '2007-11-05' and '2009-07-05';

/*93. From the following table, write a SQL query to find those employees who work either in 
department 70 or 90. 
Return full name (first and last name), department id.*/
select concat(first_name,' ',last_name) as 'Full_Name',department_id from employee 
where department_id in (70,90);

/*94. From the following table, write a SQL query to find those employees who work under a manager. 
Return full name (first and last name), salary, and manager ID.*/
select concat(first_name,' ',last_name) as 'Full_Name',salary,manager_id from employee 
where manager_id is not null;

/*95. From the following table, write a SQL query to find the employees who were hired before June 
21st, 2002. 
Return all fields.*/
select * from employee where hire_date < '2002-06-21';

/*96. From the following table, write a SQL query to find the employees whose managers hold 
the ID 120, 103, or 145. 
Return first name, last name, email, salary and manager ID.*/
select first_name,last_name,email,salary,manager_id from employee where manager_id in (120,103,145);

/*97. From the following table, write a SQL query to find employees whose first names contain 
the letters D, S, or N. Sort the result-set in descending order by salary. 
Return all fields.*/
select * from employee where first_name like '%D%' or first_name like '%S%' or 
first_name like '%N%' order by salary desc;

/*98. 18. From the following table, write a SQL query to find those employees who earn above 11000 or 
the seventh character in their phone number is 3. 
Sort the result-set in descending order by first name. Return full name (first name and last name), 
hire date, commission percentage, email, and telephone separated by '-', and salary.*/
select concat(first_name,' ',last_name) as 'Full_Name',hire_date,commission_pct,email,
concat(substr(first_name,1,1),last_name,'-',phone_number) as 'Contact_details',salary from employee 
where salary > 11000 or phone_number like '______3%';

/*99.From the following table, write a SQL query to find those employees whose first name contains a 
character 's' in the third position. 
Return first name, last name and department id.*/
select first_name,last_name,department_id from employee where first_name like '__s%';

/*100. From the following table, write a SQL query to find those employees work in the departments 
that are not part of the department 50 or 30 or 80. 
Return employee_id, first_name,job_id, department_id.*/
select emp_id,first_name,job_id,department_id from employee where department_id not in (50,30,80);

/*101. From the following table, write a SQL query to find the employees whose department numbers 
are included in 30, 40, or 90. 
Return employee id, first name, job id, department id.*/
select emp_id,first_name,job_id,department_id from employee where department_id in (30,40,90);

/*102. From the following table, write a SQL query to count the number of employees, 
the sum of all salary, and difference between the highest salary and 
lowest salaries by each job id. Return job_id, count, sum, salary_difference..*/
select job_id,count(emp_id),sum(salary),max(salary)-min(salary) as 'Salary_difference' from employee
group by job_id;

/*103. From the following table, write a SQL query to count the number of cities in each country. 
Return country ID and number of cities.*/
select country_id,count(city)as 'Number of cities' from locations group by country_id;

/*104. From the following table, write a SQL query to count the number of employees worked under 
each manager. 
Return manager ID and number of employees.*/
select manager_id,count(emp_id) as 'Number of Employees' from employee group by manager_id;

/*105. From the following table, write a SQL query to find all jobs. 
Sort the result-set in descending order by job title. Return all fields.*/
select * from job order by job_title desc;

/*106. From the following table, write a SQL query to find all those employees who are either 
Sales Representatives or Salesmen. 
Return first name, last name and hire date.*/
select first_name,last_name,hire_date from employee where job_id in ('SA_REP','SA_MAN');

/*107. From the following table, write a SQL query to calculate the average salary of employees who 
receive a commission percentage for each department. 
Return department id, average salary.*/
select department_id,avg(salary) from employee where commission_pct is not null group by department_id;

/*108. From the following table, write a SQL query to find the departments where any manager manages 
four or more employees. Return department_id.*/
select distinct department_id from employee group by department_id,manager_id having count(emp_id)>=4;

/*109. From the following table, write a SQL query to find the departments where more than ten 
employees receive commissions. Return department id.*/
select department_id from employee group by department_id having count(commission_pct)>=10;

/*110. From the following table, write a SQL query to find those employees who do not have commission 
percentage and have salaries between 7000, 12000 (Begin and end values are included.) 
and who are employed in the department number 50. Return all the fields of employees.*/
select * from employee where commission_pct is null and salary between 7000 and 12000 and 
department_id=50;

/*111. From the following table, write a SQL query to compute the average salary of each job ID. 
Exclude those records where average salary is on or lower than 8000. Return job ID, average salary.*/
select job_id,avg(salary) as 'Average_salary' from employee group by job_id 
having avg(salary) > 8000;

/*112. From the following table, write a SQL query to find those job titles where maximum salary 
falls between 12000 and 18000 (Begin and end values are included.). 
Return job_title, max_salary-min_salary.*/
select job_title,max_salary-min_salary as 'Salary_difference' from job where max_salary between 
12000 and 18000;

/*113. From the following table, write a SQL query to find the employees whose first or 
last name begins with 'D'. 
Return first name, last name.*/
select first_name,last_name from employee where first_name like 'D%' or last_name like 'D%';

/*114. From the following table, write a SQL query to find details of those jobs where the 
minimum salary exceeds 9000. 
Return all the fields of jobs.*/
select * from job where min_salary > 9000;

/*115. From the following table, write a SQL query to find those employees who joined after 
7th September 1987. Return all the fields.*/
select * from employee where hire_date > '1987-09-07';
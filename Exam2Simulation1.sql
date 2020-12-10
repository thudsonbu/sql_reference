/* Exam 2 Simulation */
/* This simulation uses Retail Database; tables are available in your account  */

/* 1. List employee names of those who are either CLERK or ANALYST
in descending order of name */

SELECT emp.ename
FROM emp
WHERE emp.job IN ('CLERK', 'ANALYST');

/* Another method */

SELECT emp.ename
FROM emp
WHERE emp.job = 'CLERK'
OR emp.job = 'ANALYST';


/* 2. List employee name and job in ascending order of job of those
employees who joined on the beginning or after the second half of calendar year 2011 */

SELECT emp.ename, emp.job
FROM emp
WHERE emp.hiredate >= '2011-06-01'
ORDER BY job;

/* 3. List the employee name of those who joined the company in the 2011s */
     
SELECT emp.ename
FROM emp
WHERE to_char(emp.hiredate, 'RRRR') LIKE '2011%';

/* 4. List name of employees who are senior to employee: WARD. */  

SELECT emp.ename
FROM emp
WHERE emp.hiredate < 
    (SELECT emp.hiredate
    FROM emp
    WHERE emp.ename = 'WARD');
            
/* 5.List those jobs of deptno 10 that are not found in deptno 20  */

SELECT emp.job
FROM emp
WHERE emp.deptno = 10
AND emp.job NOT IN 
    (SELECT emp.job
    FROM emp
    WHERE emp.deptno = 20);

/* 6. List employee name, job, department name and location for
those who are managers */
      
select emp.ename, emp.job, dept.dname, dept.loc
from emp, dept
where emp.deptno = dept.deptno
and emp.job = 'MANAGER';

/* 7. List the employee name of those without a manager */
           
select emp.ename, emp.mgr
from emp
where emp.mgr is null;

/* 8. List the employee name of whose salary is more than the average
of maximum and minimum salaries in the company.  */
 
select emp.ename
from emp
where emp.sal > 
    (select avg(min(emp.sal),max(emp.sal))
    from emp);

/* 9. List all employees by name and employee number along
with their manager’s name and manager’s number ensuring that KING,
who has no manager, appears in the results.
 */

select employee.ename as "Employee Name", employee.empno as "Employee Number",
    manager.ename as "Manager Name", manager.empno as "Manager Number"
from emp employee
left outer join emp manager
on employee.mgr = manager.empno;


/* 10. List employee name and employee number, annual salary, 
daily salary of all salesmen in ascending order by annual salary.  
The database stores monthly salaries, and uses 365 days/year */

select emp.ename, emp.empno, 
    (emp.sal * 12) as "Annual Salary",
    round(((emp.sal *12)/365),2) as "Daily Salary"
from emp
where emp.job = 'SALESMAN'
order by emp.sal asc;

/* 11. List employee number, name, hire date, current date and
experience in months per each employee in ascending order of experience.
Consider month = 30 days */

select emp.empno as "Employee Number",
    emp.ename as "Employee Name",
    emp.hiredate as "Hire Date",
    CURRENT_DATE as "Current Date",
    round(((CURRENT_DATE - emp.hiredate)/30),0) as "Experience in Months"
from emp
order by "Experience in Months" asc;

/* 12. List the employee name of those whose experience is more than 8 years.
*/

select emp.ename,
    round(((CURRENT_DATE - emp.hiredate)/365),2) as experience
from emp
where round(((CURRENT_DATE - emp.hiredate)/365),2) > 8;


/* 13.	List employee name that starts with ‘M’.  */

select emp.ename
from emp
where emp.ename like 'M%';

/* 14.	List employee name of those who are working for department
10 or 20 with job title as clerk or analyst and with experience more than 8 
years but were not hired in months of March, April and May and working for
managers with manager numbers that are not ending with 88 and 56.  */

select emp.ename, emp.deptno, emp.job, emp.hiredate
from emp
where emp.deptno in (10,20)
and emp.job in ('CLERK', 'ANALYST')
and round(((current_date - emp.hiredate)/365),2) > 8
and extract(month from emp.hiredate) not in (3,4,5)
and to_char(emp.mgr) not like '%88'
and to_char(emp.mgr) not like '%56';

Select ename from emp
where
deptno in (10, 20) AND
Job in ('CLERK', 'ANALYST') AND
((months_between(sysdate, hiredate))/12) >8 AND
to_char(hiredate, 'MON') not in ('MAR', 'APR', 'SEP') AND
(mgr not like '%88' AND Mgr not like '%56');

/* 15.	List the employee number along with location of those who 
belong to Dallas or New York with salary ranging from 2000 to 5000 and joined in 2011 */

select emp.empno, dept.loc, emp.sal, emp.hiredate
from emp, dept
where emp.deptno = dept.deptno
and dept.loc in ('DALLAS','NEW YORK')
and emp.sal between 2000 and 5000
and extract(year from emp.hiredate) = 2011;

/* 16.	List employee name and the department number of
those who are receiving the highest salary in their department */

select emp.ename, emp.deptno, emp.sal
from emp
where emp.sal in 
    (select max(emp.sal)
    from emp
    group by emp.deptno);


/* 17. List the employee names of those who are working as managers. 
/* Multiple ways */
/* Answer a) */

select ename 
from emp 
where job = 'MANAGER' 
order by ename;





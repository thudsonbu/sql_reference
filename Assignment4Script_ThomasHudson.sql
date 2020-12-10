/* Question 1 Thomas Hudson */

/* Number of Records Produced: 1 Records */

SELECT name, phone FROM customer
WHERE name like '%S'
AND phone like '%66%';

/* Question 2 Thomas Hudson */

/* Number of Records Produced: 9 Records */

SELECT ename, hiredate FROM emp
WHERE hiredate >= '01-JUL-11';

/* Question 3 Thomas Hudson */

/* Number of Records Produced: 8 Records */

SELECT ename, hiredate FROM emp
WHERE hiredate <= 
    (SELECT hiredate FROM emp
     WHERE ename LIKE '%KING%');

/* Question 4 Thomas Hudson */

/* Number of Records Produced: 6 Records */

SELECT ename, sal*12 from emp
WHERE sal >= 
    (SELECT avg(sal) from emp)
ORDER BY sal desc;

/* Question 5 Thomas Hudson */

/* Number of Records Produced: 4 Records */

SELECT ename, round(sal*12, 0), round((sal/4), 0) FROM emp
WHERE job = 'SALESMAN'
ORDER BY sal desc;

/* Question 6 Thomas Hudson */

/* Number of Records Produced: 12 Records */
     
SELECT ename, round((current_date - hiredate)/365, 0) as Experience FROM emp
WHERE round((current_date - hiredate)/365, 0) >= 9
ORDER BY ename;

/* Question 7 Thomas Hudson */

/* Number of Records Produced: 1 Records */

select empno, ename from emp
where job = 'CLERK'
and hiredate =
    (SELECT max(hiredate) from emp);
    
/* I decided that this is likely the least senior member of the
organizations because the clerk job title sounds like a lower level
title and this employee has been hired most recently of any. */

/* Question 8 Thomas Hudson */

/* Number of Records Produced: 3 Records */

select ename, job, hiredate, mgr, round((current_date - hiredate)/365, 0) from emp
where deptno in (20, 30)
and job in ('CLERK', 'ANALYST')
and round((current_date - hiredate)/365, 0) > 8.5
and extract(month from hiredate) not in (03, 04)
and mgr not like '%88';

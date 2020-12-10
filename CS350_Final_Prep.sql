/* List out all customer's names and the ship-date of all orders that were 
shipped before they were ordered (see if there are any records) */

SELECT customer.name, ord.shipdate, ord.orderdate
  FROM customer
 INNER JOIN ord
    ON customer.custid = ord.custid
 WHERE ord.orderdate > ord.shipdate;
 
/* Find all departments in New York (list out the department name) */
 
SELECT dept.dname, dept.loc
  FROM dept
 WHERE dept.loc LIKE '%NEW YORK%';
 
/* Find all departments not in New York (list out the department name in 
   alphabetical order) How would you make it come out in reverse alphabetical 
   order? */

SELECT dept.dname, dept.loc
  FROM dept
 WHERE dept.loc NOT LIKE '%NEW YORK%'
 ORDER BY dept.dname;
 
SELECT dept.dname, dept.loc
  FROM dept
 WHERE dept.loc NOT LIKE '%NEW YORK%'
 ORDER BY dept.dname DESC;
 
/* Find the minimum salary paid to an employee */

SELECT emp.ename, emp.sal
  FROM emp
 WHERE emp.sal IN 
       (SELECT MIN(emp.sal)
          FROM emp);
          
/* Find that employee’s name for above question */

SELECT emp.ename, emp.sal
  FROM emp
 WHERE emp.sal IN 
       (SELECT MIN(emp.sal)
          FROM emp);
          
/* Find all customers who have a credit limit greater than $800.  
   Print out the customers' names and their credit limits. */

SELECT customer.name, customer.creditlimit
  FROM customer
 WHERE customer.creditlimit > 800;
 
/* Find all orders that have more than 4 items on them.  List out the order id*/

SELECT ord.ordid, COUNT(item.itemid) AS itemcount
  FROM ord
 INNER JOIN item
    ON item.ordid = ord.ordid
 GROUP BY ord.ordid
HAVING COUNT(item.itemid) > 4;

/* Find all employees who make more then their manager */

SELECT emp.ename AS EmployeeName, emp.sal AS EmployeeSalary, 
       manager.ename AS ManagerName, manager.sal AS ManagerSalary
  FROM emp
 INNER JOIN emp manager
    ON emp.mgr = manager.empno
 WHERE emp.sal > manager.sal;
 
 /* List out  all employees whose job is Salesman, put in alphabetical 
 order by first name, format the column with heading of Employee First Name */
 
SELECT emp.ename AS "Employee First Name", emp.job AS "Job"
  FROM emp
 WHERE emp.job like 'SALESMAN'
 ORDER BY emp.ename;
 
/* 2.	List all products and their descriptions that have a price start 
date of Feb 15, 2015 or earlier.  List out each product only once. */

SELECT product.prodid AS "Product Name", 
       product.descrip AS "Product Description"
  FROM product
 INNER JOIN (SELECT price.startdate, price.prodid
               FROM price
              WHERE price.startdate <= '2015-02-15') price
    ON price.prodid = product.prodid;
    
SELECT DISTINCT product.prodid AS "Product Name",
       product.descrip AS "Product Description"
  FROM product
 INNER JOIN price
    ON price.prodid = product.prodid
 WHERE price.startdate <= '2015-02-15';
 
/* 3.	List the name of all employees who earn more than any employee 
in the Sales Department in order by sal (the highest salary at the top) 
and use the following column headings Name, Salary. */

SELECT emp.ename AS "Name", emp.sal AS "Salary"
  FROM emp
 WHERE emp.sal > 
       (SELECT MAX(emp.sal)
          FROM emp
         WHERE emp.job like '%SALESMAN%');
         
/* 4.	Find all Products purchased by at least 4 customers */

SELECT product.prodid, COUNT(customer.custid)
  FROM product
 INNER JOIN item
    ON product.prodid = item.prodid
 INNER JOIN ord
    ON ord.ordid = item.ordid
 INNER JOIN customer
    ON customer.custid = ord.custid
 GROUP BY product.prodid
HAVING COUNT(customer.custid) >= 4;

/* 5.	List all employees who work for the Accounting Department or sold 
to customers in MN */

SELECT emp.ename, dept.dname, emp.job
  FROM emp
 INNER JOIN dept
    ON dept.deptno = emp.deptno
 WHERE emp.empno IN
       (SELECT emp.empno
          FROM emp
         INNER JOIN customer
            ON customer.repid = emp.empno
         WHERE customer.state IN ('MN'))
    OR dept.dname LIKE '%ACCOUNTING%';
    
/* 1.	List out all products and their standard prices.  The output should 
include the product description and the standard price only. Order this output 
by product description and within product description by standard price.  Do 
NOT OUTPUT Duplicate rows! */

SELECT DISTINCT product.descrip, price.stdprice
FROM product
INNER JOIN price
ON price.prodid = product.prodid
ORDER BY product.descrip, price.stdprice;
  
/* 2.	List the product descripton, th actual price, the std price and 
the difference between the actual price and stand price for all products on 
an order line.  Order by the difference between the actual price and standard 
price. Do not print out duplicate lines (hint use dinstinct NOT group by)   */

SELECT product.descrip, item.actualprice, price.stdprice, 
       item.actualprice - price.stdprice AS "Price Difference"
FROM product
INNER JOIN price
ON price.prodid = product.prodid
INNER JOIN item
ON item.prodid = product.prodid
ORDER BY "Price Difference";

/* 3.	The repid field in the Customer table represents the employee number 
of the employee assigned to that customer’s account. (Each customer has only 
one account rep.)  List the customer name and employee first name for customers
that have either employee Martin, Turner, or Ward as their representative.  
Order the list by customer name.  Use CUSTOMER and ACCT REP (all upper case) 
as the column headings. */

SELECT customer.name AS "CUSTOMER",
       emp.ename AS "ACCT REP"
FROM customer
INNER JOIN emp
ON emp.empno = customer.repid
WHERE emp.ename IN ('MARTIN', 'TURNER', 'WARD');

/* 4.	List the order ID, product description, and quantity ordered for all 
items that have ever been ordered, except for rackets.  (Thus, exclude all 
products that have the word racket in their description.)  Also exclude those 
order items where the quantity ordered for the item is over 50.  Sort the list
by order ID, low to high. */

SELECT ord.ordid AS "Order ID",
    product.descrip AS "Product Description",
    item.qty AS "Order Quantity"
FROM ord
INNER JOIN
    (SELECT item.ordid, item.prodid, item.qty
    FROM item
    WHERE qty <= 50) item
ON item.ordid = ord.ordid
INNER JOIN
    (SELECT product.prodid, product.descrip
    FROM product
    WHERE product.descrip NOT LIKE '%RACKET%') product
ON product.prodid = item.prodid
ORDER BY ord.ordid DESC;

/* 5.	Calculate the cost of each orderline including the sales tax on the 
items ordered.  Use the tax rate of 5%. List out the prodid, the order id, and
the orderline total plus the sales tax column. */

SELECT ord.ordid AS "Order ID",
    product.prodid AS "Product ID",
    ord.total AS "Total Before Tax",
    (ord.total * .05) AS "Sales Tax",
    (ord.total + (ord.total * .05)) AS "Grand Total"
FROM ord
INNER JOIN item
ON item.ordid = ord.ordid
INNER JOIN product
ON product.prodid = item.prodid;

/* 1) Display the name and job title of all employees who do not have a 
manager */

select emp.ename, emp.job
from emp
where emp.mgr is null;

/* Display the name, salary and commission for all employees
whose commission amount is at least 10% greater than their salary. */

select emp.ename, emp.sal, emp.comm
from emp
where (1.1*emp.sal) < emp.comm;

/* Display the employee number and names for all
employees who earn more than the average salary.
Sort the results in descending order of salary. */

select emp.empno, emp.ename
from emp
where emp.sal > 
    (select avg(emp.sal)
    from emp)
order by sal desc;

/* 4)	Display the employee name and salary of all employees who report
directly to King.*/

select emp.ename, emp.sal
from emp
where emp.mgr in 
    (select emp.empno
    from emp
    where emp.ename = 'KING');
    
/* List out the employee name, job and department location for all employees 
who have the same salary as SCOTT.  DO NOT include SCOTT in the output  */

select emp.ename, emp.job, dept.loc
from emp
inner join dept
on emp.deptno = dept.deptno
where emp.sal in 
    (select emp.sal
    from emp
    where emp.ename = 'SCOTT')
and emp.ename <> 'SCOTT';

/* 6)	List the department names of the departments where no salesmen work */

select distinct dept.dname
from dept
where dept.deptno not in
    (select emp.deptno
    from emp
    where emp.job = 'SALESMAN');
    
/*) List all departments (their names and locations), 
the average salary in that department and the total number 
of employees that work in each department.  Only include those departments 
that have at least 4 employees working for them. */

select dept.dname, dept.loc, round(avg(emp.sal),2), count(emp.empno)
from dept
inner join emp
on emp.deptno = dept.deptno
group by dept.dname, dept.loc
having count(emp.empno) >= 4;

/* Question 7b */
/* List the department (its name and location), the average salary in that 
department and the total number of employees that work in it, for the 
department that has the most employees. */

select dept.dname, dept.loc, round(avg(emp.sal),2), count(emp.empno)
from dept
inner join emp
on emp.deptno = dept.deptno
group by dept.dname, dept.loc
having count(emp.empno) = 
    (select max(count(emp.empno))
    from emp
    group by deptno);
    
/* 1)	Display the manager number and the salary of the lowest paid 
employee for each manager. */

Select mgr, min(sal)
From emp
Group by mgr;

select managers.empno, min(employees.sal)
from emp employees
inner join emp managers
on employees.mgr = managers.empno
group by managers.empno;

/* 2)	List out the employee’s name and department of all employees who 
make more than all the people in department 20 */

select emp.ename, dept.dname
from emp, dept
where emp.deptno = dept.deptno
and emp.sal > 
    (select max(emp.sal)
    from emp, dept
    where emp.deptno = dept.deptno
    and dept.deptno = 20);
    
    
Select ename, deptno
From emp
Where sal  > (select max(sal)
		From emp
			Where deptno = 20);
    
/* Question 3 */
/* What department has the highest average salary.
   List the department number and the average salary. */
   
select dept.deptno, round(avg(emp.sal),2)
from dept
inner join emp
on emp.deptno = dept.deptno
group by dept.deptno
having avg(emp.sal) = 
    (select max(avg(emp.sal))
    from emp, dept
    where emp.deptno = dept.deptno
    group by dept.deptno);

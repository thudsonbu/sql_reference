/* Question 1 Thomas Hudson */

/* Write  a SQL query to display sales representative names who are serving
   3 or more customers. */

/* Number of Records Produced: 2 Records */
SELECT emp.ename, COUNT(customer.custid) AS custcount FROM emp
INNER JOIN customer ON customer.repid = emp.empno
GROUP BY emp.ename
HAVING COUNT(customer.custid) >= 3;

/* Question 2 Thomas Hudson */

/* Write a query that displays the product description, average standard price 
and average quantity for each product excluding junior racket and tennis net. 
Order results by product description. Round averages to whole number. */

/* Number of Records Produced: 8 Records */

SELECT product.descrip, ROUND(AVG(price.stdprice),0) AS price, ROUND(AVG(item.qty),0) AS quanity FROM product
INNER JOIN price ON product.prodid = price.prodid
INNER JOIN item ON product.prodid = item.prodid
WHERE product.descrip NOT IN ('SP JUNIOR RACKET', 'ACE TENNIS NET')
GROUP BY product.descrip
ORDER BY product.descrip;

/* Question 3 Thomas Hudson */

/* Write a query that displays order id, actual price, standard price and 
quantity over 500 units. Sort records in descending order by product 
description */

/* Number of Records Produced: 5 Records */

SELECT ord.ordid, item.actualprice, price.stdprice, item.qty FROM ord
INNER JOIN item ON ord.ordid = item.ordid
INNER JOIN product ON item.prodid = product.prodid
INNER JOIN price ON product.prodid = price.prodid
WHERE item.qty > 500
ORDER BY product.descrip DESC;

/* Question 4 Thomas Hudson */

/* Write a query that displays sales representative name, customer city, and 
zip for customers who are served by sales representatives Allen, Turner or Ward.
Demonstrate the use of the IN operator. Results for the zip code column must 
not include the numbers 3 or 5 anywhere in zip code. Order by customer name. */

/* Number of Records Produced: 2 Records */

SELECT emp.ename, customer.city, customer.zip FROM emp
INNER JOIN customer ON emp.empno = customer.repid
WHERE emp.ename IN ('ALLEN', 'TURNER', 'WARD')
    AND customer.zip NOT LIKE '%5%' 
    AND customer.zip NOT LIKE '%3%'
ORDER BY customer.name;

/* Question 5 Thomas Hudson */

/* Write a query that displays ship date, product description, and item total 
excluding product descriptions with the word Tennis in the description. Results 
should not show any ship date that took place in the month of February. Sort 
the list by order ID and demonstrate the use of UPPER function. */

/* Number of Records Produced: 7 Records */

SELECT ord.shipdate, product.descrip, item.itemtot FROM ord
 INNER JOIN item ON ord.ordid = item.ordid
 INNER JOIN product ON item.prodid = product.prodid
 WHERE product.descrip NOT LIKE UPPER('%tennis%')
   AND ord.shipdate NOT LIKE '_____%02%___'
 ORDER BY ord.ordid;


/* Question 6 Thomas Hudson */

/* Write a query that shows the customer state, and order id. Add a third 
column showing the number of items (i.e., how many items) for those orders that 
have 6 or more items in each. Sort records on state column. */

/* Number of Records Produced: 2 Records */
     
SELECT customer.state, ord.ordid, COUNT(item.itemid) AS Item FROM customer
INNER JOIN ord ON customer.custid = ord.custid
INNER JOIN item ON ord.ordid = item.ordid
GROUP BY ord.ordid, customer.state
HAVING COUNT(item.itemid) >= 6
ORDER BY customer.state;

/* Question 7 Thomas Hudson */

/* Write a query that shows employee name, and manager name for those employees 
whose individual monthly salary is more than their manager salary. The database 
stores monthly salary per each employee. */

/* Number of Records Produced: 2 Records */

SELECT employee.ename as subordinate, manager.ename as manager FROM emp employee
INNER JOIN emp manager on employee.mgr = manager.empno
WHERE employee.sal > manager.sal;
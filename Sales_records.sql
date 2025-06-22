--1 write a SQL query to find the salesperson and customer who reside in the same city. Return Salesman, cust_name and city.

SELECT s.name, c.customer_name, s.city
FROM [dbo].[Customer$] c
INNER JOIN [dbo].[Salesman$] s
ON c.city = s.city;

--2 write a SQL query to find those orders where the order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city.

SELECT o.ordernumber AS OrderNumber, o.purchase_amount AS OrderAmount,c.customer_name AS Customer_Name, c.city AS City
FROM [dbo].[Order$] o
INNER JOIN [dbo].[Customer$] c ON o.customer_id = c.customer_id
WHERE purchase_amount >= 500
AND purchase_amount <= 2000;

--3 write a SQL query to find the salesperson(s) and the customer(s) he represents. Return Customer Name, city, Salesman, commission.

SELECT c.customer_name AS Customer_Name, c.city AS City, s.salesman_id AS Salesman_ID, s.commission AS Commission
FROM [dbo].[Customer$] c
INNER JOIN [dbo].[Salesman$] s ON c.city = s.city;

--4 write a SQL query to find salespeople who received commissions of more than 12 percent from the company. Return Customer Name, customer city, Salesman, commission.  

SELECT c.customer_name AS Customer_Name, c.city AS City, s.salesman_id AS Salesman_ID, s.commission AS Commission
FROM [dbo].[Customer$] c
INNER JOIN [dbo].[Salesman$] s ON c.salesman_id = s.salesman_id
WHERE s.commission*100 > 12;

--5 write a SQL query to locate those salespeople who do not live in the same city 
--where their customers live and have received a commission of more than 12% from
--the company. Return Customer Name, customer city, Salesman, salesman city, commission.

SELECT c.customer_name AS [Customer Name], c.city AS [Customer City], s.name AS Salesman, s.city AS [Salesman City], s.commission AS Commission
FROM [dbo].[Customer$] c
INNER JOIN [dbo].[Salesman$] s ON c.salesman_id = s.salesman_id
WHERE c.city != s.city
AND s.commission > 0.12

--6 write a SQL query to find the details of an order. Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission

SELECT o.ordernumber AS Order_no, o.[order date] AS Order_date, o.purchase_amount AS Purchase_amt, c.customer_name AS Customer_name, c.grade AS Grade, s.name AS Salesman, s.commission AS Commission
FROM [dbo].[Order$] o
LEFT JOIN [dbo].[Salesman$] s ON o.salesman_id = s.salesman_id
LEFT JOIN [dbo].[Customer$] c ON o.customer_id = c.customer_id;

--7 Write a SQL statement to join the tables salesman, customer and orders
-- so that the same column of each table appears once and only the relational rows are returned.

SELECT 
    c.customer_id AS Customer_ID, o.ordernumber AS Order_no, o.[order date] AS
    Order_date, o.purchase_amount AS Purchase_amt, c.customer_name AS Customer_Name,
    c.city AS Customer_city, c.grade AS Grade, s.salesman_id AS Salesman_ID,
    s.name AS Salesman,s.city AS Salesman_city, s.commission AS Commission
FROM [dbo].[Order$] o
FULL JOIN [dbo].[Salesman$] s ON o.salesman_id = s.salesman_id
FULL JOIN [dbo].[Customer$] c ON o.customer_id = c.customer_id;

--8 Write a SQL query to display the customer name, customer city, grade, salesman, salesman city. 
--The results should be sorted by ascending customer_id.

SELECT c.customer_name AS Customer_name, c.grade AS Grade,
       s.name AS Salesman, s.city AS Salesman_city
    FROM [dbo].[Customer$] c
    INNER JOIN [dbo].[Salesman$] s ON c.salesman_id = s.salesman_id
    ORDER BY c.customer_name ASC;

--9 write a SQL query to find those customers with a grade less than 300.
--Return cust_name, customer city, grade, Salesman, salesmancity.
--The result should be ordered by ascending customer_id.

SELECT c.customer_name AS Customer_name, c.city AS Customer_city,
       c.grade AS Grade, s.name AS Salesman, s.city AS Salesman_city
FROM [dbo].[Customer$] c
LEFT JOIN [dbo].[Salesman$] s ON c.salesman_id = s.salesman_id
WHERE c.grade < 300;

--BONUS
INSERT INTO [dbo].[Customer$] (Customer_ID, Customer_name, City, Grade, Salesman_id)
VALUES (3010, 'Florian Wirtz', 'Liverpool', 350, NULL),
       (3011, 'Milos Kerkez', 'Bournemouth', NULL, NULL);

INSERT INTO [dbo].[Order$](Ordernumber, purchase_amount, [order date],customer_id)
VALUES (71112, 275, '2012-12-11',3010);

INSERT INTO [dbo].[Salesman$](Salesman_id, name, commission)
VALUES (5010, 'Sung Jin-woo', 0.14);


-- 10 Write a SQL statement to make a report with customer name, city, order number, 
-- order date, and order amount in ascending order according to the order date
-- to determine whether any of the existing customers have placed an order or not.

SELECT c.customer_name AS [Customer Name], c.city AS City, o.ordernumber AS 
       [Order No.], o.[order date] AS [Order Date], o.purchase_amount AS
       [Purchase Amount]
FROM [dbo].[Customer$] c
LEFT JOIN [dbo].[Order$] o ON c.customer_id = o.customer_id
ORDER BY o.[order date] ASC;

-- 11 SQL statement to generate a report with customer name, city, order number, order date,
-- order amount, salesperson name, and commission to determine if any of the existing
-- customers have not placed orders or if they have placed orders through their salesman or by themselves.

SELECT c.customer_name AS [Customer Name], c.city AS City, o.ordernumber AS 
       [Order No.], o.[order date] AS [Order Date], o.purchase_amount AS
       [Purchase Amount], s.name AS Salesman,
       s.commission AS [Salesman Commission]       
FROM [dbo].[Customer$] c
LEFT JOIN [dbo].[Order$] o ON c.customer_id = o.customer_id
LEFT JOIN [dbo].[Salesman$] s ON c.salesman_id = s.salesman_id;


-- 12 Write a SQL statement to generate a list in ascending order of salespersons
-- who work either for one or more customers or have not yet joined any of the customers.

SELECT s.name AS Salesman, c.customer_name AS Customer_name
FROM [dbo].[Salesman$] s
LEFT JOIN [dbo].[Customer$] c ON s.salesman_id = c.salesman_id
ORDER BY s.name ASC;

-- 13 write a SQL query to list all salespersons along with customer name, city, grade, order number, date, and amount.

SELECT s.name AS Salesman, c.customer_name AS Customer_name, 
        c.city AS Customer_city, c.grade AS Grade, o.ordernumber
        AS Order_no, o.[order date] AS Order_date, o.purchase_amount
        AS Purchase_amount
FROM [dbo].[Salesman$] s
LEFT JOIN [dbo].[Customer$] c ON c.salesman_id = s.salesman_id
LEFT JOIN [dbo].[Order$] o ON o.salesman_id = s.salesman_id;

-- 14 Write a SQL statement to make a list for the salesmen who either 
-- work for one or more customers or yet to join any of the customer. 
-- The customer may have placed, either one or more orders on or above 
-- order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.

SELECT s.name AS Salesman, c.customer_name AS Customer_name, 
        c.city AS Customer_city, c.grade AS Grade, o.ordernumber
        AS Order_no, o.[order date] AS Order_date, o.purchase_amount
        AS Purchase_amount
FROM [dbo].[Salesman$] s
LEFT JOIN [dbo].[Customer$] c ON c.salesman_id = s.salesman_id
LEFT JOIN [dbo].[Order$] o ON o.salesman_id = s.salesman_id
WHERE o.purchase_amount >= 2000
AND grade IS NOT NULL;

-- BONUS
INSERT INTO [dbo].[Order$](ordernumber, purchase_amount, [order date], customer_id, salesman_id)
VALUES (76543, 5144, '2013-09-10',3121, 5005);

-- 15 For those customers from the existing list who put one or more orders, 
-- or which orders have been placed by the customer who is not on the list, 
-- create a report containing the customer name, city, order number, order date, and purchase amount

SELECT 
    c.customer_name AS Customer_name, 
    c.city AS Customer_city,
    o.ordernumber AS Order_no,
    o.[order date] AS [Order Date], 
    o.purchase_amount AS Purchase_amt
FROM  [dbo].[Order$] o
LEFT JOIN [dbo].[Customer$] c  ON o.customer_id = c.customer_id
WHERE o.customer_id IS NOT NULL;

-- 16 Write a SQL statement to generate a report with the customer name,
-- city, order no. order date, purchase amount for only those customers 
-- on the list who must have a grade and placed one or more orders or which
-- order(s) have been placed by the customer who neither is on the list nor has a grade.

SELECT 
    c.customer_name AS Customer_name, 
    c.city AS Customer_city,
    o.ordernumber AS Order_no,
    o.[order date] AS [Order Date], 
    o.purchase_amount AS Purchase_amt
FROM  [dbo].[Order$] o
LEFT JOIN [dbo].[Customer$] c ON o.customer_id = c.customer_id
WHERE (c.customer_id IS NOT NULL AND c.grade IS NOT NULL)
OR (c.customer_id IS NULL AND c.grade IS NULL);
    
-- 17 Write a SQL query to combine each row of the salesman table with each row of the customer table.

SELECT 
    s.salesman_id,
    s.name AS Salesman_Name,
    s.city AS Salesman_City,
    s.commission,
    c.customer_id,
    c.customer_name,
    c.city AS Customer_City,
    c.grade
FROM [dbo].[Salesman$] s
CROSS JOIN [dbo].[Customer$] c;

-- 18 Write a SQL statement to create a Cartesian product between salesperson and customer,
-- i.e. each salesperson will appear for all customers and vice versa for that salesperson who belongs to that city.

SELECT
    s.salesman_id,
    s.name AS Salesman_Name,
    s.city AS Salesman_City,
    s.commission,
    c.customer_id,
    c.customer_name,
    c.city AS Customer_City,
    c.grade
FROM [dbo].[Salesman$] s
CROSS JOIN [dbo].[Customer$] c
WHERE s.city = c.city;

-- 19 Write a SQL statement to create a Cartesian product between salesperson
-- and customer, i.e. each salesperson will appear for every customer and vice
-- versa for those salesmen who belong to a city and customers who require a grade.

SELECT
    s.salesman_id,
    s.name AS Salesman_Name,
    s.city AS Salesman_City,
    s.commission,
    c.customer_id,
    c.customer_name,
    c.city AS Customer_City,
    c.grade
FROM [dbo].[Salesman$] s
CROSS JOIN [dbo].[Customer$] c
WHERE s.city = c.city
AND c.grade IS NULL;

-- 20 Write a SQL statement to make a Cartesian product between salesman 
-- and customer i.e. each salesman will appear for all customers and vice
-- versa for those salesmen who must belong to a city which is not the same
-- as his customer and the customers should have their own grade.

SELECT
    s.salesman_id,
    s.name AS Salesman_Name,
    s.city AS Salesman_City,
    s.commission,
    c.customer_id,
    c.customer_name,
    c.city AS Customer_City,
    c.grade
FROM [dbo].[Salesman$] s
CROSS JOIN [dbo].[Customer$] c
WHERE s.city != c.city
AND c.grade IS NOT NULL;

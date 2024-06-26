USE TechShop
/*1 Write an SQL query to retrieve a list of all orders along with customer information (e.g.,
customer name) for each order*/
SELECT 
	O.OrderID,
	O.OrderDate,
	O.TotalAmount,
	C.FirstName+' '+C.LastName AS CustomerName,
	C.Email,
	C.Phone,
	C.Address
FROM Orders AS O
JOIN Customers AS C ON C.CustomerID = O.CustomerID;

/*2. Write an SQL query to find the total revenue generated by each electronic gadget product.
Include the product name and the total revenue.*/
SELECT P.ProductID,P.ProductName, 
SUM(OD.Quantity*P.Price) AS Revenue
FROM Products AS P
LEFT JOIN OrderDetails AS OD ON OD.ProductID = P.ProductID
GROUP BY P.ProductID, P.ProductName
ORDER BY P.ProductID, Revenue DESC;




/*3. Write an SQL query to list all customers who have made at least one purchase. Include their
names and contact information.*/
SELECT 
    C.FirstName,
    C.LastName,
    C.Email,
    C.Phone,
    C.Address
FROM 
    Customers AS C
JOIN 
    Orders AS O ON C.CustomerID = O.CustomerID
GROUP BY 
    C.FirstName,
    C.LastName,
    C.Email,
    C.Phone,
    C.Address

/*4. Write an SQL query to find the most popular electronic gadget, which is the one with the highest
total quantity ordered. Include the product name and the total quantity ordered.*/
SELECT P.ProductName, SUM(OD.Quantity) FROM  Products AS P
JOIN OrderDetails AS OD 
ON OD.ProductID = P.ProductID
group by p.ProductName
ORDER BY OD.Quantity DESC;

SELECT   p.ProductName, SUM(od.Quantity) AS TotalQuantityOrdered
FROM OrderDetails od
INNER JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantityOrdered DESC;

/*5. Write an SQL query to retrieve a list of electronic gadgets along with their corresponding
categories*/
ALTER TABLE Products
ADD Category VARCHAR(20)
UPDATE Products
SET Category = 
    CASE 
        WHEN Description LIKE '%smartphone%' THEN 'Electronics'
        WHEN Description LIKE '%laptop%' THEN 'Electronics'
        WHEN Description LIKE '%headphones%' THEN 'Electronics'
        WHEN Description LIKE '%smart watch%' THEN 'Electronics'
        WHEN Description LIKE '%tablet%' THEN 'Electronics'
        WHEN Description LIKE '%digital camera%' THEN 'Electronics'
        WHEN Description LIKE '%gaming console%' THEN 'Electronics'
        WHEN Description LIKE '%bluetooth speaker%' THEN 'Electronics'
        WHEN Description LIKE '%external hard drive%' THEN 'Electronics'
        WHEN Description LIKE '%wireless router%' THEN 'Electronics'
        WHEN Description LIKE '%fitness tracker%' THEN 'Electronics'
        WHEN Description LIKE '%smart home hub%' THEN 'Electronics'
        WHEN Description LIKE '%wireless earbuds%' THEN 'Electronics'
        WHEN Description LIKE '%monitor%' THEN 'Electronics'
        WHEN Description LIKE '%printer%' THEN 'Electronics'
		WHEN Description LIKE '%scanner%' THEN 'Electronics'
        ELSE 'Other'
    END;
SELECT ProductName, Category FROM Products


/*6. Write an SQL query to calculate the average order value for each customer. Include the
customer's name and their average order value.*/

/*CHECK!!!!!!!*/

SELECT 
    C.CustomerID,
    C.FirstName,
    C.LastName,
    AVG(O.TotalAmount) AS AverageOrderValue
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName;

SELECT ProductName FROM Products
WHERE ProductID NOT IN (SELECT ProductID FROM OrderDetails)
/*7. Write an SQL query to find the order with the highest total revenue. Include the order ID,
customer information, and the total revenue.
*/
SELECT TOP 1
	C.FirstName, C.LastName,
	O.OrderID, SUM(O.TotalAmount) AS Revenue
FROM Customers AS C
JOIN Orders AS O ON O.CustomerID = C.CustomerID
GROUP BY
	C.FirstName, C.LastName, O.OrderID
ORDER BY Revenue DESC

/*8. . Write an SQL query to list electronic gadgets and the number of times each product has been
ordered*/
SELECT P.ProductName, COUNT(OD.ProductID) CountOfProducts FROM Products AS P
JOIN OrderDetails AS OD ON OD.ProductID = P.ProductID
GROUP BY P.ProductName

/*9. Write an SQL query to find customers who have purchased a specific electronic gadget product.
Allow users to input the product name as a parameter.*/
CREATE PROCEDURE FindCustomer
	@ProductName VARCHAR(20)
AS 
BEGIN
	SELECT C.FirstName+' '+C.LastName AS CustomerName,
		P.ProductName	
	FROM Customers AS C
	JOIN Orders AS O ON O.CustomerID = C.CustomerID
	JOIN OrderDetails AS OD ON OD.OrderID = O.OrderID
	JOIN Products AS P ON P.ProductID = OD.ProductID
	WHERE P.ProductName = @ProductName
END;
EXEC FindCustomer @ProductName = 'Smartphone'
select * from OrderDetails
SELECT * FROM Products

drop procedure FindCustomer

select * from OrderDetails
where ProductID = 1
/* 10. Write an SQL query to calculate the total revenue generated by all orders placed within a
specific time period. Allow users to input the start and end dates as parameters.
*/
CREATE PROCEDURE CalcTotalRev
	@StartDate DATE,
	@EndDate DATE
AS 
BEGIN
	SELECT SUM(OD.Quantity * P.Price) 'Total Revenue'
	FROM Orders O
	JOIN OrderDetails OD ON OD.OrderID = O.OrderID
	JOIN Products P ON P.ProductID = OD.ProductID
	WHERE
		O.OrderDate>=@StartDate
		AND O.OrderDate<=@EndDate
END;
EXEC CalcTotalRev @StartDate='2024-02-05', @EndDate='2024-02-12';
SELECT * FROM ORDERS
drop procedure CalcTotalRev
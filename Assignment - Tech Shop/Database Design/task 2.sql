use TechShop;
--1
SELECT FirstName+' '+LastName as Name, Email FROM Customers;

--2
SELECT O.OrderID, O.OrderDate, C.FirstName+' '+C.LastName as Name FROM Orders as O
JOIN Customers AS C ON O.OrderID=C.CustomerID;

--3
INSERT INTO Customers VALUES
	(16, 'Srikar', 'Gadiraju', 'srikargs2@gmail.com', '9494-190-667', 'Vijayawada'); 
select * from customers
--4
UPDATE Products
SET Price=Price+Price*10/100
select * from Products
--5
CREATE PROCEDURE DeleteOrderByOrderID
	@OrderID INT
AS
BEGIN 
	DELETE FROM OrderDetails
	WHERE OrderID = @OrderID
	DELETE FROM Orders
	WHERE OrderID = @OrderID
END;
EXEC DeleteOrderByOrderID @OrderID = 15;
select * from OrderDetails
--6
INSERT INTO Orders VALUES
(15, 15, '2024-03-05', 230.99000, 'Shipped');
select * from orders
--7
SELECT * FROM Customers;
CREATE PROCEDURE UpdateInfo
@CustomerID INT, @NewEmail VARCHAR(50),
@NewAddress VARCHAR(100)
AS
BEGIN
	UPDATE Customers
	SET Email = @NewEmail
	WHERE CustomerID = @CustomerID
	UPDATE Customers
	SET Address = @NewAddress
	WHERE CustomerID = @CustomerID
END;
EXEC UpdateInfo 
	@CustomerID = 16, 
	@NewEmail = 'srikargs3@gmail.com', 
	@NewAddress = 'Singh Nagar, Vijayawada, AP';
select * from Customers

--8
select * from ORDERS
select * from OrderDetails
UPDATE Orders
SET TotalAmount = (
    SELECT SUM(Quantity * Products.Price)
    FROM OrderDetails
    INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
    WHERE OrderDetails.OrderID = Orders.OrderID
)
drop procedure DeleteOrders
--9
CREATE PROCEDURE DeleteOrders
@CusID INT
AS
BEGIN
	DELETE FROM OrderDetails
	WHERE OrderID IN(
		SELECT OrderID FROM Orders 
		WHERE CustomerID = @CusID);
	DELETE FROM Orders
	WHERE CustomerID = @CusID
	
END;
EXEC DeleteOrders @CusID = 14;

SELECT * FROM ORDERS
select * from OrderDetails

--10
INSERT INTO Products VALUES
(16, 'Scanner', 'Scans any document', 345.989);

--11
ALTER TABLE Orders
ADD Status VARCHAR(15);
UPDATE Orders
SET Status='Pending'
DECLARE @OID INT = 1
UPDATE Orders
SET Status='Shipped'
WHERE OrderID = @OID
SELECT * FROM ORDERS

--12
ALTER TABLE Customers
ADD NoOfOrders INT
ALTER TABLE Customers
DROP COLUMN NoOfOrders
UPDATE Customers
SET NoOfOrders = COALESCE(OrdersPerCustomer.NoOfOrders, 0)
FROM Customers
JOIN (
    SELECT CustomerID, COUNT(*) AS NoOfOrders
    FROM Orders
    GROUP BY CustomerID
) AS OrdersPerCustomer ON Customers.CustomerID = OrdersPerCustomer.CustomerID;
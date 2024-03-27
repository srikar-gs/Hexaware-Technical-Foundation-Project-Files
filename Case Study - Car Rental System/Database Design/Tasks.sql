use [Car Rental System];
/*1. Update the daily rate for a Mercedes car to 68.*/
UPDATE Vehicle
SET dailyRate = 68
WHERE make = 'Mercedes';
SELECT * FROM Vehicle

/*2. Delete a specific customer and all associated leases and payments.*/
DECLARE @customerID INT = 7
DELETE FROM Payment
WHERE leaseID IN (SELECT leaseID FROM Lease WHERE customerID = @customerID);

DELETE FROM Lease
WHERE customerID = @customerID;

DELETE FROM Customer
WHERE customerID = @customerID;
SELECT * FROM Payment

/*3. Rename the "paymentDate" column in the Payment table to "transactionDate".*/
EXEC sp_rename'Payment.paymentDate', 'transactionDate', 'COLUMN';

/*4. Find a specific customer by email.*/
DECLARE @email VARCHAR(20)= 'sarah@example.com';
SELECT * FROM Customer
WHERE email = @email

/*5. Get active leases for a specific customer.*/
SELECT * FROM Lease
WHERE customerID = 3;

/*6. . Find all payments made by a customer with a specific phone number*/
CREATE PROCEDURE FindPayment
	@PhoneNo VARCHAR(12)
AS 
BEGIN
	SELECT 
		P.paymentID,  
		P.leaseID, 
		P.amount,
		P.transactionDate
	FROM Payment P
	JOIN Lease L ON P.leaseID = L.leaseID
	JOIN Customer C ON C.customerID = L.customerID
	WHERE C.phoneNumber = @PhoneNo
END;
EXEC FindPayment @PhoneNo = '555-555-5555';

/*7. Calculate the average daily rate of all available cars.*/
SELECT ROUND(AVG(dailyRate), 2) AvgDailyRate FROM Vehicle
WHERE available = 1;

/*8. Find the car with the highest daily rate.*/SELECT TOP 1 	make+' '+model Vehicle, dailyRate FROM VehicleORDER BY dailyRate DESC;/*9. Retrieve all cars leased by a specific customer.*/SELECT V.* FROM Vehicle VJOIN Lease L ON L.VehicleID = V.vehicleIDWHERE L.customerID = 3/*10. Find the details of the most recent lease*/SELECT TOP 1 * FROM LEASEORDER BY startDate DESC;/*11. List all payments made in the year 2023.*/SELECT * FROM PaymentWHERE YEAR(transactionDate) = 2023;/*12. Retrieve customers who have not made any payments.*/
SELECT * FROM Customer
WHERE customerID NOT IN(
	SELECT customerID FROM Lease)

/*13. Retrieve Car Details and Their Total Payments*/
SELECT V.vehicleID, V.make, V.model, 
	SUM(P.amount) TotalPayments
FROM Vehicle V
JOIN LEASE L ON L.VehicleID = V.vehicleID
JOIN Payment P ON P.leaseID = L.leaseID
GROUP BY V.vehicleID, V.make, V.model;

/*14. Calculate Total Payments for Each Customer.*/
SELECT 
	C.customerID,
	C.firstName, C.lastName,
	SUM(P.amount)
FROM Customer C
JOIN Lease L ON L.customerID = C.customerID
JOIN Payment P ON P.leaseID = L.leaseID
GROUP BY C.customerID, C.firstName, C.lastName

/*15. 
List Car Details for Each Lease.*/
SELECT 
    l.leaseID,
    v.vehicleID,
    v.make,
    v.model,
    v.year
FROM 
    Lease l
JOIN 
    Vehicle v ON l.vehicleID = v.vehicleID

/*16. Retrieve Details of Active Leases with Customer and Car Information.*/
SELECT 
	C.customerID, C.firstName+' '+C.lastName CustomerName,
	V.vehicleID, V.make+' '+V.model VehicleName
FROM Customer C
JOIN Lease L ON L.customerID = C.customerID
JOIN Vehicle V ON V.vehicleID = L.VehicleID

/*17. Find the Customer Who Has Spent the Most on Leases.*/
SELECT TOP 1 C.*, P.amount FROM Customer C
JOIN Lease L ON L.customerID = C.customerID
JOIN Payment P ON P.leaseID = L.leaseID
ORDER BY P.amount DESC

/*18. List All Cars with Their Current Lease Information.*/
SELECT V.*, L.* FROM Vehicle V
JOIN Lease L ON L.VehicleID = V.vehicleID






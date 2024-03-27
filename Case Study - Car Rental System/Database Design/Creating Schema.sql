CREATE TABLE Vehicle(
	vehicleID INT PRIMARY KEY NOT NULL,
	make VARCHAR(20),
	model VARCHAR(20),
	year INT,
	dailyRate FLOAT,
	available BIT,
	passengerCapacity SMALLINT,
	engineCapacity INT);

CREATE TABLE Customer(
	customerID INT PRIMARY KEY NOT NULL,
	firstName VARCHAR(30),
	lastName VARCHAR(30),
	email VARCHAR(50),
	phoneNumber VARCHAR(15));

CREATE TABLE Lease(
	leaseID INT PRIMARY KEY NOT NULL,
	VehicleID INT FOREIGN KEY REFERENCES Vehicle(VehicleID),
	customerID INT FOREIGN KEY REFERENCES Customer(customerID),
	startDate DATE,
	endDate DATE,
	leaseType VARCHAR(10));

CREATE TABLE Payment(
	paymentID INT PRIMARY KEY NOT NULL,
	leaseID INT REFERENCES Lease(leaseID),
	paymentDate DATE,
	amount FLOAT);
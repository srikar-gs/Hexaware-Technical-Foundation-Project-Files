create table Customers(
CustomerID int PRIMARY KEY NOT NULL,
FirstName varchar(20) NOT NULL,
LastName varchar(20) NOT NULL,
Email varchar(30),
Phone int,
Address varchar(20));

create table Products(
ProductID int PRIMARY KEY NOT NULL,
ProductName varchar(50),
Description varchar(80),
Price DECIMAL(10, 2);

create table Orders(
OrderID int PRIMARY KEY NOT NULL,
CustomerID int FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
OrderDate DATE,
TotalAmount DECIMAL(10, 2));

create table OrderDetails(
OrderDetailID int PRIMARY KEY NOT NULL,
OrderID int FOREIGN KEY (OrderID) references Orders(OrderID),
ProductID int foreign key(ProductID) references Products(ProductID),
Quantity int);

create table Inventory(
InventoryID int PRIMARY KEY NOT NULL,
ProductID int foreign key (ProductID) references Products(ProductID),
QuantityInStock int,
LastStockUpdate int);
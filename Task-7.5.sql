create database shopDB;
Go

create table Categories(
CategoryID int primary key,
CategoryName nvarchar(100)
);

create table Products(
ProductID int primary key,
ProductName nvarchar(100),
Price Decimal(10,2) check (price > 0),
Stock int check (stock >=0),
CategoryID int,
Foreign key (CategoryID) references categories(CategoryID)
);

create table customers (
CustomerID int primary key,
FullName nvarchar(100),
Email nvarchar(100) unique
);

create table orders(
orderID int primary key,
CustomerID int,
orderDate Date default getdate(),
Foreign key (CustomerID) references Customers(CustomerID)
);

create table orderItems(
orderItemID int primary key,
OrderID int,
ProductID int,
Quantity int check (Quantity > 0),
Foreign key (orderID) references orders(OrderID),
Foreign key (productID) references products(productID)
);

insert into Categories (CategoryID, CategoryName)
values
(1, 'Electronics'),
(2, 'Books'),
(3, 'Clothing'),
(4, 'Home Appliances');

insert into Products(ProductID,ProductName,Price,Stock,CategoryID)
values
(1, 'Laptop', 1500.00, 10, 1),
(2, 'Mouse', 25.00, 50, 1),
(3, 'Keyboard', 45.00, 30, 1),
(4, 'SQL Server Book', 35.00, 20, 2),
(5, 'Java Book', 28.00, 15, 2),
(6, 'T-shirt', 20.00, 40, 3),
(7, 'Jeans', 55.00, 25, 3),
(8, 'Coffee Maker', 80.00, 12, 4);

insert into customers(CustomerID, FullName,Email)
values
(1, 'Aysel Aliyeva', 'aysel@gmail.com'),
(2, 'Elvin Mammadov', 'elvin@gmail.com'),
(3, 'Nigar Hasanli', 'nigar@gmail.com'),
(4, 'Rauf Karimov', 'rauf@gmail.com'),
(5, 'Leyla Huseynova', 'leyla@gmail.com');

INSERT INTO Orders (OrderId, CustomerId, orderDate)
VALUES
(1, 1, '2026-11-01'),
(2, 2, '2026-11-02'),
(3, 1, '2026-11-03'),
(4, 3, '2026-11-04'),
(5, 4, '2026-11-05');

INSERT INTO OrderItems (OrderItemId, OrderId, ProductId, Quantity)
VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 4, 1),
(4, 2, 5, 2),
(5, 3, 3, 1),
(6, 3, 2, 1),
(7, 4, 6, 3),
(8, 4, 7, 1),
(9, 5, 8, 1),
(10, 5, 2, 3);

Select
Categories.CategoryName,
Products.ProductName,
Products.Price
from Products
inner join Categories
on Products.CategoryID = Categories.CategoryID
order by Products.Price DESC;

select
Categories.CategoryName,
COUNT(products.ProductID) AS ProductCount,
AVG(Products.Price) AS AveragePrice
from Categories
left join Products
on Categories.CategoryID = Products.CategoryID
group by Categories.CategoryName;

select
orders.orderID,
Sum(Products.Price * orderItems.Quantity) AS TotalAmount
from orders
inner join orderItems
on orders.orderID = orderItems.OrderID
inner join Products
on orderItems.ProductID = Products.ProductID
group by orders.orderID;

select
customers.CustomerID,
customers.FullName
from customers
left join orders
on customers.CustomerID = orders.CustomerID
where orders.orderID is null;

select Top 3
Products.ProductName,
Sum(OrderItems.Quantity) AS TotalSold
from orderItems
inner join Products
on orderItems.ProductID = Products.ProductID
group by Products.ProductName
order by TotalSold DESC;
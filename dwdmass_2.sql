create database dwdmass_2;

use dwdmass_2;

-- Create Customers Dimension Table
CREATE TABLE CustomersDim (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL,
    BillingAddress VARCHAR(255),
    ShippingAddress VARCHAR(255)
);

-- Create Products Dimension Table
CREATE TABLE ProductsDim (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    ProductCategory VARCHAR(255),
    UnitPrice DECIMAL(10,2)
);

-- Create Sales Representatives Dimension Table
CREATE TABLE SalesRepsDim (
    SalesRepID INT PRIMARY KEY,
    SalesRepName VARCHAR(255) NOT NULL
);

-- Create Promotions Dimension Table
CREATE TABLE PromotionsDim (
    PromotionID INT PRIMARY KEY,
    PromotionDescription VARCHAR(255),
    DiscountPercent DECIMAL(5,2)
);

-- Create Orders Fact Table
CREATE TABLE OrdersFact (
    OrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    ShipDate DATE,
    CustomerID INT,
    ProductID INT,
    SalesRepID INT,
    PromotionID INT,
    Quantity INT NOT NULL,
    GrossAmount DECIMAL(10,2) NOT NULL,
    Discount DECIMAL(5,2),
    -- Define foreign key relationships
    FOREIGN KEY (CustomerID) REFERENCES CustomersDim(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES ProductsDim(ProductID),
    FOREIGN KEY (SalesRepID) REFERENCES SalesRepsDim(SalesRepID),
    FOREIGN KEY (PromotionID) REFERENCES PromotionsDim(PromotionID)
);

-- Insert into Customers Dimension
INSERT INTO CustomersDim (CustomerID, CustomerName, BillingAddress, ShippingAddress)
VALUES
(1, 'John Doe', '123 Elm St, Springfield', '123 Elm St, Springfield'),
(2, 'Vineet', '456 Maple Ave, Centerville', '456 Maple Ave, Centerville'),
(3, 'Raju', '789 Oak Blvd, Metropolis', '101 First St, Metropolis'),
(4, 'Acme Corp', '789 Oak Blvd, Metropolis', '101 First St, Metropolis'),
(5, 'Shamu', '789 Oak Blvd, Metropolis', '101 First St, Metropolis');

-- Insert into Products Dimension
INSERT INTO ProductsDim (ProductID, ProductName, ProductCategory, UnitPrice)
VALUES
(1, 'Laptop', 'Electronics', 1000.00),
(2, 'Smartphone', 'Electronics', 2000.00),
(3, 'Smartphone', 'Electronics', 1600.00),
(4, 'Smartphone', 'Electronics', 1800.00),
(5, 'Tablet', 'Electronics', 600.00);

-- Insert into Sales Representatives Dimension
INSERT INTO SalesRepsDim (SalesRepID, SalesRepName)
VALUES
(1, 'Alice Johnson'),
(2, 'Alef Garcia'),
(3, 'Anna Ali'),
(4, 'Ailsa Kim'),
(5, 'Bob Williams');

-- Insert into Promotions Dimension
INSERT INTO PromotionsDim (PromotionID, PromotionDescription, DiscountPercent)
VALUES
(1, 'New Year Promo', 10.00),
(2, 'Black Friday Sale', 15.00),
(3, 'Black Friday Sale', 25.00);

-- Insert into Orders Fact Table
INSERT INTO OrdersFact (OrderID, OrderDate, ShipDate, CustomerID, ProductID, SalesRepID, PromotionID, Quantity, GrossAmount, Discount)
VALUES
(1, '2024-01-10', '2024-01-12', 1, 1, 1, 1, 2, 2000.00, 200.00),  -- John buys 2 laptops, New Year Promo
(2, '2024-01-15', '2024-01-17', 2, 2, 2, 2, 1, 800.00, 120.00),   -- Jane buys 1 smartphone, Black Friday Sale
(3, '2024-01-18', '2024-01-19', 3, 3, 1, 1, 3, 3000.00, 300.00),  -- Acme buys 5 tablets, New Year Promo
(4, '2024-01-20', '2024-01-22', 1, 2, 2, 3, 1, 800.00, 0.00),     -- John buys 1 smartphone, No Promotion
(5, '2024-01-10', '2024-01-12', 1, 3, 3, 1, 2, 2000.00, 200.00),
(6, '2024-01-10', '2024-01-12', 1, 4, 1, 1, 2, 2000.00, 200.00),
(7, '2024-01-10', '2024-01-12', 4, 1, 5, 1, 2, 2000.00, 200.00),
(8, '2024-01-10', '2024-01-12', 1, 5, 1, 3, 3, 2000.00, 200.00),
(9, '2024-01-10', '2024-01-12', 5, 1, 1, 3, 2, 2000.00, 200.00),
(10, '2024-01-25', '2024-01-28', 2, 3, 1, 2, 3, 1800.00, 270.00);  

SELECT 
    c.CustomerName, 
    p.ProductName, 
    promo.PromotionDescription, 
    s.SalesRepName,
    SUM(o.Quantity) AS TotalQuantity,
    SUM(o.GrossAmount) AS GrossAmount,
    SUM(o.Discount) AS TotalDiscount,
    (SUM(o.GrossAmount) - SUM(o.Discount)) AS NetAmount
FROM 
    OrdersFact o
JOIN 
    CustomersDim c ON o.CustomerID = c.CustomerID
JOIN 
    ProductsDim p ON o.ProductID = p.ProductID
JOIN 
    SalesRepsDim s ON o.SalesRepID = s.SalesRepID
LEFT JOIN 
    PromotionsDim promo ON o.PromotionID = promo.PromotionID
GROUP BY 
    c.CustomerName, p.ProductName, promo.PromotionDescription, s.SalesRepName
ORDER BY 
    NetAmount DESC;

select * from CustomersDim;

select * from ProductsDim;

select * from SalesRepsDim;

select * from PromotionsDim;
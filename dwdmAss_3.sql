create database dwdmAss_3;

use dwdmAss_3;

CREATE TABLE BookType (
    BookTypeID INT PRIMARY KEY,
    BookTypeName VARCHAR(255)
);

CREATE TABLE Location (
    LocationID INT PRIMARY KEY,
    LocationName VARCHAR(255)
);

CREATE TABLE Author (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(255),
    Age INT,
    Country VARCHAR(255)
);

CREATE TABLE Publication (
    PublicationID INT PRIMARY KEY,
    PublicationName VARCHAR(255),
    Country VARCHAR(255),
    Year INT
);

-- Fact Table
CREATE TABLE BookSales (
    SaleID INT PRIMARY KEY,
    BookTypeID INT,
    LocationID INT,
    AuthorID INT,
    PublicationID INT,
    Quantity INT,
    Profit DECIMAL(10, 2),
    FOREIGN KEY (BookTypeID) REFERENCES BookType(BookTypeID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID),
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID),
    FOREIGN KEY (PublicationID) REFERENCES Publication(PublicationID)
);


INSERT INTO BookType (BookTypeID, BookTypeName) VALUES
(1, 'Fiction'),
(2, 'Non-Fiction'),
(3, 'Science Fiction'),
(4, 'Fantasy'),
(5, 'Encyclopedia');

INSERT INTO Location (LocationID, LocationName) VALUES
(1, 'New York'),
(2, 'Los Angeles'),
(3, 'Chicago'),
(4, 'Delhi'),
(5, 'London');


INSERT INTO Author (AuthorID, AuthorName, Age, Country) VALUES
(1, 'John Doe', 45, 'USA'),
(2, 'Jane Smith', 38, 'UK'),
(3, 'Emily Johnson', 29, 'Canada'),
(4, 'Samit Basu', 36, 'Delhi'),
(5, 'Christopher Hibbert', 30, 'London');

INSERT INTO Publication (PublicationID, PublicationName, Country, Year) VALUES
(1, 'Penguin Books', 'UK', 2020),
(2, 'HarperCollins', 'USA', 2019),
(3, 'Random House', 'Canada', 2021),
(4, 'National Book Trust', 'Delhi', 2022),
(5, 'Simon and Schuster', 'London', 2023);


INSERT INTO BookSales (SaleID, BookTypeID, LocationID, AuthorID, PublicationID, Quantity, Profit) VALUES
(1, 1, 1, 1, 1, 100, 500.00),
(2, 2, 2, 2, 2, 150, 300.00),
(3, 3, 3, 3, 3, 200, 700.00),
(4, 1, 1, 2, 1, 120, 600.00),
(5, 2, 3, 1, 2, 130, 350.00),
(6, 4, 4, 4, 4, 130, 550.00),
(7, 5, 5, 5, 5, 130, 250.00),
(8, 3, 3, 1, 2, 130, 150.00),
(9, 4, 3, 1, 2, 130, 750.00),
(10, 5, 3, 1, 2, 130, 950.00);

-- Quantity and Profit per Book Type
SELECT
    bt.BookTypeName,
    SUM(bs.Quantity) AS TotalQuantity,
    SUM(bs.Profit) AS TotalProfit
FROM
    BookSales bs
JOIN
    BookType bt ON bs.BookTypeID = bt.BookTypeID
GROUP BY
    bt.BookTypeName;

-- Quantity and Profit per Location
SELECT
    l.LocationName,
    SUM(bs.Quantity) AS TotalQuantity,
    SUM(bs.Profit) AS TotalProfit
FROM
    BookSales bs
JOIN
    Location l ON bs.LocationID = l.LocationID
GROUP BY
    l.LocationName;

-- Quantity and Profit per Author
SELECT
    a.AuthorName,
    SUM(bs.Quantity) AS TotalQuantity,
    SUM(bs.Profit) AS TotalProfit
FROM
    BookSales bs
JOIN
    Author a ON bs.AuthorID = a.AuthorID
GROUP BY
    a.AuthorName;

-- Quantity and Profit per Publication
SELECT
    p.PublicationName,
    SUM(bs.Quantity) AS TotalQuantity,
    SUM(bs.Profit) AS TotalProfit
FROM
    BookSales bs
JOIN
    Publication p ON bs.PublicationID = p.PublicationID
GROUP BY
    p.PublicationName;
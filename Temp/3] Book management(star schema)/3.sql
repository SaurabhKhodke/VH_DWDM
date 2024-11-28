

CREATE TABLE Dim_Author ( 
    Author_Id INT NOT NULL, 
    Author_Name VARCHAR(30) NOT NULL, 
    Author_Age INT NOT NULL, 
    Author_Country VARCHAR(30) NOT NULL, 
    PRIMARY KEY (Author_Id) 
); 

INSERT INTO Dim_Author VALUES 
(1, 'Amit Garg', 72, 'India'), 
(2, 'JK Rowling', 78, 'UK'), 
(3, 'HC Verma', 80, 'India'), 
(4, 'Cao Xueqin', 42, 'China'), 
(5, 'RK Narayan', 65, 'India'), 
(6, 'Charles Dickens', 59, 'UK'), 
(7, 'CS Lewis', 57, 'UK'), 
(8, 'Sanjesh Pawale', 48, 'India'), 
(9, 'DC Pandey', 76, 'India'), 
(10, 'Dan Brown', 63, 'USA'); 

CREATE TABLE Dim_Location ( 
    Location_Id INT NOT NULL, 
    Location_Country VARCHAR(30) NOT NULL, 
    PRIMARY KEY (Location_Id) 
); 

INSERT INTO Dim_Location VALUES 
(1, 'India'), 
(2, 'UK'), 
(3, 'USA'), 
(4, 'India'), 
(5, 'UK'), 
(6, 'India'), 
(7, 'USA'), 
(8, 'USA'), 
(9, 'India'), 
(10, 'UK'); 

CREATE TABLE Dim_Book ( 
    Book_Id INT NOT NULL, 
    Book_Type VARCHAR(30) NOT NULL, 
    PRIMARY KEY (Book_Id) 
); 

INSERT INTO Dim_Book VALUES 
(1, 'Horror'), 
(2, 'Fantasy'), 
(3, 'Mystery'), 
(4, 'Classics'), 
(5, 'Fiction'), 
(6, 'Adventure'), 
(7, 'Educational'), 
(8, 'Historical'), 
(9, 'Poetry'), 
(10, 'Comedy'); 

CREATE TABLE Dim_Publication ( 
    Publication_Id INT NOT NULL, 
    Publication_Name VARCHAR(30) NOT NULL, 
    Publication_Country VARCHAR(30) NOT NULL, 
    Publication_Year INT NOT NULL, 
    PRIMARY KEY (Publication_Id) 
); 

INSERT INTO Dim_Publication VALUES 
(1, 'Readers Zone', 'UK', 2004), 
(2, 'Arihant', 'India', 1999), 
(3, 'Art Book', 'India', 2006), 
(4, 'Jaico Publishing House', 'India', 1995), 
(5, 'Course Technology', 'USA', 1993), 
(6, 'Pan Macmillan', 'India', 1991), 
(7, 'Penguin Books', 'UK', 2001), 
(8, 'HarperCollins', 'UK', 1994), 
(9, 'Simon & Schuster', 'USA', 1990), 
(10, 'Scholastic', 'USA', 2002); 

CREATE TABLE Fact_BookManagement ( 
    Author_Id INT NOT NULL, 
    Book_Id INT NOT NULL, 
    Location_Id INT NOT NULL, 
    Publication_Id INT NOT NULL, 
    Cost INT NOT NULL, 
    Quantity INT NOT NULL, 
    Profit INT NOT NULL, 
    PRIMARY KEY (Author_Id, Book_Id, Location_Id, Publication_Id),
    FOREIGN KEY (Author_Id) REFERENCES Dim_Author(Author_Id), 
    FOREIGN KEY (Book_Id) REFERENCES Dim_Book(Book_Id), 
    FOREIGN KEY (Location_Id) REFERENCES Dim_Location(Location_Id), 
    FOREIGN KEY (Publication_Id) REFERENCES Dim_Publication(Publication_Id) 
); 

INSERT INTO Fact_BookManagement VALUES 
(1, 7, 2, 3, 1200, 3, 1200), 
(2, 9, 10, 5, 1000, 2, 650), 
(3, 6, 5, 7, 940, 1, 200), 
(4, 1, 8, 9, 1150, 4, 1600), 
(5, 10, 7, 1, 1300, 2, 800), 
(6, 4, 1, 10, 1050, 5, 1550), 
(7, 8, 3, 8, 930, 3, 1090), 
(8, 2, 4, 6, 870, 1, 170), 
(9, 5, 6, 4, 800, 2, 600), 
(10, 3, 9, 2, 900, 3, 900); 

-- Select statements to view data
SELECT * FROM Dim_Author; 
SELECT * FROM Dim_Location; 
SELECT * FROM Dim_Book; 
SELECT * FROM Dim_Publication; 
SELECT * FROM Fact_BookManagement; 

SELECT 
    a.Author_Name,
    b.Book_Type,
    l.Location_Country,
    p.Publication_Name,
    f.Cost,
    f.Quantity,
    f.Profit
FROM 
    Fact_BookManagement f
JOIN 
    Dim_Author a ON f.Author_Id = a.Author_Id
JOIN 
    Dim_Book b ON f.Book_Id = b.Book_Id
JOIN 
    Dim_Location l ON f.Location_Id = l.Location_Id
JOIN 
    Dim_Publication p ON f.Publication_Id = p.Publication_Id;


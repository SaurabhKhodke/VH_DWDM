-- Create Fact Table
CREATE TABLE Fact_Employee_Shift (
    EmployeeId int not null,
    DepartmentId int not null,
    Job_Id int not null,
    Shift_Id int not null,
    Date date not null,
    Overtime int,
    PRIMARY KEY (EmployeeId, DepartmentId, Job_Id, Shift_Id, Date)
);

-- Create Dimension Tables
CREATE TABLE Dim_Employee_Info (
    EmployeeId int not null,
    First_Name varchar(30) not null,
    Last_Name varchar(30) not null,
    Hire_date date not null,
    PRIMARY KEY (EmployeeId)
);

CREATE TABLE Dim_Department_Info (
    DepartmentId int not null,
    DepartmentName varchar(30) not null,
    PlantNo int not null,
    PRIMARY KEY (DepartmentId)
);

CREATE TABLE Dim_Job_Info (
    Job_Id int not null,
    Job_name varchar(30) not null,
    Job_type varchar(30) not null,
    PRIMARY KEY (Job_Id)
);

CREATE TABLE Dim_Shift_Info (
    Shift_Id int not null,
    Shift_Name varchar(30) not null,
    StartTime time not null,
    EndTime time not null,
    PRIMARY KEY (Shift_Id)
);

CREATE TABLE Dim_Shift_Day (
    Shift_Id int not null,
    Day varchar(10) not null,
    PRIMARY KEY (Shift_Id, Day)
);

CREATE TABLE Dim_Shift_Week (
    Shift_Id int not null,
    WeekId int not null,
    PRIMARY KEY (Shift_Id, WeekId)
);

CREATE TABLE Dim_Shift_Month (
    Shift_Id int not null,
    Month varchar(10) not null,
    PRIMARY KEY (Shift_Id, Month)
);

-- Insert Data into Dim_Employee_Info
INSERT INTO Dim_Employee_Info (EmployeeId, First_Name, Last_Name, Hire_date) VALUES
(1, 'Alice', 'Johnson', '2020-01-15'),
(2, 'Bob', 'Smith', '2019-03-22'),
(3, 'Charlie', 'Brown', '2021-06-30'),
(4, 'Diana', 'Prince', '2018-07-19'),
(5, 'Ethan', 'Hunt', '2022-11-05'),
(6, 'Fiona', 'Green', '2020-09-12'),
(7, 'George', 'Clark', '2019-05-16'),
(8, 'Hannah', 'Davis', '2021-12-21'),
(9, 'Ivy', 'Lopez', '2020-04-25'),
(10, 'Jack', 'Martin', '2022-02-10');

-- Insert Data into Dim_Department_Info
INSERT INTO Dim_Department_Info (DepartmentId, DepartmentName, PlantNo) VALUES
(1, 'Human Resources', 101),
(2, 'Finance', 102),
(3, 'Engineering', 103),
(4, 'Sales', 104),
(5, 'Marketing', 105),
(6, 'IT', 106),
(7, 'Customer Support', 107),
(8, 'Research', 108),
(9, 'Production', 109),
(10, 'Quality Assurance', 110);

-- Insert Data into Dim_Job_Info
INSERT INTO Dim_Job_Info (Job_Id, Job_name, Job_type) VALUES
(1, 'Software Engineer', 'Full-time'),
(2, 'Data Analyst', 'Full-time'),
(3, 'Product Manager', 'Full-time'),
(4, 'Sales Associate', 'Part-time'),
(5, 'HR Specialist', 'Full-time'),
(6, 'Marketing Coordinator', 'Full-time'),
(7, 'System Administrator', 'Full-time'),
(8, 'Customer Service Rep', 'Part-time'),
(9, 'Quality Control Inspector', 'Full-time'),
(10, 'Research Scientist', 'Full-time');

-- Insert Data into Dim_Shift_Info
INSERT INTO Dim_Shift_Info (Shift_Id, Shift_Name, StartTime, EndTime) VALUES
(1, 'Morning Shift', '08:00:00', '16:00:00'),
(2, 'Evening Shift', '16:00:00', '00:00:00'),
(3, 'Night Shift', '00:00:00', '08:00:00'),
(4, 'Split Shift', '10:00:00', '14:00:00'),
(5, 'Flexible Shift', '09:00:00', '17:00:00'),
(6, 'Overnight Shift', '18:00:00', '02:00:00'),
(7, 'Weekend Shift', '10:00:00', '18:00:00'),
(8, 'Holiday Shift', '12:00:00', '20:00:00'),
(9, 'Morning Extended', '07:00:00', '15:00:00'),
(10, 'Evening Extended', '15:00:00', '23:00:00');

-- Insert Data into Dim_Shift_Day
INSERT INTO Dim_Shift_Day (Shift_Id, Day) VALUES
(1, 'Monday'),
(1, 'Tuesday'),
(1, 'Wednesday'),
(1, 'Thursday'),
(1, 'Friday'),
(2, 'Monday'),
(2, 'Tuesday'),
(2, 'Wednesday'),
(3, 'Saturday'),
(3, 'Sunday');

-- Insert Data into Dim_Shift_Week
INSERT INTO Dim_Shift_Week (Shift_Id, WeekId) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(2, 3),
(3, 1),
(3, 2),
(4, 1),
(4, 2);

-- Insert Data into Dim_Shift_Month
INSERT INTO Dim_Shift_Month (Shift_Id, Month) VALUES
(1, 'January'),
(1, 'February'),
(1, 'March'),
(2, 'April'),
(2, 'May'),
(3, 'June'),
(3, 'July'),
(4, 'August'),
(4, 'September'),
(5, 'October');

-- Insert Data into Fact_Employee_Shift
INSERT INTO Fact_Employee_Shift (EmployeeId, DepartmentId, Job_Id, Shift_Id, Date, Overtime) VALUES
(1, 1, 1, 1, '2024-01-10', 2),
(2, 2, 2, 2, '2024-01-11', 0),
(3, 3, 3, 3, '2024-01-12', 1),
(4, 4, 4, 1, '2024-01-13', 0),
(5, 5, 5, 2, '2024-01-14', 3),
(6, 6, 6, 3, '2024-01-15', 2),
(7, 7, 7, 1, '2024-01-16', 1),
(8, 8, 8, 2, '2024-01-17', 0),
(9, 9, 9, 3, '2024-01-18', 4),
(10, 10, 10, 1, '2024-01-19', 1);

SELECT 
    ei.First_Name,
    ei.Last_Name,
    di.DepartmentName,
    ji.Job_name,
    si.Shift_Name,
    si.StartTime,
    si.EndTime,
    fs.Date,
    fs.Overtime
FROM 
    Fact_Employee_Shift fs
JOIN 
    Dim_Employee_Info ei ON fs.EmployeeId = ei.EmployeeId
JOIN 
    Dim_Department_Info di ON fs.DepartmentId = di.DepartmentId
JOIN 
    Dim_Job_Info ji ON fs.Job_Id = ji.Job_Id
JOIN 
    Dim_Shift_Info si ON fs.Shift_Id = si.Shift_Id
ORDER BY 
    fs.Date, ei.First_Name;


create database dwdmass_5;

use dwdmass_5;

-- Dimension Tables

CREATE TABLE Address_Dim (
    address_id INT PRIMARY KEY,
    street_address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100)
);

CREATE TABLE Patient_Dim (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100),
    gender VARCHAR(10),
    dob DATE,
    address_id INT,  -- Foreign Key to Address_Dim
    FOREIGN KEY (address_id) REFERENCES Address_Dim(address_id)
);

CREATE TABLE Specialization_Dim (
    specialization_id INT PRIMARY KEY,
    specialization_name VARCHAR(100)
);

CREATE TABLE Doctor_Dim (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100),
    specialization_id INT,  -- Foreign Key to Specialization_Dim
    FOREIGN KEY (specialization_id) REFERENCES Specialization_Dim(specialization_id)
);

CREATE TABLE Department_Dim (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE Hospital_Dim (
    hospital_id INT PRIMARY KEY,
    hospital_name VARCHAR(100),
    department_id INT,  -- Foreign Key to Department_Dim
    FOREIGN KEY (department_id) REFERENCES Department_Dim(department_id)
);

CREATE TABLE Date_Dim (
    date_id INT PRIMARY KEY,
    full_date DATE,
    day_of_week VARCHAR(10),
    month VARCHAR(10),
    year INT
);

CREATE TABLE Treatment_Type_Dim (
    treatment_type_id INT PRIMARY KEY,
    treatment_type_name VARCHAR(100)
);

CREATE TABLE Treatment_Dim (
    treatment_id INT PRIMARY KEY,
    treatment_name VARCHAR(100),
    treatment_type_id INT,  -- Foreign Key to Treatment_Type_Dim
    FOREIGN KEY (treatment_type_id) REFERENCES Treatment_Type_Dim(treatment_type_id)
);

CREATE TABLE Insurance_Plan_Dim (
    insurance_plan_id INT PRIMARY KEY,
    plan_name VARCHAR(100),
    coverage_percent DECIMAL(5, 2)
);

CREATE TABLE Insurance_Dim (
    insurance_id INT PRIMARY KEY,
    insurance_company VARCHAR(100),
    insurance_plan_id INT,  -- Foreign Key to Insurance_Plan_Dim
    FOREIGN KEY (insurance_plan_id) REFERENCES Insurance_Plan_Dim(insurance_plan_id)
);

-- Fact Tables

CREATE TABLE Patient_Fact (
    patient_fact_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    hospital_id INT,
    date_id INT,
    insurance_id INT,
    FOREIGN KEY (patient_id) REFERENCES Patient_Dim(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor_Dim(doctor_id),
    FOREIGN KEY (hospital_id) REFERENCES Hospital_Dim(hospital_id),
    FOREIGN KEY (date_id) REFERENCES Date_Dim(date_id),
    FOREIGN KEY (insurance_id) REFERENCES Insurance_Dim(insurance_id)
);

CREATE TABLE Treatment_Fact (
    treatment_fact_id INT PRIMARY KEY,
    treatment_id INT,
    patient_id INT,
    doctor_id INT,
    date_id INT,
    FOREIGN KEY (treatment_id) REFERENCES Treatment_Dim(treatment_id),
    FOREIGN KEY (patient_id) REFERENCES Patient_Dim(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor_Dim(doctor_id),
    FOREIGN KEY (date_id) REFERENCES Date_Dim(date_id)
);

-- Address_Dim
INSERT INTO Address_Dim VALUES (1, 'Kondhwa', 'Maharashrata', 'MH', 'India');
INSERT INTO Address_Dim VALUES (2, '456 Oak St', 'Los Angeles', 'CA', 'USA');
INSERT INTO Address_Dim VALUES (3, '789 Pine St', 'Chicago', 'IL', 'USA');
INSERT INTO Address_Dim VALUES (4, '101 Maple St', 'Houston', 'TX', 'USA');
INSERT INTO Address_Dim VALUES (5, '202 Cedar St', 'Miami', 'FL', 'USA');

-- Patient_Dim
INSERT INTO Patient_Dim VALUES (1, 'Vineet Hadli', 'Male', '1985-01-01', 1);
INSERT INTO Patient_Dim VALUES (2, 'Jaya Kulkarni', 'Female', '1990-05-15', 2);
INSERT INTO Patient_Dim VALUES (3, 'Mike Johnson', 'Male', '1975-09-10', 3);
INSERT INTO Patient_Dim VALUES (4, 'Emily Davis', 'Female', '1980-11-25', 4);
INSERT INTO Patient_Dim VALUES (5, 'David Wilson', 'Male', '1995-07-08', 5);

-- Specialization_Dim
INSERT INTO Specialization_Dim VALUES (1, 'Cardiology');
INSERT INTO Specialization_Dim VALUES (2, 'Neurology');
INSERT INTO Specialization_Dim VALUES (3, 'Orthopedics');
INSERT INTO Specialization_Dim VALUES (4, 'Pediatrics');
INSERT INTO Specialization_Dim VALUES (5, 'Dermatology');

-- Doctor_Dim
INSERT INTO Doctor_Dim VALUES (1, 'Dr. Rohan Das', 1);
INSERT INTO Doctor_Dim VALUES (2, 'Dr. Ayush Gupta', 2);
INSERT INTO Doctor_Dim VALUES (3, 'Dr. Jenny Mathew', 3);
INSERT INTO Doctor_Dim VALUES (4, 'Dr. Daniel Black', 4);
INSERT INTO Doctor_Dim VALUES (5, 'Dr. Eva Gray', 5);

-- Department_Dim
INSERT INTO Department_Dim VALUES (1, 'Emergency');
INSERT INTO Department_Dim VALUES (2, 'Surgery');
INSERT INTO Department_Dim VALUES (3, 'Radiology');
INSERT INTO Department_Dim VALUES (4, 'Oncology');
INSERT INTO Department_Dim VALUES (5, 'Pharmacy');

-- Hospital_Dim
INSERT INTO Hospital_Dim VALUES (1, 'General Hospital', 1);
INSERT INTO Hospital_Dim VALUES (2, 'City Hospital', 2);
INSERT INTO Hospital_Dim VALUES (3, 'Metropolitan Hospital', 3);
INSERT INTO Hospital_Dim VALUES (4, 'St. Mary Hospital', 4);
INSERT INTO Hospital_Dim VALUES (5, 'Children\'s Hospital', 5);

-- Date_Dim
INSERT INTO Date_Dim VALUES (1, '2024-01-01', 'Monday', 'January', 2024);
INSERT INTO Date_Dim VALUES (2, '2024-02-01', 'Thursday', 'February', 2024);
INSERT INTO Date_Dim VALUES (3, '2024-03-01', 'Friday', 'March', 2024);
INSERT INTO Date_Dim VALUES (4, '2024-04-01', 'Monday', 'April', 2024);
INSERT INTO Date_Dim VALUES (5, '2024-05-01', 'Wednesday', 'May', 2024);

-- Treatment_Type_Dim
INSERT INTO Treatment_Type_Dim VALUES (1, 'Surgery');
INSERT INTO Treatment_Type_Dim VALUES (2, 'Medication');
INSERT INTO Treatment_Type_Dim VALUES (3, 'Therapy');
INSERT INTO Treatment_Type_Dim VALUES (4, 'Diagnostic Test');
INSERT INTO Treatment_Type_Dim VALUES (5, 'Consultation');

-- Treatment_Dim
INSERT INTO Treatment_Dim VALUES (1, 'Heart Surgery', 1);
INSERT INTO Treatment_Dim VALUES (2, 'Physical Therapy', 3);
INSERT INTO Treatment_Dim VALUES (3, 'MRI Scan', 4);
INSERT INTO Treatment_Dim VALUES (4, 'Antibiotic Medication', 2);
INSERT INTO Treatment_Dim VALUES (5, 'Dermatology Consultation', 5);

-- Insurance_Plan_Dim
INSERT INTO Insurance_Plan_Dim VALUES (1, 'Basic Plan', 80.00);
INSERT INTO Insurance_Plan_Dim VALUES (2, 'Standard Plan', 90.00);
INSERT INTO Insurance_Plan_Dim VALUES (3, 'Premium Plan', 100.00);
INSERT INTO Insurance_Plan_Dim VALUES (4, 'Family Plan', 85.00);
INSERT INTO Insurance_Plan_Dim VALUES (5, 'Individual Plan', 70.00);

-- Insurance_Dim
INSERT INTO Insurance_Dim VALUES (1, 'HealthFirst', 1);
INSERT INTO Insurance_Dim VALUES (2, 'BlueCross', 2);
INSERT INTO Insurance_Dim VALUES (3, 'UnitedHealth', 3);
INSERT INTO Insurance_Dim VALUES (4, 'Cigna', 4);
INSERT INTO Insurance_Dim VALUES (5, 'Aetna', 5);

-- Fact Table Data

-- Patient_Fact
INSERT INTO Patient_Fact VALUES (1, 1, 1, 1, 1, 1);
INSERT INTO Patient_Fact VALUES (2, 2, 2, 2, 2, 2);
INSERT INTO Patient_Fact VALUES (3, 3, 3, 3, 3, 3);
INSERT INTO Patient_Fact VALUES (4, 4, 4, 4, 4, 4);
INSERT INTO Patient_Fact VALUES (5, 5, 5, 5, 5, 5);

-- Treatment_Fact
INSERT INTO Treatment_Fact VALUES (1, 1, 1, 1, 1);
INSERT INTO Treatment_Fact VALUES (2, 2, 2, 2, 2);
INSERT INTO Treatment_Fact VALUES (3, 3, 3, 3, 3);
INSERT INTO Treatment_Fact VALUES (4, 4, 4, 4, 4);
INSERT INTO Treatment_Fact VALUES (5, 5, 5, 5, 5);

select * from Address_Dim;

select * from Patient_Dim;

select * from Specialization_Dim;

select * from Doctor_Dim;

select * from Department_Dim;

select * from Hospital_Dim;

select * from Date_Dim;

select * from Treatment_Type_Dim;

select * from Treatment_Dim;

select * from Insurance_Plan_Dim;

select * from Insurance_Dim;

select * from Patient_Fact;

select * from Treatment_Fact;

SELECT 
    p.patient_name,
    d.doctor_name,
    h.hospital_name,
    t.treatment_name,
    tt.treatment_type_name,
    sp.specialization_name,
    dp.department_name,
    ad.city AS patient_city,
    ad.state AS patient_state,
    ins.insurance_company,
    ins_p.plan_name,
    dt.full_date
FROM 
    Patient_Fact pf
JOIN 
    Patient_Dim p ON pf.patient_id = p.patient_id
JOIN 
    Address_Dim ad ON p.address_id = ad.address_id
JOIN 
    Doctor_Dim d ON pf.doctor_id = d.doctor_id
JOIN 
    Specialization_Dim sp ON d.specialization_id = sp.specialization_id
JOIN 
    Hospital_Dim h ON pf.hospital_id = h.hospital_id
JOIN 
    Department_Dim dp ON h.department_id = dp.department_id
JOIN 
    Insurance_Dim ins ON pf.insurance_id = ins.insurance_id
JOIN 
    Insurance_Plan_Dim ins_p ON ins.insurance_plan_id = ins_p.insurance_plan_id
JOIN 
    Date_Dim dt ON pf.date_id = dt.date_id
JOIN 
    Treatment_Fact tf ON p.patient_id = tf.patient_id
JOIN 
    Treatment_Dim t ON tf.treatment_id = t.treatment_id
JOIN 
    Treatment_Type_Dim tt ON t.treatment_type_id = tt.treatment_type_id
WHERE 
    dt.year = 2024; -- Filtering for data in 2024

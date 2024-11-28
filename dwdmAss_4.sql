create database dwdmass_4;

use dwdmass_4;

CREATE TABLE address (
    address_id INT PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10)
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE TABLE property_location (
    property_location_id INT PRIMARY KEY,
    city VARCHAR(50),
    state VARCHAR(50)
);

CREATE TABLE property (
    property_id INT PRIMARY KEY,
    property_name VARCHAR(100),
    property_location_id INT,
    FOREIGN KEY (property_location_id) REFERENCES property_location(property_location_id)
);

CREATE TABLE year (
    year_id INT PRIMARY KEY,
    year INT
);

CREATE TABLE date_dimension (
    date_id INT PRIMARY KEY,
    day INT,
    month INT,
    year_id INT,
    FOREIGN KEY (year_id) REFERENCES year(year_id)
);

CREATE TABLE contact_info (
    contact_info_id INT PRIMARY KEY,
    phone VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE agent (
    agent_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    contact_info_id INT,
    FOREIGN KEY (contact_info_id) REFERENCES contact_info(contact_info_id)
);

CREATE TABLE bank_details (
    bank_details_id INT PRIMARY KEY,
    bank_name VARCHAR(100),
    account_number VARCHAR(20)
);

CREATE TABLE payment_method (
    payment_method_id INT PRIMARY KEY,
    method_name VARCHAR(50),
    bank_details_id INT,
    FOREIGN KEY (bank_details_id) REFERENCES bank_details(bank_details_id)
);

CREATE TABLE rental_fact (
    rental_id INT PRIMARY KEY,
    customer_id INT,
    property_id INT,
    date_id INT,
    agent_id INT,
    payment_method_id INT,
    rental_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (property_id) REFERENCES property(property_id),
    FOREIGN KEY (date_id) REFERENCES date_dimension(date_id),
    FOREIGN KEY (agent_id) REFERENCES agent(agent_id),
    FOREIGN KEY (payment_method_id) REFERENCES payment_method(payment_method_id)
);

-- Insert into address
INSERT INTO address VALUES (1, '123 Main St', 'Delhi', 'DL', '10001');
INSERT INTO address VALUES (2, '456 Oak St', 'Mumbai', 'MH', '90001');
INSERT INTO address VALUES (3, '789 Pine St', 'Tamil Nadu', 'TN', '60601');
INSERT INTO address VALUES (4, '101 Maple St', 'Gujarat', 'GJ', '77001');
INSERT INTO address VALUES (5, '202 Birch St', 'Karnataka', 'KA', '33101');

-- Insert into customer
INSERT INTO customer VALUES (1, 'Rohan', 'Das', 1);
INSERT INTO customer VALUES (2, 'Juli', 'Sharma', 2);
INSERT INTO customer VALUES (3, 'Michael', 'Johnson', 3);
INSERT INTO customer VALUES (4, 'Shubham', 'Davis', 4);
INSERT INTO customer VALUES (5, 'Vineet', 'Hadli', 5);

-- Insert into property_location
INSERT INTO property_location VALUES (1, 'Delhi', 'Dl');
INSERT INTO property_location VALUES (2, 'Mumbai', 'MH');
INSERT INTO property_location VALUES (3, 'Tamil Nadu', 'TN');
INSERT INTO property_location VALUES (4, 'Gujarat', 'GJ');
INSERT INTO property_location VALUES (5, 'Karnataka', 'KA');

-- Insert into property
INSERT INTO property VALUES (1, 'Sunset Apartments', 1);
INSERT INTO property VALUES (2, 'Palm Grove', 2);
INSERT INTO property VALUES (3, 'Lake View Condos', 3);
INSERT INTO property VALUES (4, 'Downtown Lofts', 4);
INSERT INTO property VALUES (5, 'Ocean Breeze Villas', 5);

-- Insert into year
INSERT INTO year VALUES (1, 2023);
INSERT INTO year VALUES (2, 2022);
INSERT INTO year VALUES (3, 2021);
INSERT INTO year VALUES (4, 2020);
INSERT INTO year VALUES (5, 2019);

-- Insert into date_dimension
INSERT INTO date_dimension VALUES (1, 1, 1, 1);
INSERT INTO date_dimension VALUES (2, 2, 1, 1);
INSERT INTO date_dimension VALUES (3, 3, 1, 1);
INSERT INTO date_dimension VALUES (4, 4, 1, 1);
INSERT INTO date_dimension VALUES (5, 5, 1, 1);

-- Insert into contact_info
INSERT INTO contact_info VALUES (1, '555-1234', 'deepak.agent@example.com');
INSERT INTO contact_info VALUES (2, '555-5678', 'manish.agent@example.com');
INSERT INTO contact_info VALUES (3, '555-8765', 'rahul.agent@example.com');
INSERT INTO contact_info VALUES (4, '555-4321', 'ashwin.agent@example.com');
INSERT INTO contact_info VALUES (5, '555-0987', 'suraj.agent@example.com');

-- Insert into agent
INSERT INTO agent VALUES (1, 'Deepak', 'Agent', 1);
INSERT INTO agent VALUES (2, 'Manish', 'Agent', 2);
INSERT INTO agent VALUES (3, 'Rahul', 'Agent', 3);
INSERT INTO agent VALUES (4, 'Ashwin', 'Agent', 4);
INSERT INTO agent VALUES (5, 'Suraj', 'Agent', 5);

-- Insert into bank_details
INSERT INTO bank_details VALUES (1, 'SBI', '1234567890');
INSERT INTO bank_details VALUES (2, 'State Bank Of Maharashtra', '0987654321');
INSERT INTO bank_details VALUES (3, 'Axis', '5678901234');
INSERT INTO bank_details VALUES (4, 'Citibank', '3456789012');
INSERT INTO bank_details VALUES (5, 'HDFC', '9012345678');

-- Insert into payment_method
INSERT INTO payment_method VALUES (1, 'Credit Card', 1);
INSERT INTO payment_method VALUES (2, 'Debit Card', 2);
INSERT INTO payment_method VALUES (3, 'Bank Transfer', 3);
INSERT INTO payment_method VALUES (4, 'Cash', 4);
INSERT INTO payment_method VALUES (5, 'Check', 5);

INSERT INTO rental_fact VALUES (1, 1, 1, 1, 1, 1, 1200.00);
INSERT INTO rental_fact VALUES (2, 2, 2, 2, 2, 2, 1500.00);
INSERT INTO rental_fact VALUES (3, 3, 3, 3, 3, 3, 1000.00);
INSERT INTO rental_fact VALUES (4, 4, 4, 4, 4, 4, 2000.00);
INSERT INTO rental_fact VALUES (5, 5, 5, 5, 5, 5, 1800.00);

select * from address;

select * from customer;

select * from property_location;

select * from property;

select * from year;

select * from date_dimension;

select * from contact_info;

select * from agent;

select * from bank_details;

select * from payment_method;

select * from rental_fact;

SELECT 
    rf.rental_id,
    
    -- Customer Information
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name,
    a.street AS customer_street,
    a.city AS customer_city,
    a.state AS customer_state,
    a.zip_code AS customer_zip_code,
    
    -- Property Information
    p.property_name,
    pl.city AS property_city,
    pl.state AS property_state,
    
    -- Date Information
    dd.day,
    dd.month,
    y.year,
    
    -- Agent Information
    ag.first_name AS agent_first_name,
    ag.last_name AS agent_last_name,
    ci.phone AS agent_phone,
    ci.email AS agent_email,
    
    -- Payment Method Information
    pm.method_name,
    bd.bank_name,
    bd.account_number,
    
    -- Rental Amount
    rf.rental_amount
    
FROM rental_fact rf

-- Customer Dimension and Sub-Dimension (Address)
JOIN customer c ON rf.customer_id = c.customer_id
JOIN address a ON c.address_id = a.address_id

-- Property Dimension and Sub-Dimension (Property Location)
JOIN property p ON rf.property_id = p.property_id
JOIN property_location pl ON p.property_location_id = pl.property_location_id

-- Date Dimension and Sub-Dimension (Year)
JOIN date_dimension dd ON rf.date_id = dd.date_id
JOIN year y ON dd.year_id = y.year_id

-- Agent Dimension and Sub-Dimension (Contact Info)
JOIN agent ag ON rf.agent_id = ag.agent_id
JOIN contact_info ci ON ag.contact_info_id = ci.contact_info_id

-- Payment Method Dimension and Sub-Dimension (Bank Details)
JOIN payment_method pm ON rf.payment_method_id = pm.payment_method_id
JOIN bank_details bd ON pm.bank_details_id = bd.bank_details_id;

SELECT 
    rf.rental_id,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name,
    p.property_name,
    dd.day, dd.month, y.year,
    ag.first_name AS agent_first_name,
    pm.method_name,
    rf.rental_amount
FROM rental_fact rf
JOIN customer c ON rf.customer_id = c.customer_id
JOIN property p ON rf.property_id = p.property_id
JOIN date_dimension dd ON rf.date_id = dd.date_id
JOIN year y ON dd.year_id = y.year_id
JOIN agent ag ON rf.agent_id = ag.agent_id
JOIN payment_method pm ON rf.payment_method_id = pm.payment_method_id;

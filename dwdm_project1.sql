create database dwdm_project1;

use dwdm_project1;

CREATE TABLE dim_customer_location (
    location_id INT PRIMARY KEY,
    city VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255)
);

CREATE TABLE dim_customer_plan (
    plan_id INT PRIMARY KEY,
    plan_name VARCHAR(255),
    plan_price DECIMAL(10, 2),
    data_limit INT -- in GB
);

CREATE TABLE dim_customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    customer_location_id INT,
    customer_plan_id INT,
    FOREIGN KEY (customer_location_id) REFERENCES dim_customer_location(location_id),
    FOREIGN KEY (customer_plan_id) REFERENCES dim_customer_plan(plan_id)
);

CREATE TABLE dim_time_of_day (
    time_id INT PRIMARY KEY,
    time_of_day VARCHAR(50)
);

CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    date DATE,
    day_of_week VARCHAR(50),
    month VARCHAR(50),
    year INT
);

CREATE TABLE dim_call_category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255)
);

CREATE TABLE dim_call_destination (
    destination_id INT PRIMARY KEY,
    destination_type VARCHAR(255) -- Domestic or International
);

CREATE TABLE dim_call_type (
    call_type_id INT PRIMARY KEY,
    call_category_id INT,
    call_destination_id INT,
    FOREIGN KEY (call_category_id) REFERENCES dim_call_category(category_id),
    FOREIGN KEY (call_destination_id) REFERENCES dim_call_destination(destination_id)
);

CREATE TABLE dim_payment_method (
    payment_method_id INT PRIMARY KEY,
    method_name VARCHAR(255)
);

CREATE TABLE dim_billing_cycle (
    billing_cycle_id INT PRIMARY KEY,
    cycle_name VARCHAR(255),
    cycle_duration_days INT
);

CREATE TABLE dim_billing (
    billing_id INT PRIMARY KEY,
    payment_method_id INT,
    billing_cycle_id INT,
    FOREIGN KEY (payment_method_id) REFERENCES dim_payment_method(payment_method_id),
    FOREIGN KEY (billing_cycle_id) REFERENCES dim_billing_cycle(billing_cycle_id)
);

CREATE TABLE dim_operator_region (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(255)
);

CREATE TABLE dim_operator_network (
    network_id INT PRIMARY KEY,
    network_name VARCHAR(255)
);

CREATE TABLE dim_operator (
    operator_id INT PRIMARY KEY,
    operator_region_id INT,
    operator_network_id INT,
    FOREIGN KEY (operator_region_id) REFERENCES dim_operator_region(region_id),
    FOREIGN KEY (operator_network_id) REFERENCES dim_operator_network(network_id)
);

CREATE TABLE fact_call_details (
    call_id INT PRIMARY KEY,
    customer_id INT,
    call_date_id INT,
    call_time_id INT,
    call_type_id INT,
    billing_id INT,
    operator_id INT,
    call_duration INT, -- in seconds
    call_cost DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (call_date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (call_time_id) REFERENCES dim_time_of_day(time_id),
    FOREIGN KEY (call_type_id) REFERENCES dim_call_type(call_type_id),
    FOREIGN KEY (billing_id) REFERENCES dim_billing(billing_id),
    FOREIGN KEY (operator_id) REFERENCES dim_operator(operator_id)
);

INSERT INTO dim_customer_location (location_id, city, state, country) VALUES
(1, 'Mumbai', 'Maharashtra', 'India'),
(2, 'Delhi', 'Delhi', 'India'),
(3, 'Bangalore', 'Karnataka', 'India'),
(4, 'Hyderabad', 'Telangana', 'India'),
(5, 'Chennai', 'Tamil Nadu', 'India'),
(6, 'Kolkata', 'West Bengal', 'India'),
(7, 'Pune', 'Maharashtra', 'India'),
(8, 'Ahmedabad', 'Gujarat', 'India'),
(9, 'Jaipur', 'Rajasthan', 'India'),
(10, 'Surat', 'Gujarat', 'India'),
(11, 'Lucknow', 'Uttar Pradesh', 'India'),
(12, 'Kanpur', 'Uttar Pradesh', 'India'),
(13, 'Nagpur', 'Maharashtra', 'India'),
(14, 'Indore', 'Madhya Pradesh', 'India'),
(15, 'Bhopal', 'Madhya Pradesh', 'India'),
(16, 'Patna', 'Bihar', 'India'),
(17, 'Vadodara', 'Gujarat', 'India'),
(18, 'Agra', 'Uttar Pradesh', 'India'),
(19, 'Varanasi', 'Uttar Pradesh', 'India'),
(20, 'Nashik', 'Maharashtra', 'India'),
(21, 'Ludhiana', 'Punjab', 'India'),
(22, 'Amritsar', 'Punjab', 'India'),
(23, 'Vijayawada', 'Andhra Pradesh', 'India'),
(24, 'Guwahati', 'Assam', 'India'),
(25, 'Coimbatore', 'Tamil Nadu', 'India');

INSERT INTO dim_customer_plan (plan_id, plan_name, plan_price, data_limit) VALUES
(1, 'Basic', 199.00, 2),
(2, 'Standard', 399.00, 10),
(3, 'Premium', 599.00, 20),
(4, 'Unlimited', 999.00, 50),
(5, 'Family', 1299.00, 100);

INSERT INTO dim_customer (customer_id, customer_name, customer_location_id, customer_plan_id) VALUES
(1, 'Rajesh Kumar', 1, 1),
(2, 'Priya Sharma', 2, 2),
(3, 'Anil Verma', 3, 3),
(4, 'Sunita Reddy', 4, 4),
(5, 'Arun Gupta', 5, 5),
(6, 'Ravi Patel', 1, 2),
(7, 'Pooja Nair', 2, 3),
(8, 'Manoj Desai', 3, 4),
(9, 'Neha Singh', 4, 1),
(10, 'Kiran Joshi', 5, 5),
(11, 'Suresh Yadav', 1, 1),
(12, 'Amit Chawla', 2, 2),
(13, 'Anita Bhatia', 3, 3),
(14, 'Vijay Rao', 4, 4),
(15, 'Deepak Thakur', 5, 5),
(16, 'Siddharth Iyer', 1, 1),
(17, 'Sneha Mehta', 2, 2),
(18, 'Gopal Pandey', 3, 3),
(19, 'Meera Pillai', 4, 4),
(20, 'Ramesh Menon', 5, 5),
(21, 'Rohit Sen', 1, 2),
(22, 'Lakshmi Nair', 2, 3),
(23, 'Rahul Dutta', 3, 4),
(24, 'Shweta Kapoor', 4, 1),
(25, 'Mohan Singh', 5, 5);

INSERT INTO dim_date (date_id, date, day_of_week, month, year) VALUES
(1, '2024-01-01', 'Monday', 'January', 2024),
(2, '2024-01-02', 'Tuesday', 'January', 2024),
(3, '2024-01-03', 'Wednesday', 'January', 2024),
(4, '2024-01-04', 'Thursday', 'January', 2024),
(5, '2024-01-05', 'Friday', 'January', 2024),
(6, '2024-01-06', 'Saturday', 'January', 2024),
(7, '2024-01-07', 'Sunday', 'January', 2024),
(8, '2024-01-08', 'Monday', 'January', 2024),
(9, '2024-01-09', 'Tuesday', 'January', 2024),
(10, '2024-01-10', 'Wednesday', 'January', 2024),
(11, '2024-01-11', 'Thursday', 'January', 2024),
(12, '2024-01-12', 'Friday', 'January', 2024),
(13, '2024-01-13', 'Saturday', 'January', 2024),
(14, '2024-01-14', 'Sunday', 'January', 2024),
(15, '2024-01-15', 'Monday', 'January', 2024);

INSERT INTO dim_time_of_day (time_id, time_of_day) VALUES
(1, 'Morning'),
(2, 'Afternoon'),
(3, 'Evening'),
(4, 'Night'),
(5, 'Midnight');

INSERT INTO dim_call_category (category_id, category_name) VALUES
(1, 'Voice'),
(2, 'Video'),
(3, 'SMS'),
(4, 'MMS'),
(5, 'Data');

INSERT INTO dim_call_destination (destination_id, destination_type) VALUES
(1, 'Domestic'),
(2, 'International'),
(3, 'Roaming'),
(4, 'Emergency'),
(5, 'Toll-Free');

INSERT INTO dim_call_type (call_type_id, call_category_id, call_destination_id) VALUES
(1, 1, 3),
(2, 2, 1),
(3, 3, 4),
(4, 4, 2),
(5, 5, 5),
(6, 1, 4),
(7, 2, 3),
(8, 3, 1),
(9, 4, 5),
(10, 5, 2),
(11, 1, 1),
(12, 2, 4),
(13, 3, 2),
(14, 4, 3),
(15, 5, 1),
(16, 1, 5),
(17, 2, 2),
(18, 3, 3),
(19, 4, 4),
(20, 5, 1),
(21, 1, 2),
(22, 2, 5),
(23, 3, 4),
(24, 4, 1),
(25, 5, 3);

INSERT INTO dim_payment_method (payment_method_id, method_name) VALUES
(1, 'Credit Card'),
(2, 'Debit Card'),
(3, 'Net Banking'),
(4, 'UPI'),
(5, 'Cash');

INSERT INTO dim_billing_cycle (billing_cycle_id, cycle_name, cycle_duration_days) VALUES
(1, 'Monthly', 30),
(2, 'Quarterly', 90),
(3, 'Yearly', 365),
(4, 'Bi-Annual', 180),
(5, 'Weekly', 7);

INSERT INTO dim_billing (billing_id, payment_method_id, billing_cycle_id) VALUES
(1, 3, 2),
(2, 1, 5),
(3, 4, 1),
(4, 2, 4),
(5, 5, 3),
(6, 3, 1),
(7, 4, 5),
(8, 2, 2),
(9, 1, 3),
(10, 5, 4),
(11, 3, 2),
(12, 4, 1),
(13, 2, 5),
(14, 1, 4),
(15, 5, 3),
(16, 2, 1),
(17, 4, 2),
(18, 3, 5),
(19, 1, 1),
(20, 5, 4),
(21, 4, 3),
(22, 2, 2),
(23, 3, 4),
(24, 1, 5),
(25, 5, 1);

INSERT INTO dim_operator_region (region_id, region_name) VALUES
(1, 'North India'),
(2, 'South India'),
(3, 'East India'),
(4, 'West India'),
(5, 'Central India');

INSERT INTO dim_operator_network (network_id, network_name) VALUES
(1, 'Jio'),
(2, 'Airtel'),
(3, 'Vodafone Idea'),
(4, 'BSNL'),
(5, 'MTNL');

INSERT INTO dim_operator (operator_id, operator_region_id, operator_network_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 3),
(4, 3, 4),
(5, 4, 5);

INSERT INTO fact_call_details (call_id, customer_id, call_date_id, call_time_id, call_type_id, billing_id, operator_id, call_duration, call_cost) VALUES
(1, 1, 1, 1, 1, 1, 1, 300, 10.00),
(2, 2, 2, 2, 2, 2, 2, 600, 20.00),
(3, 3, 3, 3, 3, 3, 3, 120, 5.00),
(4, 4, 4, 4, 4, 4, 4, 240, 15.00),
(5, 5, 5, 5, 5, 5, 5, 180, 12.50),
(6, 6, 6, 1, 6, 6, 1, 300, 10.50),
(7, 7, 7, 2, 7, 7, 2, 600, 21.00),
(8, 8, 8, 3, 8, 8, 3, 120, 5.50),
(9, 9, 9, 4, 9, 9, 4, 240, 16.00),
(10, 10, 10, 5, 10, 10, 5, 180, 13.00),
(11, 11, 1, 2, 11, 11, 1, 300, 10.20),
(12, 12, 2, 3, 12, 12, 2, 600, 20.40),
(13, 13, 3, 4, 13, 13, 3, 120, 5.10),
(14, 14, 4, 5, 14, 14, 4, 240, 15.60),
(15, 15, 5, 1, 15, 15, 5, 180, 12.80),
(16, 16, 6, 2, 16, 16, 1, 300, 10.70),
(17, 17, 7, 3, 17, 17, 2, 600, 21.40),
(18, 18, 8, 4, 18, 18, 3, 120, 5.20),
(19, 19, 9, 5, 19, 19, 4, 240, 16.20),
(20, 20, 10, 1, 20, 20, 5, 180, 13.30),
(21, 21, 1, 2, 21, 21, 1, 300, 10.80),
(22, 22, 2, 3, 22, 22, 2, 600, 21.60),
(23, 23, 3, 4, 23, 23, 3, 120, 5.30),
(24, 24, 4, 5, 24, 24, 4, 240, 16.80),
(25, 25, 5, 1, 25, 25, 5, 180, 13.60);

SELECT * FROM dim_customer_location;

SELECT * FROM dim_customer_plan;

SELECT * FROM dim_customer;

SELECT * FROM dim_date;

SELECT * FROM dim_time_of_day;

SELECT * FROM dim_call_category;

SELECT * FROM dim_call_destination;

SELECT * FROM dim_call_type;

SELECT * FROM dim_payment_method;

SELECT * FROM dim_billing_cycle;

SELECT * FROM dim_billing;

SELECT * FROM dim_operator_region;

SELECT * FROM dim_operator_network;

SELECT * FROM dim_operator;

SELECT * FROM fact_call_details;
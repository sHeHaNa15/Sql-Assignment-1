-- =====================================================================
-- MySQL Assignment 1 - DDL Commands & Constraints
-- Run the whole file top to bottom (MySQL 8.0.16+).
-- =====================================================================


-- =====================================================================
-- PART 1: DDL COMMANDS
-- =====================================================================

-- 1. CREATE
DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;

CREATE TABLE departments (
    department_id   INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE location (
    location_id INT PRIMARY KEY,
    location    VARCHAR(30)
);

CREATE TABLE employees (
    employee_id   INT PRIMARY KEY,
    employee_name VARCHAR(50),
    gender        ENUM('M','F'),
    age           INT,
    hire_date     DATE,
    designation   VARCHAR(100),
    department_id INT,
    location_id   INT,
    salary        DECIMAL(10,2)
);

-- 2. ALTER
ALTER TABLE employees ADD COLUMN email VARCHAR(100);
ALTER TABLE employees MODIFY COLUMN designation VARCHAR(255);
ALTER TABLE employees DROP COLUMN age;
ALTER TABLE employees RENAME COLUMN hire_date TO date_of_joining;

-- 3. RENAME
RENAME TABLE departments TO departments_info;
RENAME TABLE location TO locations;

-- 4. TRUNCATE
TRUNCATE TABLE employees;

-- 5. DROP
DROP TABLE employees;
DROP DATABASE employee;


-- =====================================================================
-- PART 2: CONSTRAINTS
-- =====================================================================

-- 1. Database recreation
DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;

-- 2. Departments: unique id, name NOT NULL and UNIQUE
CREATE TABLE departments (
    department_id   INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- 3. Location: auto-increment id, location NOT NULL and UNIQUE
CREATE TABLE location (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    location    VARCHAR(30) NOT NULL UNIQUE
);

-- 4. Employees: PK, NOT NULL name, gender/age checks,
--    default hire date, foreign keys
CREATE TABLE employees (
    employee_id   INT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    gender        ENUM('M','F'),
    age           INT,
    hire_date     DATE DEFAULT (CURRENT_DATE),
    designation   VARCHAR(100),
    department_id INT,
    location_id   INT,
    salary        DECIMAL(10,2),
    CONSTRAINT chk_gender CHECK (gender IN ('M','F')),
    CONSTRAINT chk_age    CHECK (age >= 18),
    CONSTRAINT fk_dept FOREIGN KEY (department_id)
        REFERENCES departments(department_id),
    CONSTRAINT fk_loc  FOREIGN KEY (location_id)
        REFERENCES location(location_id)
);

-- Sample data (valid rows)
INSERT INTO departments VALUES (1, 'HR');
INSERT INTO location (location) VALUES ('Kochi'), ('Chennai');
INSERT INTO employees
    (employee_id, employee_name, gender, age, designation, department_id, location_id, salary)
VALUES
    (101, 'Anu', 'F', 25, 'Analyst', 1, 1, 45000.00);

-- Invalid inserts below each fail with an error; uncomment one at a time to test.
-- INSERT INTO departments VALUES (2, 'HR');                        -- duplicate name
-- INSERT INTO departments VALUES (3, NULL);                        -- NULL name
-- INSERT INTO location (location) VALUES ('Kochi');                -- duplicate location
-- INSERT INTO employees (employee_id, employee_name, gender, age, department_id, location_id)
--     VALUES (102, 'Ravi', 'M', 17, 1, 1);                         -- age below 18
-- INSERT INTO employees (employee_id, employee_name, gender, age, department_id, location_id)
--     VALUES (103, 'Sam', 'M', 30, 99, 1);                         -- department 99 missing
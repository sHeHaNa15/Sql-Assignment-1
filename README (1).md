# MySQL Assignment 1: DDL Commands & Constraints

A MySQL assignment covering DDL commands (CREATE, ALTER, RENAME, TRUNCATE, DROP) and table constraints, built around an **Employee Database** with three related tables.

## Schema

| Table | Columns |
|-------|---------|
| `departments` | `department_id` (PK), `department_name` |
| `location` | `location_id` (PK), `location` |
| `employees` | `employee_id` (PK), `employee_name`, `gender`, `age`, `hire_date`, `designation`, `department_id` (FK), `location_id` (FK), `salary` |

Each department and each location can have many employees (one-to-many).

## Contents

| File | Description |
|------|-------------|
| `mysql_assignment_1.sql` | Complete solution for Part 1 and Part 2 in a single script |

## Part 1: DDL Commands

1. **CREATE:** create the `employee` database and the `departments`, `location` and `employees` tables.
2. **ALTER:**
   - add an `email` column to `employees`
   - widen `designation` to `VARCHAR(255)`
   - drop the `age` column
   - rename `hire_date` to `date_of_joining`
3. **RENAME:** rename `departments` to `departments_info` and `location` to `locations`.
4. **TRUNCATE:** remove all rows from `employees`.
5. **DROP:** drop the `employees` table and then the `employee` database.

## Part 2: Constraints

The database is dropped and recreated, with these constraints:

| Table | Requirement | Implementation |
|-------|-------------|----------------|
| `departments` | Unique department id | `PRIMARY KEY` |
| `departments` | No null or duplicate names | `NOT NULL UNIQUE` |
| `location` | Auto-generated sequential id | `PRIMARY KEY AUTO_INCREMENT` |
| `location` | No null or duplicate locations | `NOT NULL UNIQUE` |
| `employees` | Distinct employee id | `PRIMARY KEY` |
| `employees` | Name always provided | `NOT NULL` |
| `employees` | Gender only `M` or `F` | `ENUM('M','F')` + `CHECK` |
| `employees` | Age 18 or above | `CHECK (age >= 18)` |
| `employees` | Hire date defaults to today | `DEFAULT (CURRENT_DATE)` |
| `employees` | Links to departments and locations | `FOREIGN KEY` on `department_id` and `location_id` |

## How to Run

**Requirements:** MySQL Server 8.0.16 or later (needed for `CHECK` constraints) and MySQL Workbench or the `mysql` command-line client.

**In MySQL Workbench**
1. Connect to your local server.
2. Open the script with **File > Open SQL Script**.
3. Press **Ctrl+A** to select everything, then click **Run**.

**From the command line**
```bash
mysql -u root -p < mysql_assignment_1.sql
```

The script starts with `DROP DATABASE IF EXISTS employee;`, so it can be re-run safely at any time.

## Verify the Results

```sql
USE employee;
SELECT * FROM departments;
SELECT * FROM location;
SELECT * FROM employees;
SHOW CREATE TABLE employees;
```

## Testing the Constraints

The bottom of the script has invalid `INSERT` statements, commented out so the file runs cleanly. Uncomment one at a time to see each constraint reject bad data:

- duplicate or `NULL` department name
- duplicate location
- employee with age below 18
- employee referencing a department that does not exist




**HR Database**

This repository contains a Human Resources (HR) database with four interconnected tables: `Employee`, `Department`, `Job`, and `Location`. 

**Tables**

1. **Employee Table**
   - Fields: employee ID, first name, last name, email, hire date, phone number, job ID, salary, commission percentage, manager ID, department ID.
   - Relationships: Connected to the `Department` and `Job` tables through foreign keys.
   
2. **Department Table**
   - Fields: department ID, department name, manager ID, location ID.
   - Relationships: Connected to the `Employee` table using a foreign key.
   
3. **Job Table**
   - Fields: job ID, job title, minimum salary, maximum salary.
   - Relationships: Connected to the `Employee` table through a foreign key.
   
4. **Location Table**
   - Fields: location ID, street address, postal code, city, state/province, country ID.
   - Relationships: Connected to the `Department` table via the `location ID` field, which acts as a primary key.

**Database Relationships**

- The `Employee` table is at the center of the database, linking employees to their respective departments and job roles.
- The `Department` table manages department information, connecting employees to their respective departments.
- The `Job` table defines job positions, linking them to employees.
- The `Location` table is linked to the `Department` table through the `location ID`, facilitating the association of departments with specific office locations.

This HR database is designed to efficiently manage employee data, including their job roles, departments, and office locations. You can explore the schema, use SQL queries for data retrieval, and integrate it into HR-related applications or processes.

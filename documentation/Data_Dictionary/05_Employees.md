# Employees Data Dictionary

## Purpose

The **Employees** table stores the master information of every employee working at Vovers.

Each employee is uniquely identified by **Employee_ID** and is assigned to either a retail store or a warehouse. This table supports workforce management, salary analysis, departmental reporting, and operational analytics.

<br>

| Column Name | Data Type | PK | FK | Nullable | Default Value | Constraints / Allowed Values | Description |
|--------------|-----------|:--:|:--:|:--------:|---------------|------------------------------|-------------|
| Employee_ID | INT | Y | N | N | AUTO_INCREMENT | Positive Integer | Unique identifier assigned to each employee. |
| Employee_Name | VARCHAR(100) | N | N | N | None | Maximum 100 characters | Full name of the employee. |
| Gender | ENUM | N | N | N | None | Male, Female, Other | Gender of the employee. |
| Age | TINYINT | N | N | N | None | Age ≥ 18 | Age of the employee in completed years. |
| Department | VARCHAR(50) | N | N | N | None | Valid department name | Department in which the employee works. |
| Designation | VARCHAR(50) | N | N | N | None | Valid designation | Job role of the employee. |
| Store_ID | INT | N | Y | Y | None | Must exist in Stores table | Store where the employee is assigned (if applicable). |
| Warehouse_ID | INT | N | Y | Y | None | Must exist in Warehouses table | Warehouse where the employee is assigned (if applicable). |
| Join_Date | DATE | N | N | N | None | Current date or earlier | Date on which the employee joined Vovers. |
| Salary | DECIMAL(10,2) | N | N | N | None | Greater than 0 | Monthly salary of the employee. |

<br>

## Business Rules

- Every employee must have a unique **Employee_ID**.
- Every employee belongs to one department.
- Every employee has one designation.
- An employee is assigned to either a **Store** or a **Warehouse**.
- At least one of **Store_ID** or **Warehouse_ID** must contain a valid value.
- Join_Date cannot be a future date.
- Salary must always be greater than zero.
- Employee records are retained permanently for historical reporting.

<br>

## Relationships

| Parent Table | Child Table | Relationship |
|--------------|-------------|--------------|
| Stores | Employees | One-to-Many |
| Warehouses | Employees | One-to-Many |

<br>

## Used In Analysis

The Employees table is used for:

- Employee Distribution by Department
- Employee Distribution by Region
- Salary Analysis
- Department-wise Workforce
- Store-wise Workforce
- Warehouse-wise Workforce
- Average Salary by Department
- Headcount Analysis
- Employee Growth Trend
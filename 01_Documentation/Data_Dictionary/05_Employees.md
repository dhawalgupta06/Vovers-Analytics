# Employees Data Dictionary

## Purpose

The **Employees** table stores the master information of every employee working at Vovers.

Each employee is uniquely identified by **Employee_ID** and is assigned to either a retail store, a warehouse, or the head office. This table supports workforce management, salary analysis, departmental reporting, and operational analytics.

<br>

| Column Name | Data Type | PK | FK | Nullable | Default Value | Constraints / Allowed Values | Description |
|--------------|-----------|:--:|:--:|:--------:|---------------|------------------------------|-------------|
| Employee_ID | INT | Y | N | N | AUTO_INCREMENT | Positive Integer | Unique identifier assigned to each employee. |
| Employee_Name | VARCHAR(100) | N | N | N | None | Maximum 100 characters | Full name of the employee. |
| Gender | ENUM | N | N | N | None | Male, Female, Other | Gender of the employee. |
| Age | TINYINT | N | N | N | None | Age ≥ 18 | Age of the employee in completed years. |
| Department | ENUM | N | N | N | None | Sales, Warehouse, Finance, HR, IT, Operations, Marketing | Department in which the employee works. |
| Designation | ENUM | N | N | N | None | Store Manager, Sales Executive, Cashier, Warehouse Manager, Warehouse Executive, Finance Manager, Finance Executive, HR Manager, HR Executive, IT Manager, IT Executive, Operations Manager, Operations Executive, Marketing Manager, Marketing Executive | Job role of the employee. |
| Store_ID | INT | N | Y | Y | None | Must exist in Stores table | Store where the employee is assigned (if applicable). |
| Warehouse_ID | INT | N | Y | Y | None | Must exist in Warehouses table | Warehouse where the employee is assigned (if applicable). |
| Join_Date | DATE | N | N | N | None | Current date or earlier | Date on which the employee joined Vovers. |
| Salary | DECIMAL(10,2) | N | N | N | None | Greater than 0 | Monthly salary of the employee. |

<br>

## Business Rules

- Every employee must have a unique **Employee_ID**.
- Every employee belongs to exactly one department.
- Every employee has exactly one designation.
- Every designation must belong to its respective department.
- Employees may work at a **Store**, **Warehouse**, or **Head Office**.
- Store employees must have a valid **Store_ID** and **Warehouse_ID** must be `NULL`.
- Warehouse employees must have a valid **Warehouse_ID** and **Store_ID** must be `NULL`.
- Head Office employees must have both **Store_ID** and **Warehouse_ID** as `NULL`.

### Work Location Rules

#### Store
Allowed Designations:
- Store Manager
- Sales Executive
- Cashier

#### Warehouse
Allowed Designations:
- Warehouse Manager
- Warehouse Executive

#### Head Office
Allowed Designations:
- Finance Manager
- Finance Executive
- HR Manager
- HR Executive
- IT Manager
- IT Executive
- Operations Manager
- Operations Executive
- Marketing Manager
- Marketing Executive

### Staffing Rules

- Each **Store** must have exactly one **Store Manager**.
- Each **Warehouse** must have exactly one **Warehouse Manager**.
- A store can have multiple **Sales Executives**.
- A store can have multiple **Cashiers**.
- A warehouse can have multiple **Warehouse Executives**.

### General Rules

- Join_Date cannot be a future date.
- Salary must always be greater than zero.
- Employee records are retained permanently for historical reporting.
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
- Head Office Workforce Analysis
- Store Staffing Analysis
- Warehouse Staffing Analysis
- Average Salary by Department
- Average Salary by Designation
- Employee Growth Trend
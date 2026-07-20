# Suppliers Data Dictionary

## Purpose

The **Suppliers** table stores the master information of every supplier associated with Vovers.

Each supplier is uniquely identified by **Supplier_ID** and supplies one or more products to the company. This table supports procurement management, supplier performance analysis, purchase tracking, and supply chain reporting.

<br>

| Column Name | Data Type | PK | FK | Nullable | Default Value | Constraints / Allowed Values | Description |
|--------------|-----------|:--:|:--:|:--------:|---------------|------------------------------|-------------|
| Supplier_ID | INT | Y | N | N | AUTO_INCREMENT | Positive Integer | Unique identifier assigned to each supplier. |
| Supplier_Name | VARCHAR(100) | N | N | N | None | Maximum 100 characters | Registered name of the supplier. |
| Contact_Person | VARCHAR(100) | N | N | N | None | Maximum 100 characters | Primary contact person representing the supplier. |
| Phone | VARCHAR(15) | N | N | N | None | Valid phone number | Official contact number of the supplier. |
| Email | VARCHAR(100) | N | N | N | None | Valid email address | Official email address of the supplier. |
| City | VARCHAR(50) | N | N | N | None | Valid Indian city names | City where the supplier is located. |
| State | VARCHAR(50) | N | N | N | None | Valid Indian state names | State where the supplier is located. |

<br>

## Business Rules

- Every supplier must have a unique **Supplier_ID**.
- Every supplier must have one primary contact person.
- Phone number should be unique for every supplier.
- Email address should be unique for every supplier.
- A supplier can supply one or more products.
- Supplier records are retained permanently for historical procurement analysis.

<br>

## Relationships

| Parent Table | Child Table | Relationship |
|--------------|-------------|--------------|
| Suppliers | Products | One-to-Many |
| Suppliers | Purchase_Orders | One-to-Many |

<br>

## Used In Analysis

The Suppliers table is used for:

- Supplier-wise Purchase Analysis
- Procurement Trend Analysis
- Supplier Performance
- Product Distribution by Supplier
- Purchase Volume by Supplier
- Geographic Distribution of Suppliers
- Supply Chain Reporting
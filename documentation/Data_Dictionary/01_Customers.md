# Customers Data Dictionary

## Purpose

The **Customers** table stores the master information of every customer registered with Vovers.

Each customer is uniquely identified by **Customer_ID** and may place zero or multiple orders through different sales channels.

This table supports customer analytics, segmentation, revenue analysis, retention analysis, and business intelligence reporting.

<br>

| Column Name | Data Type | PK | FK | Nullable | Default Value | Constraints / Allowed Values | Description |
|--------------|-----------|:--:|:--:|:--------:|---------------|------------------------------|-------------|
| Customer_ID | INT | Y | N | N | AUTO_INCREMENT | Positive Integer | Unique identifier assigned to each customer. |
| Customer_Name | VARCHAR(100) | N | N | N | None | Maximum 100 characters | Full name of the customer. |
| Gender | ENUM | N | N | N | None | Male, Female, Other | Gender of the customer. |
| Age | TINYINT | N | N | N | None | Age ≥ 18 | Age of the customer in completed years. |
| Customer_Type | ENUM | N | N | N | Individual | Individual, Business, Government | Category of customer account. |
| City | VARCHAR(50) | N | N | N | None | Valid Indian city names | Customer's city of residence. |
| State | VARCHAR(50) | N | N | N | None | Valid Indian state names | Customer's state of residence. |
| Region | ENUM | N | N | N | None | North, South, East, West, Central | Business region mapped from the customer's state. |
| Join_Date | DATE | N | N | N | CURRENT_DATE | Current date or earlier | Date on which the customer registered with Vovers. |

<br>

## Business Rules

- Every customer must have a unique **Customer_ID**.
- Every customer record must contain complete demographic and geographical information.
- Customers can belong to one of three customer types:
  - Individual
  - Business
  - Government
- Customer age must be **18 years or above**.
- Join_Date cannot be a future date.
- A customer may place **zero or multiple orders**.
- Customer records are never physically deleted from the database; inactive customers remain available for historical analysis.

<br>

## Relationships

| Parent Table | Child Table | Relationship |
|--------------|-------------|--------------|
| Customers | Orders | One-to-Many |

<br>

## Used In Analysis

The Customers table is used for:

- Customer Segmentation
- Revenue by Customer Type
- Revenue by Region
- Revenue by State
- Revenue by City
- Customer Growth
- Customer Retention
- Repeat Purchase Analysis
- Customer Lifetime Value (CLV)
- Regional Customer Distribution
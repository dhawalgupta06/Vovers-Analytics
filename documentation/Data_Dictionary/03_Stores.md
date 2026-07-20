# Stores Data Dictionary

## Purpose

The **Stores** table stores the master information of every Vovers retail outlet across India.

Each store is uniquely identified by **Store_ID** and is mapped to a servicing warehouse. This table forms the foundation for store-wise sales analysis, regional performance reporting, inventory management, and operational analytics.

<br>

| Column Name | Data Type | PK | FK | Nullable | Default Value | Constraints / Allowed Values | Description |
|--------------|-----------|:--:|:--:|:--------:|---------------|------------------------------|-------------|
| Store_ID | INT | Y | N | N | AUTO_INCREMENT | Positive Integer | Unique identifier assigned to each store. |
| City | VARCHAR(50) | N | N | N | None | Valid Indian city names | City where the store is located. |
| State | VARCHAR(50) | N | N | N | None | Valid Indian state names | State where the store is located. |
| Region | ENUM | N | N | N | None | North, South, East, West, Central | Business region in which the store operates. |
| Warehouse_ID | INT | N | Y | N | None | Must exist in Warehouses table | Warehouse responsible for supplying inventory to the store. |
| Store_Type | ENUM | N | N | N | None | Mall, Standalone, Airport | Classification of the retail outlet. |
| Opening_Date | DATE | N | N | N | None | Current date or earlier | Date on which the store started operations. |

<br>

## Business Rules

- Every store must have a unique **Store_ID**.
- Every store is assigned to exactly one warehouse.
- A warehouse can supply multiple stores.
- Every store belongs to exactly one business region.
- Opening_Date cannot be a future date.
- Store records are retained permanently for historical reporting, even if the store becomes inactive.

<br>

## Relationships

| Parent Table | Child Table | Relationship |
|--------------|-------------|--------------|
| Warehouses | Stores | One-to-Many |
| Stores | Orders | One-to-Many |
| Stores | Employees | One-to-Many |
| Stores | Inventory | One-to-Many |

<br>

## Used In Analysis

The Stores table is used for:

- Store-wise Revenue Analysis
- Revenue by Region
- Revenue by State
- Revenue by City
- Store Performance Comparison
- Average Order Value by Store
- Store-wise Customer Footfall
- Inventory Distribution
- Store Profitability
- Regional Sales Performance
- Store Opening Trend Analysis
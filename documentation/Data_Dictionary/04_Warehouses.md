# Warehouses Data Dictionary

## Purpose

The **Warehouses** table stores the master information of every Vovers warehouse across India.

Each warehouse is uniquely identified by **Warehouse_ID** and serves one or more retail stores within its operational area. This table supports inventory management, procurement, warehouse utilization analysis, and supply chain operations.

<br>

| Column Name | Data Type | PK | FK | Nullable | Default Value | Constraints / Allowed Values | Description |
|--------------|-----------|:--:|:--:|:--------:|---------------|------------------------------|-------------|
| Warehouse_ID | INT | Y | N | N | AUTO_INCREMENT | Positive Integer | Unique identifier assigned to each warehouse. |
| City | VARCHAR(50) | N | N | N | None | Valid Indian city names | City where the warehouse is located. |
| State | VARCHAR(50) | N | N | N | None | Valid Indian state names | State where the warehouse is located. |
| Region | ENUM | N | N | N | None | North, South, East, West, Central | Business region in which the warehouse operates. |
| Store_Capacity | INT | N | N | N | None | Greater than 0 | Maximum inventory storage capacity of the warehouse. |

<br>

## Business Rules

- Every warehouse must have a unique **Warehouse_ID**.
- A warehouse can supply one or more stores.
- Every warehouse belongs to exactly one business region.
- Store_Capacity must always be greater than zero.
- Warehouse records are retained permanently for historical inventory and procurement analysis.

<br>

## Relationships

| Parent Table | Child Table | Relationship |
|--------------|-------------|--------------|
| Warehouses | Stores | One-to-Many |
| Warehouses | Employees | One-to-Many |
| Warehouses | Inventory | One-to-Many |
| Warehouses | Purchase_Orders | One-to-Many |

<br>

## Used In Analysis

The Warehouses table is used for:

- Warehouse Capacity Analysis
- Inventory Distribution
- Warehouse Utilization
- Stock Availability
- Procurement Analysis
- Supply Chain Performance
- Warehouse-wise Inventory Levels
- Regional Inventory Analysis
- Purchase Volume by Warehouse
# Inventory Data Dictionary

## Purpose

The **Inventory** table stores the current stock quantity of every product available at each Vovers store and warehouse.

Each record represents the available quantity of a specific product at a particular inventory location. This table supports inventory tracking, stock movement, replenishment planning, warehouse operations, and inventory analytics.

<br>

| Column Name | Data Type | PK | FK | Nullable | Default Value | Constraints / Allowed Values | Description |
|--------------|-----------|:--:|:--:|:--------:|---------------|------------------------------|-------------|
| Inventory_ID | INT | Y | N | N | AUTO_INCREMENT | Positive Integer | Unique identifier assigned to each inventory record. |
| Location_Type | ENUM | N | N | N | None | Store, Warehouse | Type of inventory location. |
| Store_ID | INT | N | Y | Y | None | Must exist in Stores table | Store where inventory is maintained (if applicable). |
| Warehouse_ID | INT | N | Y | Y | None | Must exist in Warehouses table | Warehouse where inventory is maintained (if applicable). |
| Product_ID | INT | N | Y | N | None | Must exist in Products table | Product whose inventory is being tracked. |
| Quantity | INT | N | N | N | 0 | Quantity ≥ 0 | Current available stock quantity at the specified location. |

<br>

## Business Rules

- Every inventory record must have a unique **Inventory_ID**.
- Every inventory record must reference one product.
- Inventory can exist at either a **Store** or a **Warehouse**.
- At least one of **Store_ID** or **Warehouse_ID** must contain a valid value.
- Quantity cannot be negative.
- Inventory is updated whenever products are purchased, sold, returned, or transferred.
- A product may exist at multiple inventory locations.

<br>

## Relationships

| Parent Table | Child Table | Relationship |
|--------------|-------------|--------------|
| Products | Inventory | One-to-Many |
| Stores | Inventory | One-to-Many |
| Warehouses | Inventory | One-to-Many |

<br>

## Used In Analysis

The Inventory table is used for:

- Current Stock Analysis
- Inventory Distribution
- Store-wise Inventory
- Warehouse-wise Inventory
- Low Stock Identification
- Stock Availability
- Inventory Turnover
- Days Inventory Outstanding (DIO)
- Inventory Valuation
- Stock Replenishment Planning
- Category-wise Inventory Analysis
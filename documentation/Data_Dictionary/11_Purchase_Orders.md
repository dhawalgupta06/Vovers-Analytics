# Purchase_Orders Data Dictionary

## Purpose

The **Purchase_Orders** table stores the master information of every purchase order raised by Vovers to replenish inventory.

Each purchase order is uniquely identified by **Purchase_Order_ID** and records the supplier, destination warehouse, and purchase date. This table supports procurement management, inventory replenishment, supplier analysis, and supply chain reporting.

<br>

| Column Name | Data Type | PK | FK | Nullable | Default Value | Constraints / Allowed Values | Description |
|--------------|-----------|:--:|:--:|:--------:|---------------|------------------------------|-------------|
| Purchase_Order_ID | INT | Y | N | N | AUTO_INCREMENT | Positive Integer | Unique identifier assigned to each purchase order. |
| Supplier_ID | INT | N | Y | N | None | Must exist in Suppliers table | Supplier from whom products are being purchased. |
| Warehouse_ID | INT | N | Y | N | None | Must exist in Warehouses table | Warehouse receiving the purchased inventory. |
| Purchase_DateTime | DATETIME | N | N | N | CURRENT_TIMESTAMP | Current date and time or earlier | Date and time when the purchase order was created. |

<br>

## Business Rules

- Every purchase order must have a unique **Purchase_Order_ID**.
- Every purchase order must reference one supplier.
- Every purchase order must be delivered to one warehouse.
- A purchase order must contain one or more products in the **Purchase_Order_Details** table.
- Purchase_DateTime cannot be a future date and time.
- Purchase order records are permanently maintained for procurement history and auditing.
- Purchase orders are recorded only after goods have been physically received and verified at the warehouse.
- Inventory is updated immediately after a purchase order is recorded.
- Goods rejected during inspection are not recorded in the database.
- Purchase returns are outside the scope of this project.

<br>

## Relationships

| Parent Table | Child Table | Relationship |
|--------------|-------------|--------------|
| Suppliers | Purchase_Orders | One-to-Many |
| Warehouses | Purchase_Orders | One-to-Many |
| Purchase_Orders | Purchase_Order_Details | One-to-Many |

<br>

## Used In Analysis

The Purchase_Orders table is used for:

- Procurement Trend Analysis
- Purchase Volume Analysis
- Supplier-wise Procurement
- Warehouse-wise Procurement
- Purchase Frequency
- Supply Chain Reporting
- Inventory Replenishment Analysis
- Procurement Planning
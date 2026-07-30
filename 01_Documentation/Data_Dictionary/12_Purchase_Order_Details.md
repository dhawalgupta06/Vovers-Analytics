# Purchase_Order_Details Data Dictionary

## Purpose

The **Purchase_Order_Details** table stores the individual product variants included in every purchase order raised by Vovers.

Each record represents one product variant within a purchase order. This table enables multiple product variants to be included in a single purchase order while maintaining database normalization. It supports procurement analysis, inventory replenishment, supplier evaluation, and stock management.

<br>

| Column Name              | Data Type |  PK |  FK | Nullable | Default Value  | Constraints / Allowed Values         | Description                                                       |
| ------------------------ | --------- | :-: | :-: | :------: | -------------- | ------------------------------------ | ----------------------------------------------------------------- |
| Purchase_Order_Detail_ID | INT       |  Y  |  N  |     N    | AUTO_INCREMENT | Positive Integer                     | Unique identifier assigned to each purchase order item.           |
| Purchase_Order_ID        | INT       |  N  |  Y  |     N    | None           | Must exist in Purchase_Orders table  | Purchase order to which this product variant belongs.             |
| Variant_ID               | INT       |  N  |  Y  |     N    | None           | Must exist in Product_Variants table | Product variant included in the purchase order.                   |
| Quantity                 | INT       |  N  |  N  |     N    | 1              | Greater than 0                       | Number of units of the product variant ordered from the supplier. |

<br>

## Business Rules

* Every purchase order item must have a unique **Purchase_Order_Detail_ID**.
* Every purchase order item must belong to one purchase order.
* Every purchase order item must reference one product variant.
* Quantity must always be greater than zero.
* A purchase order can contain one or more product variants.
* The same product variant may appear in multiple purchase orders.
* Purchase order history is permanently maintained for procurement and auditing purposes.
* Cost prices are maintained at the **Product_Variants** level.
* Selling prices are maintained at the **Product_Variants** level.

<br>

## Relationships

| Parent Table     | Child Table            | Relationship |
| ---------------- | ---------------------- | ------------ |
| Purchase_Orders  | Purchase_Order_Details | One-to-Many  |
| Product_Variants | Purchase_Order_Details | One-to-Many  |

<br>

## Used In Analysis

The Purchase_Order_Details table is used for:

* Procurement Quantity Analysis
* Purchase Volume by Product Variant
* Supplier Purchase Analysis
* Product Replenishment Analysis
* Inventory Planning
* Procurement Cost Analysis
* Category-wise Procurement
* Warehouse Replenishment Analysis

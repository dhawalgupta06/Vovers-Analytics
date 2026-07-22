# Order_Details Data Dictionary

## Purpose

The **Order_Details** table stores the individual products included in every customer order.

Each record represents one product within an order. This table enables multiple products to be associated with a single order while maintaining database normalization. It forms the foundation for product-level sales analysis, revenue calculation, inventory deduction, discount analysis, and return management.

<br>

| Column Name | Data Type | PK | FK | Nullable | Default Value | Constraints / Allowed Values | Description |
|--------------|-----------|:--:|:--:|:--------:|---------------|------------------------------|-------------|
| Order_Detail_ID | INT | Y | N | N | AUTO_INCREMENT | Positive Integer | Unique identifier assigned to each order item. |
| Order_ID | INT | N | Y | N | None | Must exist in Orders table | Order to which this product belongs. |
| Product_ID | INT | N | Y | N | None | Must exist in Products table | Product included in the order. |
| Quantity | INT | N | N | N | 1 | Greater than or equal to 1 | Number of units ordered for the product. |
| Discount_Percentage | DECIMAL(5,2) | N | N | N | 0 | Between 0 and 100 | Discount percentage applied to the product at the time of sale. |

<br>

## Business Rules

- Every order item must have a unique **Order_Detail_ID**.
- Every order item must belong to one order.
- Every order item must reference one product.
- Quantity must always be greater than or equal to one.
- Discount percentage must always be between **0% and 50%**.
- An order can contain one or more products.
- The same product may appear in multiple different orders.
- Product selling prices remain fixed throughout the project timeline.
- Promotional pricing is handled using **Discount_Percentage**.
- Every return record must reference an existing **Order_Detail_ID**.

<br>

## Relationships

| Parent Table | Child Table | Relationship |
|--------------|-------------|--------------|
| Orders | Order_Details | One-to-Many |
| Products | Order_Details | One-to-Many |
| Order_Details | Returns | One-to-One / One-to-Many* |

<br>

> **Note:** An order item may have zero or one return transaction in this project. The relationship is shown as One-to-One for simplicity.

<br>

## Used In Analysis

The Order_Details table is used for:

- Product-wise Revenue
- Product-wise Units Sold
- Category-wise Revenue
- Brand-wise Revenue
- Discount Analysis
- Average Discount by Category
- Average Quantity per Order
- Best Selling Products
- Slow Moving Products
- Basket Size Analysis
- Product Mix Analysis
- Gross Profit Calculation
- Inventory Consumption
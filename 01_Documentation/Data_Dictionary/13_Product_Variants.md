# Product Variants Data Dictionary

## Table Overview

The **Product_Variants** table stores the sellable variants of each product. A single product can have multiple variants based on attributes such as **color**, **storage**, or **size**. Pricing is maintained at the variant level because different variants of the same product may have different costs and selling prices.

For example:

- iPhone 16 Pro
  - Black, 256GB
  - Black, 512GB
  - White, 256GB

Each of these is stored as a separate product variant.

---

## Table Structure

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| `variant_id` | INT | PRIMARY KEY, AUTO_INCREMENT | Unique identifier for each product variant. |
| `product_id` | INT | NOT NULL, FOREIGN KEY | References the product to which the variant belongs. |
| `color` | VARCHAR(30) | NULL | Color of the product variant (e.g., Black, White, Silver). |
| `storage` | VARCHAR(20) | NULL | Storage capacity of the variant where applicable (e.g., 128GB, 512GB, 1TB). |
| `size` | VARCHAR(20) | NULL | Size of the product where applicable (e.g., 55 Inch, 45 mm, XL). |
| `cost_price` | DECIMAL(10,2) | NOT NULL, CHECK (> 0) | Purchase cost of the product variant. |
| `selling_price` | DECIMAL(10,2) | NOT NULL, CHECK (> 0), CHECK (selling_price > cost_price) | Selling price of the product variant. |

---

## Business Rules

- Every product variant must belong to exactly one product.
- A product can have one or more variants.
- Variant attributes (`color`, `storage`, `size`) are optional and should remain `NULL` when they are not applicable.
- Cost price and selling price are maintained at the variant level because different variants may have different prices.
- Selling price must always be greater than cost price.
- Inventory, purchase transactions, sales transactions, and returns should reference the **variant_id** instead of the **product_id** to accurately identify the exact item involved.

---

## Examples

| Product | Color | Storage | Size |
|---------|--------|----------|------|
| iPhone 16 Pro | Black | 256GB | NULL |
| iPhone 16 Pro | White | 512GB | NULL |
| Samsung QLED TV | Black | NULL | 55 Inch |
| Apple Watch Series 10 | Midnight | NULL | 45 mm |
| Sony WH-1000XM6 | Silver | NULL | NULL |

---

## Relationships

| Related Table | Relationship |
|---------------|--------------|
| Products | Many Product Variants belong to one Product (`product_id`) |
| Inventory | References `variant_id` |
| Order_Details | References `variant_id` |
| Purchase_Order_Details | References `variant_id` |
| Return_Details *(if implemented)* | References `variant_id` |

---

## Purpose

This table enables Vovers ERP to:

- Manage multiple sellable variants of the same product.
- Maintain variant-specific pricing.
- Track inventory at the exact item level.
- Support accurate sales, purchase, and return transactions.
- Provide detailed analytics by color, storage, or size.
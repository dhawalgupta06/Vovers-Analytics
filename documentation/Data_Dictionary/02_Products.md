# Products Data Dictionary

## Purpose

The **Products** table stores the master information of every product sold by Vovers.

Each product is uniquely identified by **Product_ID** and is linked to a supplier. Product pricing information stored in this table forms the basis for sales, profitability, procurement, and inventory analysis.

<br>

| Column Name | Data Type | PK | FK | Nullable | Default Value | Constraints / Allowed Values | Description |
|--------------|-----------|:--:|:--:|:--------:|---------------|------------------------------|-------------|
| Product_ID | INT | Y | N | N | AUTO_INCREMENT | Positive Integer | Unique identifier assigned to each product. |
| Product_Name | VARCHAR(150) | N | N | N | None | Maximum 150 characters | Commercial name of the product. |
| Supplier_ID | INT | N | Y | N | None | Must exist in Suppliers table | Supplier responsible for providing the product. |
| Brand | VARCHAR(50) | N | N | N | None | Valid brand name | Brand under which the product is marketed. |
| Category | ENUM | N | N | N | None | Smartphones, Laptops, Tablets, Televisions, Audio Devices, Smart Watches, Home Appliances, Kitchen Appliances, Gaming, Accessories | Product category used for reporting and inventory classification. |
| Cost_Price | DECIMAL(10,2) | N | N | N | None | > 0 | Purchase price paid by Vovers to the supplier. |
| Selling_Price | DECIMAL(10,2) | N | N | N | None | > Cost_Price | Selling price offered to customers. |

<br>

## Business Rules

- Every product must have a unique **Product_ID**.
- Every product must be associated with one supplier.
- Every product belongs to exactly one category.
- Cost Price must always be greater than zero.
- Selling Price must always be greater than Cost Price.
- Product records are never deleted if transactions exist; inactive products remain available for historical reporting.

<br>

## Relationships

| Parent Table | Child Table | Relationship |
|--------------|-------------|--------------|
| Suppliers | Products | One-to-Many |
| Products | Order_Details | One-to-Many |
| Products | Inventory | One-to-Many |
| Products | Purchase_Order_Details | One-to-Many |

<br>

## Used In Analysis

The Products table is used for:

- Revenue by Product
- Revenue by Category
- Revenue by Brand
- Units Sold by Product
- Units Sold by Category
- Gross Profit Analysis
- Gross Margin Analysis
- Product Profitability
- Inventory Analysis
- Slow Moving Products
- Fast Moving Products
- Supplier Performance Analysis
- Purchase Trend Analysis
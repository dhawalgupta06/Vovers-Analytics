# Business Rules

## Purpose

This document defines the main business rules followed in the Vovers project.

These rules guide the database design, data generation, business analysis, and dashboard development.

<br>

# 1. Customer Rules

## Customer Registration

- Every customer must have a unique Customer ID.
- Customer age must be 18 years or above.
- Customer registration date cannot be in the future.
- A customer may exist without placing an order.

## Customer Orders

- A customer can place multiple orders.
- Every order belongs to one customer.
- Customers can purchase through different sales channels.
- Customer purchase history is identified using their Customer ID.

<br>

# 2. Product Rules

## Product Identification

- Every product must have a unique Product ID.
- Every product belongs to one category.
- Every product belongs to one brand.
- A product can have multiple product variants.

## Product Variants

- Every product variant must have a unique Variant ID.
- Every product variant belongs to one product.
- Variant attributes may include color, storage, and size depending on the product.
- Product pricing is maintained at the variant level.

## Product Pricing

- Cost Price must be greater than zero.
- Selling Price must be greater than zero.
- Selling Price must be greater than Cost Price.

<br>

# 3. Order Rules

## Order Creation

- Every order must have a unique Order ID.
- Every order belongs to one customer.
- Every order must contain at least one order line.
- One order can contain multiple order lines.
- Each order line represents a specific product variant.
- Order quantity must be greater than zero.
- Order date cannot be in the future.

## Discount Rules

- Discount percentage must be between 0% and 50%.
- Discounts above 50% are not permitted.
- A zero discount represents a full-price transaction.

<br>

# 4. Store Rules

- Every store must have a unique Store ID.
- Every store belongs to one city and state.
- Every store belongs to one business region.
- A store can have multiple employees.
- Stores can hold inventory for product variants.

<br>

# 5. Warehouse Rules

- Every warehouse must have a unique Warehouse ID.
- Warehouses are used to hold inventory.
- A warehouse can hold multiple product variants.
- Inventory quantity cannot be negative.

<br>

# 6. Supplier Rules

- Every supplier must have a unique Supplier ID.
- A supplier can be associated with multiple purchase orders.
- Purchase orders can contain multiple product variants.

<br>

# 7. Employee Rules

- Every employee must have a unique Employee ID.
- Every employee belongs to one department.
- Every employee has one designation.
- Employee age must be 18 years or above.
- Employee salary must be greater than zero.
- Employees can work at a Store, Warehouse, or Office.
- Store-based employees are associated with a Store ID.
- Warehouse-based employees are associated with a Warehouse ID.
- Office-based employees do not require a Store ID or Warehouse ID.

## Departments

Employees can belong to the following departments:

- Sales
- Warehouse
- Finance
- HR
- IT
- Operations
- Marketing

<br>

# 8. Return Rules

- Every return must have a unique Return ID.
- Every return must reference a valid order detail.
- Returned quantity must be greater than zero.
- Returned quantity cannot exceed the purchased quantity.
- Returns must occur after the original purchase.
- Return status must use one of the allowed return statuses defined in the database.

<br>

# 9. Inventory Rules

- Inventory is maintained at the product variant level.
- Inventory can be held at stores or warehouses.
- Inventory quantity cannot be negative.
- Each inventory record represents the available quantity of a product variant at a particular location.
- Store inventory must reference a valid Store ID.
- Warehouse inventory must reference a valid Warehouse ID.

<br>

# 10. Purchase Order Rules

- Every Purchase Order must have a unique Purchase Order ID.
- Every Purchase Order must belong to a registered supplier.
- Every Purchase Order must contain at least one purchase order line.
- Each purchase order line represents a specific product variant.
- Purchase quantity must be greater than zero.

<br>

# 11. Financial Rules

## Revenue

Revenue is calculated after applying the transaction discount.

**Revenue = Selling Price × Quantity × (1 − Discount Percentage)**

## Cost

Cost is calculated using the Cost Price of the product variant.

**Cost = Cost Price × Quantity**

## Gross Profit

Gross Profit represents the difference between Revenue and Cost.

**Gross Profit = Revenue − Cost**

## Gross Profit Margin

Gross Profit Margin measures Gross Profit as a percentage of Revenue.

**Gross Profit Margin = Gross Profit ÷ Revenue × 100**

## Procurement Value

Historical purchase prices are not stored in the dataset.

Therefore, procurement value is estimated using the current Cost Price of the product variant.

**Estimated Procurement Value = Purchase Quantity × Current Cost Price**

Estimated Procurement Value is an analytical estimate and should not be treated as actual historical procurement expenditure.

## Taxes

- Taxes are not included in the financial calculations used in this project.

<br>

# 12. Data Quality Rules

- Primary Keys must always be unique.
- Foreign Keys must reference valid records.
- Required fields cannot contain missing values.
- Missing values are allowed only where the database design permits them.
- Quantities cannot be negative.
- Prices and salaries must be greater than zero.
- Transaction dates must follow the logical sequence of business events.
- Relationships between customers, products, variants, orders, stores, warehouses, suppliers, employees, and returns must remain valid.

<br>

# 13. Analytical Rules

- Revenue and Gross Profit are calculated using product variant prices.
- Discounts are applied before calculating Gross Profit.
- Order counts are based on distinct Order IDs.
- Product-level order counts represent distinct orders containing the selected product or product variant.
- Inventory analysis is performed at the product variant and location level.
- Recent demand analysis uses the available transaction history rather than the current system date.
- Procurement value is treated as an estimated analytical measure because historical purchase prices are unavailable.
- Business thresholds used for analytical classifications are project-specific assumptions and are not universal industry standards.
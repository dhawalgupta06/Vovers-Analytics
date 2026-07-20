# Business Rules

## Purpose

This document defines the operational and business rules followed by Vovers.

These rules are used while generating datasets, designing the database, developing dashboards, and performing business analysis.

<br> 

# 1. Customer Rules

## Customer Registration

- Every customer must have a unique Customer ID.
- One mobile number can belong to only one customer.
- One email address can belong to only one customer.
- Customer age must be 18 years or above.
- Customer registration date cannot be in the future.

## Customer Orders

- A customer can place zero or many orders.
- Every order belongs to exactly one customer.
- Customers may purchase through physical stores or online channels.
- A customer's purchase history is permanently maintained.

<br> 

# 2. Product Rules

## Product Identification

- Every product has a unique Product ID.
- Every product belongs to one category.
- Every product belongs to one brand.
- Every product has one primary supplier.

## Product Pricing

- Cost Price must always be greater than zero.
- Selling Price must always be greater than Cost Price.
- Selling Price cannot become lower than Cost Price after discount.

<br> 

# 3. Order Rules

## Order Creation

- Every order has a unique Order ID.
- Every order must contain at least one product.
- One order may contain multiple products.
- Order date cannot be in the future.

## Payment Methods

Allowed payment methods:

- Cash
- UPI
- Credit Card
- Debit Card
- Net Banking

## Discount Rules

- Discount must lie between 0% and 50%.
- Discounts above 50% are not permitted.

<br> 

# 4. Store Rules

- Every store has a unique Store ID.
- Every store belongs to exactly one city.
- Every store belongs to one state.
- One store has one Store Manager.
- One store can employ multiple employees.

<br> 

# 5. Warehouse Rules

- Every warehouse has a unique Warehouse ID.
- One warehouse can supply multiple stores.
- Inventory quantity cannot become negative.
- Every inventory movement must be recorded.

<br> 

# 6. Supplier Rules

- Every supplier has a unique Supplier ID.
- One supplier can supply multiple products.
- Every product has one primary supplier.

<br> 

# 7. Employee Rules

- Every employee has a unique Employee ID.
- Every employee belongs to one department.
- One employee may process multiple orders.
- Employees are assigned to one store.

Departments include:

- Sales
- Inventory
- Finance
- HR
- Customer Service
- Operations

<br> 

# 8. Return Rules

- Returns are allowed within 30 days of purchase.
- Returned quantity cannot exceed purchased quantity.
- Every return must reference an existing order.
- Refund amount equals the amount paid after discount.

<br> 

# 9. Inventory Rules

- Inventory is maintained warehouse-wise.
- Stock cannot become negative.
- Inventory updates immediately after every sale, return, or purchase.

<br> 

# 10. Purchase Rules

- Purchase Orders can only be created for registered suppliers.
- Every Purchase Order contains at least one product.
- Purchase quantity must always be greater than zero.

<br> 

# 11. Financial Rules

- Revenue = Selling Price × Quantity − Discount
- Profit = Revenue − Cost
- Discounts reduce revenue only.
- Taxes are ignored in this project for simplicity.

<br> 

# 11. Data Quality Rules

- Primary Keys must always be unique.
- Foreign Keys must always reference valid records.
- Duplicate transactional records are not allowed.
- Missing values are permitted only where explicitly defined.
- Dates must follow chronological order.
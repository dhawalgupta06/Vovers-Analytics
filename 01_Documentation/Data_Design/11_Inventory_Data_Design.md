# Data Design - Inventory Table

## Purpose

This document defines the business rules, assumptions, and distributions used to design the **Inventory** table of the **Vovers ERP Database**.

The objective is to ensure that the generated dataset reflects realistic inventory management practices instead of random values, making it suitable for:

- SQL Analysis
- Python Analytics
- Excel Dashboards
- Power BI Reports
- Business Case Studies
- Portfolio Projects

<br/>

# Inventory Table

## Total Inventory Records

- **TBD**

<br/>

## Location Type Distribution

- Store : TBD
- Warehouse : TBD

<br/>

## Product Variant Availability

### Warehouses

- TBD

<br/>

### Stores

- TBD

<br/>

## Category-wise Inventory Quantity Guidelines

| Category | Store Stock | Warehouse Stock |
|----------|------------:|----------------:|
| Smartphones | TBD | TBD |
| Laptops | TBD | TBD |
| Tablets | TBD | TBD |
| Televisions | TBD | TBD |
| Audio Devices | TBD | TBD |
| Smart Watches | TBD | TBD |
| Home Appliances | TBD | TBD |
| Kitchen Appliances | TBD | TBD |
| Gaming | TBD | TBD |
| Accessories | TBD | TBD |

> **Note:** These ranges represent the typical closing inventory available for each Product Variant at a location. Actual inventory levels vary depending on customer demand, procurement cycles, warehouse capacity, and sales.

<br/>

## Business Assumptions

- Inventory is maintained at the **Product Variant** level.
- Inventory records represent the closing stock available at the time of dataset generation.
- Every Inventory record belongs to either one **Store** or one **Warehouse**.
- When **Location_Type = 'Store'**, only **Store_ID** is populated.
- When **Location_Type = 'Warehouse'**, only **Warehouse_ID** is populated.
- Inventory Quantity is always greater than or equal to **0**.
- Warehouses generally maintain higher inventory levels than Stores.
- Fast-moving product categories are typically stocked in larger quantities than slow-moving categories.
- Inventory levels are influenced by procurement, customer demand, and warehouse replenishment policies.
- Each Product Variant appears only once for a given Store or Warehouse.# Data Design - Inventory Table

## Purpose

This document defines the business rules, assumptions, and distributions used to design the **Inventory** table of the **Vovers ERP Database**.

The objective is to ensure that the generated dataset reflects realistic inventory management practices instead of random values, making it suitable for:

- SQL Analysis
- Python Analytics
- Excel Dashboards
- Power BI Reports
- Business Case Studies
- Portfolio Projects

<br/>

# Inventory Table

## Total Inventory Records

- **TBD**

<br/>

## Location Type Distribution

- Store : TBD
- Warehouse : TBD

<br/>

## Product Variant Availability

### Warehouses

- TBD

<br/>

### Stores

- TBD

<br/>

## Category-wise Inventory Quantity Guidelines

| Category | Store Stock | Warehouse Stock |
|----------|------------:|----------------:|
| Smartphones | TBD | TBD |
| Laptops | TBD | TBD |
| Tablets | TBD | TBD |
| Televisions | TBD | TBD |
| Audio Devices | TBD | TBD |
| Smart Watches | TBD | TBD |
| Home Appliances | TBD | TBD |
| Kitchen Appliances | TBD | TBD |
| Gaming | TBD | TBD |
| Accessories | TBD | TBD |

> **Note:** These ranges represent the typical closing inventory available for each Product Variant at a location. Actual inventory levels vary depending on customer demand, procurement cycles, warehouse capacity, and sales.

<br/>

## Business Assumptions

- Inventory is maintained at the **Product Variant** level.
- Inventory records represent the closing stock available at the time of dataset generation.
- Every Inventory record belongs to either one **Store** or one **Warehouse**.
- When **Location_Type = 'Store'**, only **Store_ID** is populated.
- When **Location_Type = 'Warehouse'**, only **Warehouse_ID** is populated.
- Inventory Quantity is always greater than or equal to **0**.
- Warehouses generally maintain higher inventory levels than Stores.
- Fast-moving product categories are typically stocked in larger quantities than slow-moving categories.
- Inventory levels are influenced by procurement, customer demand, and warehouse replenishment policies.
- Each Product Variant appears only once for a given Store or Warehouse.
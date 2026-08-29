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

- Dynamic; determined by the allocation of each Product Variant's fixed closing inventory quantity across eligible Stores and Warehouses.
- No arbitrary fixed number of Inventory records is imposed.
- The final record count depends on the number of Store and Warehouse locations across which each Product Variant's available inventory is distributed.

<br/>

## Location Type Distribution

- **Store : Approximately 55%–65% of total inventory units**
- **Warehouse : Approximately 35%–45% of total inventory units**

> **Note:** These percentages are target ranges for the overall inventory distribution and are not hard quotas. The fixed total inventory quantity of each Product Variant takes priority over achieving an exact Store/Warehouse distribution.

<br/>

## Product Variant Availability

### Warehouses

- Every Product Variant should be available in at least one Warehouse whenever its total current inventory quantity permits.
- High-demand and widely sold Product Variants should generally be distributed across multiple Warehouses.
- Lower-demand or specialized Product Variants may be concentrated in fewer Warehouses.
- Warehouses are expected to carry a broad assortment of the company's Product Variants.
- Warehouses generally maintain deeper stock per stocked Product Variant than an individual Store.

<br/>

### Stores

- Stores carry selected Product Variants based on assortment breadth, demand, Store Type, and available inventory quantity.
- Product Variants should generally be distributed across multiple Stores when sufficient inventory is available.
- Stores are not expected to carry every Product Variant.
- Mall and Standalone Stores generally carry broader assortments than Airport Stores.
- Fast-moving and mainstream Product Variants should generally have wider Store availability than specialized or slow-moving Product Variants.
- No operating Store should be left with an unrealistically narrow assortment merely because of random allocation.
- Store-level assortment breadth must remain constrained by the fixed total inventory quantity available for each Product Variant.

<br/>

## Category-wise Inventory Quantity Guidelines

| Category | Store Stock | Warehouse Stock |
|----------|------------:|----------------:|
| Smartphones | 1–4 | 3–10 |
| Laptops | 1–3 | 2–7 |
| Tablets | 1–3 | 2–7 |
| Televisions | 1–2 | 2–6 |
| Audio Devices | 1–5 | 3–10 |
| Smart Watches | 1–4 | 3–8 |
| Home Appliances | 1–2 | 2–6 |
| Kitchen Appliances | 1–3 | 2–7 |
| Gaming | 1–3 | 2–6 |
| Accessories | 2–8 | 5–15 |

> **Note:** These ranges represent typical allocation guidelines for the closing inventory of a Product Variant at an individual location. They do not determine or modify the total inventory quantity of a Product Variant. Actual location-level quantities may vary depending on the Product Variant's fixed available inventory, customer demand, assortment breadth, procurement cycles, warehouse capacity, and sales.

<br/>

## Inventory Quantity Conservation

- The total Inventory Quantity of each Product Variant is fixed before location-level inventory allocation.
- Inventory allocation only redistributes the existing closing inventory of each Product Variant across Stores and Warehouses.
- Inventory allocation must not create or remove inventory units.
- The total quantity of every Product Variant must remain unchanged before and after inventory redistribution.
- For every Product Variant:

  **Total Store Inventory + Total Warehouse Inventory = Existing Total Inventory Quantity of the Product Variant**

- Location-level allocation rules, Store/Warehouse distribution targets, and category-wise quantity guidelines must never override this quantity conservation rule.

<br/>

## Business Assumptions

- Inventory is maintained at the **Product Variant** level.
- Inventory records represent the closing stock available at the time of dataset generation.
- Every Inventory record belongs to either one **Store** or one **Warehouse**.
- When **Location_Type = 'Store'**, only **Store_ID** is populated.
- When **Location_Type = 'Warehouse'**, only **Warehouse_ID** is populated.
- Inventory Quantity is always greater than or equal to **0**.
- Warehouses generally maintain higher inventory levels per stocked Product Variant than individual Stores.
- Fast-moving product categories are typically stocked more widely and/or in larger quantities than slow-moving categories.
- Inventory levels are influenced by procurement, customer demand, warehouse replenishment policies, and Store assortment requirements.
- Each Product Variant appears only once for a given Store or Warehouse.
- A Product Variant may appear across multiple Stores and Warehouses.
- Stores are not required to carry the complete company-wide Product Variant assortment.
- Warehouses generally maintain a broader Product Variant assortment than individual Stores.
- Store assortment breadth may vary by Store Type, with Mall and Standalone Stores generally carrying broader assortments than Airport Stores.
- Missing Store–Variant or Warehouse–Variant combinations do not automatically represent zero stock unless the business allocation rules establish that the Product Variant is intended to be stocked at that location.
- The fixed total inventory quantity of every Product Variant must be preserved during all location-level allocation and redistribution processes.
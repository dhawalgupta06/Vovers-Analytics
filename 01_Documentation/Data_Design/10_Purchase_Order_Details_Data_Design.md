# Data Design - Purchase Order Details Table

## Purpose

This document defines the business rules, assumptions, and distributions used to design the **Purchase Order Details** table of the **Vovers ERP Database**.

The objective is to ensure that the generated dataset reflects realistic procurement behaviour instead of random values, making it suitable for:

- SQL Analysis
- Python Analytics
- Excel Dashboards
- Power BI Reports
- Business Case Studies
- Portfolio Projects

<br/>

# Purchase Order Details Table

## Total Purchase Order Details

- **20,000**

<br/>

## Category-wise Procurement Quantity Guidelines

| Category | Typical Procurement Quantity |
| ------------------ | --------------------------: |
| Smartphones        | **20–60 Units** |
| Laptops            | **10–30 Units** |
| Tablets            | **10–25 Units** |
| Televisions        | **10–25 Units** |
| Audio Devices      | **50–150 Units** |
| Smart Watches      | **30–80 Units** |
| Home Appliances    | **10–25 Units** |
| Kitchen Appliances | **20–50 Units** |
| Gaming             | **10–20 Units** |
| Accessories        | **100–300 Units** |

> **Note:** The procurement quantity ranges represent typical replenishment quantities for each product category. Actual quantities depend on product demand, warehouse requirements, supplier availability, seasonal demand, and inventory levels.

<br/>

## Business Assumptions

- Every Purchase Order Detail belongs to one valid **Purchase Order**.
- Every Purchase Order Detail references one valid **Product Variant**.
- Quantity is always greater than **0**.
- Multiple Product Variants can exist within the same Purchase Order.
- A Product Variant may appear in multiple Purchase Orders over time.
- Procurement quantities vary according to the product category and expected customer demand.
- Fast-moving product categories are generally procured in larger quantities than premium and low-volume categories.
- Procurement quantities are influenced by warehouse replenishment requirements, seasonal demand, and inventory planning.
- Purchase Orders may contain a combination of high-demand and low-demand product categories.
# Data Design - Order Details Table

## Purpose

This document defines the business rules, assumptions, and distributions used to design the **Order Details** table of the **Vovers ERP Database**.

The objective is to ensure that the generated dataset reflects realistic customer purchasing behaviour instead of random values, making it suitable for:

- SQL Analysis
- Python Analytics
- Excel Dashboards
- Power BI Reports
- Business Case Studies
- Portfolio Projects

<br/>

# Order Details Table

## Total Order Details

- **200,000**

<br/>

## Quantity Distribution

- 1 : 82% (**164,000 Order Details**)
- 2 : 12% (**24,000 Order Details**)
- 3 : 4% (**8,000 Order Details**)
- 4 : 1.5% (**3,000 Order Details**)
- 5+ : 0.5% (**1,000 Order Details**)

<br/>

## Discount Percentage Distribution

| Category           | Average Discount |
| ------------------ | ---------------: |
| Smartphones        |       **12–18%** |
| Laptops            |        **8–15%** |
| Tablets            |        **5–10%** |
| Televisions        |        **8–15%** |
| Audio Devices      |       **10–20%** |
| Smart Watches      |       **10–18%** |
| Home Appliances    |        **8–15%** |
| Kitchen Appliances |        **8–15%** |
| Gaming             |         **3–8%** |
| Accessories        |       **15–30%** |


<br/>

## Business Assumptions

- Every Order Detail belongs to one valid **Order**.
- Every Order Detail references one valid **Product Variant**.
- Quantity is always greater than or equal to **1**.
- Most customers purchase a single unit of a product variant in one order.
- Higher quantities are primarily associated with business customers and accessory purchases.
- Discount Percentage ranges between **0%** and **50%**.
- Most products are sold at full price or with small promotional discounts.
- Higher discounts are limited to promotional campaigns, clearance sales, bundled offers, and business purchases.
- Discounts are applied at the individual product level rather than the entire order.
- Multiple Order Details within the same order may have different discount percentages.
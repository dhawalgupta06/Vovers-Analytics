# Data Design - Orders Table

## Purpose

This document defines the business rules, assumptions, and distributions used to design the **Orders** table of the **Vovers ERP Database**.

The objective is to ensure that the generated dataset reflects realistic business behaviour instead of random values, making it suitable for:

- SQL Analysis
- Python Analytics
- Excel Dashboards
- Power BI Reports
- Business Case Studies
- Portfolio Projects

<br/>

# Orders Table

## Total Orders

- **125,000**

<br/>

## Order Date Distribution

- 2016 : 1% (**1,250 Orders**)
- 2017 : 2% (**2,500 Orders**)
- 2018 : 4% (**5,000 Orders**)
- 2019 : 7% (**8,750 Orders**)
- 2020 : 9% (**11,250 Orders**)
- 2021 : 11% (**13,750 Orders**)
- 2022 : 14% (**17,500 Orders**)
- 2023 : 16% (**20,000 Orders**)
- 2024 : 18% (**22,500 Orders**)
- 2025 : 14% (**17,500 Orders**)
- 2026* : 4% (**5,000 Orders**)

<br/>

## Sales Channel Distribution

- Offline Store : 58% (**72,500 Orders**)
- Website : 12% (**15,000 Orders**)
- Mobile App : 15% (**18,750 Orders**)
- Amazon : 8% (**10,000 Orders**)
- Flipkart : 7% (**8,750 Orders**)

<br/>

## Payment Method Distribution

- Cash : 18% (**22,500 Orders**)
- Card : 24% (**30,000 Orders**)
- UPI : 46% (**57,500 Orders**)
- Net Banking : 12% (**15,000 Orders**)

<br/>

## Business Assumptions

- Vovers started accepting customer orders in **2016**.
- Order volume increases over the years as the company expands its customer base and retail network.
- 2026 order data represents a partial year.
- Every order is linked to a valid **Customer_ID**.
- Orders cannot exist before the respective customer's **Join_Date**.
- Order Date cannot be in the future.
- Every order is fulfilled through a valid **Store_ID**.
- Offline Store orders are placed directly at the assigned store.
- Website, Mobile App, Amazon, and Flipkart orders are fulfilled by the nearest servicing store.
- UPI is the most commonly used payment method.
- Cash payments primarily occur through Offline Store purchases.
- Net Banking is primarily used for high-value online purchases and business customer orders.
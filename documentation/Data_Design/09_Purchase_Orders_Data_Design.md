# Data Design - Purchase Orders Table

## Purpose

This document defines the business rules, assumptions, and distributions used to design the **Purchase Orders** table of the **Vovers ERP Database**.

The objective is to ensure that the generated dataset reflects realistic procurement behaviour instead of random values, making it suitable for:

- SQL Analysis
- Python Analytics
- Excel Dashboards
- Power BI Reports
- Business Case Studies
- Portfolio Projects

<br/>

# Purchase Orders Table

## Total Purchase Orders

- **2,500**

<br/>

## Purchase Date Distribution

- 2016 : 2% (**50 Purchase Orders**)
- 2017 : 3% (**75 Purchase Orders**)
- 2018 : 5% (**125 Purchase Orders**)
- 2019 : 7% (**175 Purchase Orders**)
- 2020 : 9% (**225 Purchase Orders**)
- 2021 : 11% (**275 Purchase Orders**)
- 2022 : 14% (**350 Purchase Orders**)
- 2023 : 16% (**400 Purchase Orders**)
- 2024 : 17% (**425 Purchase Orders**)
- 2025 : 12% (**300 Purchase Orders**)
- 2026* : 4% (**100 Purchase Orders**)

<br/>

## Business Assumptions

- Vovers started placing Purchase Orders in **2016**.
- Purchase Order volume increases as the company expands its store network and inventory requirements.
- 2026 Purchase Order data represents a partial year.
- Every Purchase Order is associated with one valid **Supplier**.
- Every Purchase Order is delivered to one valid **Warehouse**.
- Purchase Date cannot be in the future.
- Multiple Purchase Orders may be placed with the same Supplier over time.
- A Warehouse can receive Purchase Orders from multiple Suppliers.
- Purchase Orders are created to replenish inventory and introduce new product variants.
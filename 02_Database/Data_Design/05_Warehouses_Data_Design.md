# Data Design - Warehouses Table

## Purpose

This document defines the business rules, assumptions, and distributions used to design the **Warehouses** table of the **Vovers ERP Database**.

The objective is to ensure that warehouse locations and storage capacities reflect a realistic distribution network for a mid-sized Indian consumer electronics retailer, making it suitable for:

- SQL Analysis
- Python Analytics
- Excel Dashboards
- Power BI Reports
- Business Case Studies
- Portfolio Projects

<br/>

# Warehouses Table

## Total Warehouses

- 12

<br/>

## Region, State and City Distribution

### North : 4 Warehouses

#### Haryana
- Gurugram (Large Warehouse)

<br/>

#### Delhi
- New Delhi (Medium Warehouse)

<br/>

#### Rajasthan
- Jaipur (Small Warehouse)

<br/>

#### Uttar Pradesh
- Lucknow (Small Warehouse)

<br/>

---

### West : 3 Warehouses

#### Maharashtra
- Mumbai (Large Warehouse)
- Pune (Small Warehouse)

<br/>

#### Gujarat
- Ahmedabad (Medium Warehouse)

<br/>

---

### South : 3 Warehouses

#### Karnataka
- Bengaluru (Large Warehouse)

<br/>

#### Tamil Nadu
- Chennai (Medium Warehouse)

<br/>

#### Telangana
- Hyderabad (Medium Warehouse)

<br/>

---

### East : 1 Warehouse

#### West Bengal
- Kolkata (Small Warehouse)

<br/>

---

### Central : 1 Warehouse

#### Madhya Pradesh
- Indore (Small Warehouse)

<br/>

## Warehouse Capacity Distribution

| Warehouse | Warehouse Type | Storage Capacity (Units) |
|------------|----------------|-------------------------:|
| Gurugram | Large | 25,000 |
| Mumbai | Large | 25,000 |
| Bengaluru | Large | 25,000 |
| New Delhi | Medium | 15,000 |
| Chennai | Medium | 15,000 |
| Hyderabad | Medium | 15,000 |
| Ahmedabad | Medium | 15,000 |
| Jaipur | Small | 8,000 |
| Lucknow | Small | 8,000 |
| Pune | Small | 8,000 |
| Kolkata | Small | 8,000 |
| Indore | Small | 8,000 |

<br/>

## Warehouse Type Distribution

- Large Warehouses : 3
- Medium Warehouses : 4
- Small Warehouses : 5

<br/>

## Business Assumptions

- Warehouses are strategically located near major logistics, manufacturing, and distribution hubs rather than according to customer population.
- Large warehouses act as **Regional Distribution Centers (RDCs)** for North, West, and South India.
- Medium warehouses primarily support nearby states and replenish retail stores within their region.
- Small warehouses serve as regional fulfillment hubs for faster inventory movement.
- Every warehouse can store all product categories.
- Inventory is maintained at the **Product Variant** level.
- All warehouses are assumed to be operational throughout the project timeline.
- Inter-warehouse stock transfers are allowed whenever inventory balancing is required.
# Database Schema

## Purpose

This document defines the database structure of the Vovers Business & Finance Analytics Platform.

The schema has been designed to support business operations, financial analysis, inventory management, customer analytics, and executive reporting while maintaining referential integrity and normalization.

<br>

# Master Tables

## Customers

| Column |
|---------|
| Customer_ID |
| Customer_Name |
| Gender |
| Age |
| Customer_Type |
| City |
| State |
| Region |
| Join_Date |

### Customer Types

- Individual
- Business
- Government

### Gender

- Male
- Female
- Other

<br>

## Products

| Column |
|---------|
| Product_ID |
| Product_Name |
| Supplier_ID |
| Brand |
| Category |

<br>

## Product_Variants

| Column |
|---------|
| Variant_ID |
| Product_ID |
| Color |
| Storage |
| Size |
| Cost_Price |
| Selling_Price |

<br/>

## Stores

| Column |
|---------|
| Store_ID |
| City |
| State |
| Region |
| Warehouse_ID |
| Store_Type |
| Opening_Date |

### Store Types

- Mall
- Standalone
- Airport

<br>

## Warehouses

| Column |
|---------|
| Warehouse_ID |
| City |
| State |
| Region |
| Store_Capacity |

<br>

## Employees

| Column |
|---------|
| Employee_ID |
| Employee_Name |
| Gender |
| Age |
| Department |
| Designation |
| Store_ID |
| Warehouse_ID |
| Join_Date |
| Salary |

<br>

## Suppliers

| Column |
|---------|
| Supplier_ID |
| Supplier_Name |
| Contact_Person |
| Phone |
| Email |
| City |
| State |

<br>

# Transaction Tables

## Orders

| Column |
|---------|
| Order_ID |
| Customer_ID |
| Store_ID |
| Order_DateTime |
| Sales_Channel |
| Payment_Method |

### Sales Channels

- Offline Store
- Website
- Mobile App
- Amazon
- Flipkart

### Payment Methods

- Cash
- Card
- UPI
- Net Banking

<br>

## Order Details

| Column |
|---------|
| Order_Detail_ID |
| Order_ID |
| Variant_ID |
| Quantity |

<br>

## Inventory

| Column |
|---------|
| Inventory_ID |
| Location_Type |
| Store_ID |
| Warehouse_ID |
| Variant_ID |
| Quantity |

### Location Types

- Store
- Warehouse

<br>

## Returns

| Column |
|---------|
| Return_ID |
| Order_Detail_ID |
| Return_DateTime |
| Returned_Quantity |
| Return_Status |

### Return Status

- Requested
- Approved
- Rejected
- Refunded
- Replaced

<br>

## Purchase Orders

| Column |
|---------|
| Purchase_Order_ID |
| Supplier_ID |
| Warehouse_ID |
| Purchase_DateTime |

<br>

## Purchase Order Details

| Column |
|---------|
| Purchase_Order_Detail_ID |
| Purchase_Order_ID |
| Variant_ID |
| Quantity |

<br>

# Initial Dataset Size

| Table | Records |
|--------|--------:|
| Customers | 100,000 |
| Products | 250 |
| Product Variants | Dynamic |
| Stores | 120 |
| Warehouses | 12 |
| Employees | 2,652 |
| Suppliers | 40 |
| Orders | 125,000 |
| Order Details | 2,00,000 |
| Inventory | Dynamic |
| Returns | 3,600 |
| Purchase Orders | 2,500 |
| Purchase Order Details | 20,000 |

<br/>

## Dataset Assumptions

- The dataset represents a **realistic analytical sample** of Vovers ERP operations.
- Product Variants are generated dynamically based on category-specific variation requirements.
- Inventory is a dynamic snapshot table representing current stock availability across warehouses.
- Every Order contains **at least one** Order Detail.
- Average products per Order is approximately **1.6**, resulting in around **192,000 Order Details**.
- Approximately **3% of Orders** result in Returns.
- Purchase Orders are generated based on warehouse replenishment requirements.
- Each Purchase Order contains an average of **8 products**, resulting in approximately **20,000 Purchase Order Details**.
- Customer Join Date, Employee Join Date, Orders, Returns, and Purchase Orders remain logically consistent during data generation.
- Orders are generated only **after** a customer's Join Date.
- Employees' Age, Join Date, Designation, and Salary remain logically consistent during data generation.

<br/>

---

# Design Principles

- The database follows relational database design principles.
- Master tables store static business entities.
- Transaction tables record day-to-day business activities.
- Every master table will have a Primary Key.
- Transaction tables will reference master tables through Foreign Keys.
- The schema is designed to support SQL analysis, Python analytics, Excel reporting, and Power BI dashboards.
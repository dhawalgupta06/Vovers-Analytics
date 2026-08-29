# SQL Analysis Overview

## Purpose

This document provides an overview of the SQL-based business analysis performed in the **Vovers Analytics** project.

The analysis was divided into eight major business areas. Each area was designed around practical business questions and used SQL to transform transactional and operational data into meaningful business metrics, trends, and insights.

<br>

# 1. Overall Business Performance Analysis

## Objective

Evaluate the overall performance of Vovers and understand how the business is performing over time.

## Analysis Performed

### Revenue Performance
- Total Revenue
- Yearly Revenue Trend
- Quarterly Revenue Trend
- Monthly Revenue Trend
- Revenue Growth

### Profitability Performance
- Gross Profit
- Gross Profit Margin
- Yearly Gross Profit Trend
- Quarterly Gross Profit Trend
- Monthly Gross Profit Trend

### Order Performance
- Total Orders
- Total Units Sold
- Average Order Value
- Yearly Order Trend
- Quarterly Order Trend
- Monthly Order Trend
- Average Order Value Trend

### Customer Performance
- Total Purchasing Customers
- Customer Activity Trends

<br>

# 2. Customer Analysis

## Objective

Analyse customer acquisition, demographics, purchasing behaviour, preferences, value, and loyalty to understand how customers contribute to business performance.

## Analysis Performed

### Customer Acquisition
- Total Registered Customers
- Total Purchasing Customers
- Customer Acquisition Growth
- Customer Acquisition Trend
- Customer Acquisition by State
- Customer Acquisition by City
- Customer Acquisition by Region

### Customer Demographics
- Customer Distribution by Gender
- Customer Age Distribution
- Customer Age Group Distribution
- Average Customer Age
- Customer Distribution by City
- Customer Distribution by State
- Customer Distribution by Region

### Customer Purchasing Behaviour
- Total Orders per Customer
- Average Orders per Customer
- Repeat Customers
- One-Time Customers
- Repeat Purchase Rate
- Average Days Between Purchases
- First Purchase Date
- Latest Purchase Date

### Customer Purchase Preferences
- Preferred Product
- Preferred Category
- Preferred Brand
- Preferred Sales Channel
- Preferred Payment Method

### Customer Value & Profitability
- Customer Lifetime Revenue
- Customer Lifetime Orders
- Customer Lifetime Gross Profit
- Average Revenue per Customer
- Customer Revenue Contribution
- Gross Profit Contribution
- Average Order Value per Customer
- Top Customers by Revenue
- Top Customers by Gross Profit
- Customer Revenue Concentration

### Customer Loyalty

Customer loyalty analysis was extended using Python for:

- RFM Analysis
- Customer Segmentation
- Cohort Analysis
- Customer Retention Analysis

<br>

# 3. Product Analysis

## Objective

Evaluate the Vovers product portfolio to identify major sales and profit drivers, understand category and brand performance, analyse product growth, and identify the products and variants that contribute most to business performance.

## Analysis Performed

### Product Sales Performance
- Revenue by Product
- Units Sold by Product
- Orders by Product
- Average Selling Price
- Average Units per Order
- Revenue Contribution
- Units Contribution

### Product Profitability
- Gross Profit by Product
- Gross Profit Margin
- Profit per Unit
- Gross Profit Contribution
- Revenue vs Gross Profit Performance
- High-Revenue / Low-Margin Products
- Low-Revenue / High-Margin Products

### Category Performance
- Revenue by Category
- Units Sold by Category
- Gross Profit by Category
- Gross Profit Margin by Category
- Revenue Contribution by Category
- Gross Profit Contribution by Category

### Brand Performance
- Revenue by Brand
- Units Sold by Brand
- Gross Profit by Brand
- Gross Profit Margin by Brand
- Revenue Contribution by Brand
- Gross Profit Contribution by Brand

### Product Growth & Trends
- Product Revenue Growth
- Product Units Sold Growth
- Category Revenue Growth
- Brand Revenue Growth
- Fastest-Growing Products
- Fastest-Declining Products

### Product Portfolio Concentration
- Product Revenue Contribution
- Cumulative Revenue Contribution
- Products Generating Approximately 80% of Revenue
- Gross Profit Contribution
- Cumulative Gross Profit Contribution
- Products Generating Approximately 80% of Gross Profit

### ABC Product Classification
- Product Ranking by Business Contribution
- Cumulative Contribution Analysis
- A — High Importance Products
- B — Medium Importance Products
- C — Lower Importance Products

### Product Variant Performance
- Revenue by Product Variant
- Units Sold by Product Variant
- Gross Profit by Product Variant
- Gross Profit Margin by Product Variant
- Best-Performing Product Variants

<br>

# 4. Sales, Region & Store Analysis

## Objective

Evaluate sales channel, store, and geographic performance to understand where Vovers generates revenue and profit and identify differences in performance across locations.

## Analysis Performed

### Sales Channel Performance
- Revenue by Sales Channel
- Orders by Sales Channel
- Units Sold by Sales Channel
- Average Order Value by Sales Channel
- Gross Profit by Sales Channel
- Gross Profit Margin by Sales Channel
- Revenue Contribution by Sales Channel
- Gross Profit Contribution by Sales Channel

### Store Performance
- Revenue by Store
- Orders by Store
- Units Sold by Store
- Average Order Value by Store
- Gross Profit by Store
- Gross Profit Margin by Store
- Revenue Contribution by Store
- Gross Profit Contribution by Store
- Best-Performing Stores
- Lowest-Performing Stores
- Store Type Performance

### Geographic Performance

#### State Level
- Revenue by State
- Orders by State
- Units Sold by State
- Gross Profit by State
- Gross Profit Margin by State
- Revenue Contribution by State
- Gross Profit Contribution by State

#### City Level
- Revenue by City
- Orders by City
- Units Sold by City
- Gross Profit by City
- Gross Profit Margin by City
- Top and Bottom Performing Cities

#### Regional Level
- Revenue by Region
- Orders by Region
- Units Sold by Region
- Gross Profit by Region
- Gross Profit Margin by Region
- Revenue Contribution by Region
- Gross Profit Contribution by Region

### Store & Geographic Growth
- Year-over-Year Store Revenue Growth
- Year-over-Year Store Gross Profit Growth
- Regional Revenue Growth
- State Revenue Growth

<br>

# 5. Inventory Analysis

## Objective

Evaluate the current inventory position, identify stock availability issues, compare inventory with recent sales demand, and assess whether inventory is appropriately distributed across the business.

## Analysis Performed

### Current Inventory Position
- Total Inventory Units
- Inventory Value at Cost
- Inventory Value at Selling Price
- Store Inventory
- Warehouse Inventory
- Inventory by Category
- Inventory by Product
- Inventory by Product Variant
- Inventory by Store
- Inventory by Warehouse

### Current Stock Availability
- Total Product Variants
- In-Stock Variants
- Out-of-Stock Variants
- Stock Availability Percentage
- Stock Availability by Category
- Stock Availability by Product
- Out-of-Stock Variants by Store
- Out-of-Stock Variants by Warehouse

### Inventory vs Sales Demand
- Current Inventory Units by Variant
- Recent Units Sold by Variant
- Inventory-to-Sales Ratio
- High-Selling Variants with Low Inventory
- Low-Selling Variants with High Inventory
- Potential Understocked Variants
- Potential Overstocked Variants

Recent demand is evaluated using the available transaction data and is anchored to the latest order date in the dataset.

### Inventory Allocation
- Inventory Contribution by Region
- Sales Contribution by Region
- Sales Contribution vs Inventory Contribution
- Potential Under-Allocated Regions
- Potential Over-Allocated Regions

<br>

# 6. Procurement & Supplier Analysis

## Objective

Analyse procurement activity, supplier contribution, purchasing trends, supplier concentration, and the alignment between procurement, sales demand, and current inventory.

## Analysis Performed

### Procurement Overview
- Total Purchase Orders
- Total Units Purchased
- Estimated Procurement Value
- Average Units per Purchase Order
- Average Estimated Purchase Order Value
- Procurement Volume by Year
- Estimated Procurement Value by Year

### Supplier Procurement Performance
- Purchase Orders by Supplier
- Units Purchased by Supplier
- Estimated Procurement Value by Supplier
- Average Units per Purchase Order by Supplier
- Average Estimated Purchase Order Value by Supplier
- Supplier Contribution to Purchased Units
- Supplier Contribution to Estimated Procurement Value

### Category, Product & Variant Procurement
- Units Purchased by Category
- Estimated Procurement Value by Category
- Procurement Contribution by Category
- Units Purchased by Product
- Estimated Procurement Value by Product
- Units Purchased by Product Variant
- Estimated Procurement Value by Product Variant

### Procurement Trends
- Year-over-Year Units Purchased Growth
- Year-over-Year Estimated Procurement Value Growth
- Procurement Volume CAGR
- Supplier Procurement Trends
- Category Procurement Trends

### Supplier Concentration
- Supplier Procurement Contribution
- Cumulative Supplier Procurement Contribution
- Suppliers Accounting for Approximately 80% of Procurement
- Supplier Concentration Classification

### Procurement Alignment
- Units Purchased vs Units Sold by Product Variant
- Units Purchased vs Current Inventory by Product Variant
- Sell-Through Percentage
- Remaining Inventory Percentage
- Potential Over-Procurement Candidates
- Procurement Alignment Classification

> **Note:** Historical purchase prices are not available in the dataset. Estimated Procurement Value therefore uses the current product variant Cost Price as an analytical proxy and should not be interpreted as actual historical procurement expenditure.

<br>

# 7. Returns Analysis

## Objective

Analyse return activity to understand the scale of return requests, return outcomes, product-level return patterns, and changes in return behaviour over time.

## Analysis Performed

### Returns Overview
- Total Return Requests
- Units Requested for Return
- Return Request Rate
- Estimated Requested Return Value
- Average Units per Return Request
- Returns by Return Status
- Return Status Contribution

### Return Status Analysis
- Units Requested for Return by Status
- Estimated Requested Return Value by Status
- Units Contribution by Return Status
- Estimated Return Value Contribution by Status

### Category & Product Returns
- Units Returned by Category
- Return Rate by Category
- Estimated Return Value by Category
- Units Returned by Product
- Return Rate by Product
- Estimated Return Value by Product

### Product Variant Returns
- Units Requested for Return by Product Variant
- Return Request Rate by Product Variant
- Estimated Requested Return Value by Product Variant

### Return Trends
- Year-over-Year Return Growth
- Return Request Rate Trend
- Return Status Trend
- Category Return Trend

<br>

# 8. Workforce Analysis

## Objective

Analyse workforce composition, employee demographics, salary structure, payroll distribution, work locations, and workforce trends across Vovers.

## Analysis Performed

### Workforce Overview
- Total Employees
- Total Departments
- Average Employee Age
- Average Monthly Salary
- Total Annual Payroll
- Average Employee Tenure
- Employee Joinings by Year

### Department Analysis
- Employees by Department
- Workforce Contribution by Department
- Average Monthly Salary by Department
- Annual Payroll by Department
- Payroll Contribution by Department

### Designation Analysis
- Employees by Designation
- Workforce Contribution by Designation
- Average Monthly Salary by Designation
- Annual Payroll by Designation
- Payroll Contribution by Designation

### Workforce Demographics
- Employees by Gender
- Gender Distribution
- Average Salary by Gender
- Employees by Age Group
- Age Group Distribution

### Work Location Analysis
- Employees by Work Location
- Store Workforce
- Warehouse Workforce
- Office Workforce
- Employees by Store
- Employees by Warehouse
- Average Salary by Location
- Annual Payroll by Location
- Regional Workforce Distribution

### Workforce & Payroll Trends
- Employee Joinings Trend
- Year-over-Year Employee Joinings Growth
- Annual Payroll Added by Joining Year
- Average Current Monthly Salary by Joining Year

<br>

# Analysis Approach

The SQL analysis follows a business-first approach.

Instead of analysing individual database tables in isolation, queries were designed around practical business questions and management requirements.

The analysis uses SQL techniques including:

- Multi-table joins
- Common Table Expressions (CTEs)
- Subqueries
- Aggregate functions
- Conditional logic
- Window functions
- Ranking
- Contribution analysis
- Cumulative analysis
- Growth calculations
- Time-based analysis
- Customer and product segmentation
- Business classification logic

Where required, transactional tables were aggregated before joining to avoid duplicate records and incorrect metric calculations.

<br>

# Analytical Considerations

- Revenue is calculated after applying transaction-level discounts.
- Gross Profit is calculated using discounted revenue and product variant Cost Price.
- Order counts use distinct Order IDs where required.
- Product pricing and inventory analysis operate at the Product Variant level.
- Completed-year trend analysis primarily uses the period **2023–2025**.
- Recent inventory demand is based on the latest available order date in the dataset rather than the current system date.
- Estimated Procurement Value uses current Product Variant Cost Price because historical purchase prices are unavailable.
- Analytical classifications and thresholds used in the project are project-specific assumptions designed to support business analysis.

<br>

# Outcome

The SQL analysis transforms the Vovers operational database into a structured analytical view of the business.

Together, the eight analysis areas provide insight into:

- Overall business performance
- Customer behaviour and value
- Product and portfolio performance
- Sales channel and geographic performance
- Inventory position and demand alignment
- Procurement and supplier performance
- Product return behaviour
- Workforce and payroll structure

These analyses also provide the analytical foundation for the project's Power BI dashboards and final business insights.
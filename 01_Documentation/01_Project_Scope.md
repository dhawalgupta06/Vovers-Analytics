# PROJECT SCOPE

<br>

## Project Title

**Vovers Business & Finance Analytics Platform**

<br>

## Project Objective

The objective of this project is to design and build an end-to-end Business & Finance Analytics solution for a fictional omnichannel consumer electronics retail company named **Vovers**.

The project simulates how business and data analysts work with operational business data by covering the analytics lifecycle from business understanding, database design, and synthetic data generation to SQL analysis, Python-based customer analytics, KPI development, interactive Power BI dashboards, and business insight generation.

The project focuses on transforming structured operational data into meaningful analytical outputs that can support management decision-making across major business functions.

<br>

## Business Background

Vovers is a fictional mid-sized omnichannel consumer electronics retailer headquartered in **Gurugram, India**.

The company operates through physical retail stores and online sales channels, supported by warehouses, suppliers, procurement operations, inventory management, customer transactions, returns, and an internal workforce.

As the business expands, management requires a centralized analytics solution to monitor performance and support data-driven decision-making across sales, profitability, customers, products, stores, inventory, procurement, returns, and workforce operations.

This project is designed to simulate and address those analytical requirements.

<br>

## Project Deliverables

The project includes the following deliverables:

- Business Blueprint
- Business Rules Documentation
- Database Schema and ER Diagram
- Data Dictionary
- Data Design Documentation
- MySQL Database
- Realistic Synthetic Business Dataset
- SQL Business Analysis
- Python Customer Analytics
  - RFM Customer Segmentation
  - Customer Cohort and Retention Analysis
- Power BI Analytical Dashboards
- Business Insights and Recommendations
- Git Version Control
- GitHub Portfolio Repository

<br>

## Technologies Used

- MySQL
- SQL
- Python
- Pandas
- NumPy
- Matplotlib
- Jupyter Notebook
- Power BI
- DAX
- Power Query
- Git
- GitHub

<br>

## In Scope

The following activities are included in this project:

- Business Requirement Analysis
- Business Process Understanding
- Database Design
- Relational Data Modelling
- Data Dictionary Development
- Data Design and Business Rule Definition
- Synthetic Data Generation
- Data Validation
- SQL Business Analysis
- Customer Segmentation
- Cohort and Retention Analysis
- Sales and Profitability Analysis
- Customer Analysis
- Product and Portfolio Analysis
- Store and Geographic Analysis
- Inventory Analysis
- Procurement and Supplier Analysis
- Returns Analysis
- Workforce Analysis
- KPI Development
- Power BI Data Modelling
- DAX Measure Development
- Interactive Dashboard Development
- Data Visualization
- Business Insight Generation
- Documentation
- Git Version Control
- Portfolio Development

<br>

## Out of Scope

The following activities are outside the scope of this project:

- Website Development
- Mobile Application Development
- ERP Software Development
- Production Database Deployment
- Cloud Deployment
- Real-Time Data Streaming
- Live API Integrations
- Machine Learning Models
- Artificial Intelligence Models
- Predictive Modelling
- Production-Grade Data Engineering Pipelines

<br>

## Analytical Scope

The project analyses the business across the following major areas:

1. **Overall Performance Analysis**
   - Revenue
   - Gross Profit
   - Gross Profit Margin
   - Total Orders
   - Units Sold
   - Average Order Value
   - Business Performance Trends

2. **Customer Analysis**
   - Customer Acquisition
   - Purchasing Behaviour
   - Repeat Customers
   - Customer Value
   - Customer Revenue Contribution
   - Customer Segmentation
   - Customer Retention

3. **Product Analysis**
   - Product Revenue
   - Product Profitability
   - Category Performance
   - Brand Performance
   - Units Sold
   - Product Contribution

4. **Sales, Region & Store Analysis**
   - Sales Performance
   - Regional Performance
   - Store Performance
   - Geographic Revenue Distribution
   - Store Type Performance
   - Regional Contribution

5. **Inventory Analysis**
   - Inventory Units
   - Inventory Value
   - Inventory Distribution
   - Recent Demand
   - Inventory Coverage
   - Inventory Allocation
   - Inventory Risk Identification

6. **Procurement & Supplier Analysis**
   - Purchase Order Activity
   - Estimated Procurement Value
   - Supplier Contribution
   - Supplier Concentration
   - Procurement Trends
   - Category and Product Procurement
   - Procurement Alignment

7. **Returns Analysis**
   - Return Requests
   - Completed Returns
   - Return Rate
   - Return Value
   - Rejection Rate
   - Product Return Patterns
   - Category and Brand Return Analysis

8. **Workforce Analysis**
   - Employee Distribution
   - Department Analysis
   - Designation Analysis
   - Work Location Distribution
   - Employee Demographics
   - Salary Analysis
   - Payroll Analysis

   <br>

## Expected Business Outcomes

The completed analytics solution enables management to:

- Monitor overall business performance through standardized KPIs.
- Analyse revenue, gross profit, and profitability trends.
- Understand customer purchasing behaviour, loyalty, and retention.
- Identify high-performing products, categories, and brands.
- Compare store, regional, and geographic performance.
- Evaluate inventory levels and inventory allocation.
- Analyse procurement activity and supplier contribution.
- Identify patterns in product returns and rejection rates.
- Understand workforce distribution and payroll structure.
- Explore business performance interactively through Power BI dashboards.
- Use analytical findings to support operational and management decision-making.

<br>

## Project Assumptions

- Vovers is a fictional company created solely for analytical and portfolio purposes.
- All business data used in the project is synthetically generated.
- The dataset is designed to simulate realistic business operations but does not represent any real company or customer.
- Business rules and analytical thresholds used in the project are project-specific assumptions designed for analytical simulation.
- Procurement valuation is based on available product variant cost prices and should be interpreted as an analytical estimate rather than historical accounting-level procurement expenditure.
- Analytical outputs are intended for business analysis and portfolio demonstration rather than production financial reporting.

<br>

## Success Criteria

The project will be considered successful when:

- The relational database is structured, documented, and aligned with defined business rules.
- The synthetic dataset provides sufficient scale and business complexity for realistic analysis.
- SQL analyses answer meaningful business questions across major business functions.
- Python is successfully applied to customer segmentation, cohort analysis, retention analysis, data validation, and visualization.
- Business KPIs are consistently defined and applied across analytical outputs.
- Power BI dashboards provide clear, interactive, and decision-oriented views of business performance.
- Analytical results remain logically consistent across the database, SQL analysis, Python analysis, and Power BI dashboards.
- Business insights and recommendations are supported by analytical findings.
- Documentation accurately reflects the final implementation of the project.
- Git is used to maintain meaningful version history throughout project development.
- The final GitHub repository presents the project clearly and professionally as a portfolio case study.

<br>

## Limitation
### Product Availability and Historical Launch Dates

The Vovers ERP dataset is a synthetic dataset created for analytical and portfolio purposes. Product names are based on contemporary real-world consumer electronics; however, historical product launch and availability dates were not incorporated into the transaction-generation logic.

As a result, some products may appear in sales transactions before their actual real-world launch dates. For example, newer product models may have simulated sales during earlier years of the dataset.

For analytical purposes, products are therefore treated as part of Vovers' fictional product catalog throughout the simulated transaction period. Product-level historical trends represent performance within the Vovers simulation and should not be interpreted as actual historical performance of the corresponding real-world products.

This limitation was identified during the Product Growth & Trend Analysis. The existing transactional data was retained because Vovers is a fictional company and real-world product launch chronology is outside the primary analytical scope of the project.

In a production-grade data-generation process, a product availability or launch date would be maintained and transactions would be validated using a business rule such as:

`order_datetime >= product_available_date`

## Project Status

**Status: Completed**
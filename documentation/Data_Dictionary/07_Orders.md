# Orders Data Dictionary

## Purpose

The **Orders** table stores the master information of every order placed by customers through Vovers.

Each order is uniquely identified by **Order_ID** and captures the customer, store, order timestamp, sales channel, and payment method. This table serves as the foundation for sales analytics, customer behavior analysis, and revenue reporting.

<br>

| Column Name | Data Type | PK | FK | Nullable | Default Value | Constraints / Allowed Values | Description |
|--------------|-----------|:--:|:--:|:--------:|---------------|------------------------------|-------------|
| Order_ID | INT | Y | N | N | AUTO_INCREMENT | Positive Integer | Unique identifier assigned to each order. |
| Customer_ID | INT | N | Y | N | None | Must exist in Customers table | Customer who placed the order. |
| Store_ID | INT | N | Y | N | None | Must exist in Stores table | Store responsible for fulfilling the order. |
| Order_DateTime | DATETIME | N | N | N | CURRENT_TIMESTAMP | Current date and time or earlier | Date and time when the order was placed. |
| Sales_Channel | ENUM | N | N | N | Offline Store | Offline Store, Website, Mobile App, Amazon, Flipkart | Channel through which the order was placed. |
| Payment_Method | ENUM | N | N | N | None | Cash, Card, UPI, Net Banking | Payment method used by the customer. |

<br>

## Business Rules

- Every order must have a unique **Order_ID**.
- Every order must be associated with one customer.
- Every order must be fulfilled by one store.
- Every order must contain one or more order items in the **Order_Details** table.
- Order_DateTime cannot be a future date and time.
- Sales_Channel must be one of the predefined channels.
- Payment_Method must be one of the predefined payment methods.
- Orders are never physically deleted to preserve historical business records.

<br>

## Relationships

| Parent Table | Child Table | Relationship |
|--------------|-------------|--------------|
| Customers | Orders | One-to-Many |
| Stores | Orders | One-to-Many |
| Orders | Order_Details | One-to-Many |

<br>

## Used In Analysis

The Orders table is used for:

- Revenue Trend Analysis
- Daily Sales Analysis
- Monthly Sales Analysis
- Customer Purchase Behavior
- Sales Channel Performance
- Payment Method Analysis
- Store Performance
- Peak Sales Hours
- Order Volume Analysis
- Customer Retention Analysis
- Average Orders per Customer
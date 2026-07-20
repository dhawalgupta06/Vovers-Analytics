# Returns Data Dictionary

## Purpose

The **Returns** table stores information about products returned by customers after purchase.

Each return record is linked to a specific order item and captures the return quantity, return date, and return status. This table supports return management, warranty tracking, refund processing, customer service, and product quality analysis.

<br>

| Column Name | Data Type | PK | FK | Nullable | Default Value | Constraints / Allowed Values | Description |
|--------------|-----------|:--:|:--:|:--------:|---------------|------------------------------|-------------|
| Return_ID | INT | Y | N | N | AUTO_INCREMENT | Positive Integer | Unique identifier assigned to each return transaction. |
| Order_Detail_ID | INT | N | Y | N | None | Must exist in Order_Details table | Order item for which the return is requested. |
| Return_DateTime | DATETIME | N | N | N | CURRENT_TIMESTAMP | Current date and time or earlier | Date and time when the return request was created. |
| Returned_Quantity | INT | N | N | N | 1 | Greater than 0 and less than or equal to purchased quantity | Number of units returned by the customer. |
| Return_Status | ENUM | N | N | N | Requested | Requested, Approved, Rejected, Refunded, Replaced | Current processing status of the return request. |

<br>

## Business Rules

- Every return transaction must have a unique **Return_ID**.
- Every return must reference an existing **Order_Detail_ID**.
- Returned quantity cannot exceed the quantity originally purchased.
- Returned quantity must always be greater than zero.
- Return requests cannot be created for products that were never purchased.
- Return_DateTime cannot be a future date and time.
- Every return must have one valid return status.
- Return history is permanently maintained for auditing and business analysis.

<br>

## Relationships

| Parent Table | Child Table | Relationship |
|--------------|-------------|--------------|
| Order_Details | Returns | One-to-Many |

<br>

## Used In Analysis

The Returns table is used for:

- Return Rate Analysis
- Product Return Analysis
- Category-wise Return Rate
- Brand-wise Return Rate
- Refund Analysis
- Replacement Analysis
- Customer Return Behaviour
- Warranty Claim Analysis
- Product Quality Monitoring
- After-Sales Service Performance
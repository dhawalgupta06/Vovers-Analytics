# Returns Data Dictionary

## Purpose

The **Returns** table stores information about products returned by customers after purchase.

Each return record is linked to a specific order item through **Order_Detail_ID** and captures the returned quantity, return date and time, and current return status.

This table supports return processing, refund and replacement tracking, inventory adjustments, auditing, and return-related business analysis.

<br/>

---

## Column Definitions

| Column Name | Data Type | PK | FK | Nullable | Default Value | Constraints / Allowed Values | Description |
|-------------|-----------|:--:|:--:|:--------:|---------------|------------------------------|-------------|
| Return_ID | INT | Y | N | N | AUTO_INCREMENT | Positive Integer | Unique identifier assigned to each return record. |
| Order_Detail_ID | INT | N | Y | N | None | Must exist in the Order_Details table | Identifies the specific order item being returned. |
| Return_DateTime | TIMESTAMP | N | N | N | CURRENT_TIMESTAMP | Must not occur before the corresponding order transaction | Date and time when the return request was created. |
| Returned_Quantity | INT | N | N | N | 1 | Must be greater than 0 and cannot exceed the quantity purchased in the corresponding order detail | Number of units returned by the customer. |
| Return_Status | ENUM | N | N | N | Requested | Requested, Approved, Rejected, Refunded, Replaced | Current processing status or final outcome of the return request. |

<br/>

## Business Rules

- Every return record must have a unique **Return_ID**.
- Every return must reference an existing **Order_Detail_ID**.
- A return can only be created for a product that was previously purchased.
- **Return_DateTime** must occur on or after the corresponding order date and time.
- **Return_DateTime** cannot be later than the dataset generation date and time.
- **Returned_Quantity** must always be greater than zero.
- **Returned_Quantity** cannot exceed the quantity purchased in the corresponding order detail.
- Every return must have one valid **Return_Status**.
- A return initially enters the process with the status **Requested**.
- A requested return may subsequently be approved or rejected.
- An approved return may eventually be resolved through a refund or replacement.
- Return records are retained for auditing and business analysis.

<br/>

## Relationships

| Parent Table | Child Table | Relationship |
|--------------|-------------|--------------|
| Order_Details | Returns | One-to-Many |

<br/>

## Used In Analysis

The **Returns** table can be used for:

- Return Rate Analysis
- Product-wise Return Analysis
- Category-wise Return Analysis
- Brand-wise Return Analysis
- Refund Analysis
- Replacement Analysis
- Return Rejection Analysis
- Customer Return Behaviour Analysis
- Return Processing Status Analysis
- Product Quality Monitoring
- After-Sales Service Performance
# Assumptions

This document records the business assumptions and analytical decisions made during the Overall Business Performance Analysis.

---

## Gross Profit

Gross Profit is calculated after applying item-level discounts.

**Formula**

```text
Gross Profit = Total Revenue − Cost of Goods Sold
```

where:

- **Total Revenue** = Selling Price × Quantity × (1 − Discount %)
- **Cost of Goods Sold (COGS)** = Cost Price × Quantity

---

## Gross Profit Margin

Gross Profit Margin represents the percentage of revenue retained after deducting the cost of goods sold.

**Formula**

```text
Gross Profit Margin (%) = (Gross Profit ÷ Total Revenue) × 100
```

---

## Financial Metrics Limitation

The ERP dataset does not contain a complete finance or accounting module.

Although employee salary information is available, the dataset does not include complete historical financial information such as:

- Historical salary revisions
- Employee exits and terminations
- Detailed operating expenses
- Accounting adjustments
- Other financial records required to calculate Net Profit accurately

Therefore, **Net Profit** and **Net Profit Margin** have been intentionally excluded from this engagement to ensure that all reported metrics are fully supported by the available transactional data.

---

## Analysis Scope

This engagement focuses only on business performance metrics that can be calculated directly from the ERP dataset.

Detailed analyses such as:

- Product Performance
- Store Performance
- Regional Performance
- Brand & Category Analysis
- Customer Segmentation
- Inventory Analysis
- Procurement Analysis
- Return Analysis

are covered in their respective analysis engagements.
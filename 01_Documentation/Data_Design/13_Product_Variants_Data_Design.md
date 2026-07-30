# Data Design - Product Variants Table

## Purpose

This document defines the sellable product variants for the Vovers ERP project.

It specifies how variants are generated for each product category, including applicable attributes such as color, storage, and size. The document also defines variant generation rules and pricing guidelines to ensure a realistic and consistent product catalog throughout the synthetic dataset.

The Product_Variants table enables Vovers ERP to manage inventory, procurement, sales, and returns at the exact sellable item level rather than only at the product level.

<br/>

---

## Dataset Overview

| Item | Count |
|------|------:|
| Products | 250 |
| Product Variants | 812 |

Every variant represents a unique sellable SKU of a product based on its combination of color, storage, and/or size.

<br/>

---

## Variant Distribution by Category

| Category | Products | Variants |
|----------------------|---------:|---------:|
| Smartphones | 50 | 200 |
| Laptops | 35 | 120 |
| Tablets | 20 | 70 |
| Televisions | 20 | 55 |
| Audio Devices | 35 | 90 |
| Smart Watches | 25 | 75 |
| Home Appliances | 25 | 70 |
| Kitchen Appliances | 20 | 50 |
| Gaming | 10 | 42 |
| Accessories | 10 | 40 |
| **Total** | **250** | **812** |

<br/>

---

## Variant Attributes by Category

| Category | Color | Storage | Size |
|----------------------|:-----:|:-------:|:----:|
| Smartphones | ✔ | ✔ | ✖ |
| Laptops | ✔ | ✔ | ✔ |
| Tablets | ✔ | ✔ | ✔ |
| Televisions | ✔ | ✖ | ✔ |
| Audio Devices | ✔ | ✖ | ✖ |
| Smart Watches | ✔ | ✖ | ✔ |
| Home Appliances | ✔ | ✖ | ✔ |
| Kitchen Appliances | ✔ | ✖ | ✔ |
| Gaming | ✔ | ✖ | ✖ |
| Accessories | ✔ | ✖ | ✖ |

Fields that are not applicable remain **NULL**.

<br/>

---

## Standard Color Options

Depending on the product category and manufacturer, variants may use one or more of the following colors.

- Black
- White
- Silver
- Gray
- Blue
- Green
- Red
- Pink
- Purple
- Gold
- Midnight
- Starlight
- Space Gray
- Titanium Black
- Titanium White
- Titanium Gray
- Titanium Blue
- Natural Titanium

Only colors officially available for a product should be generated.

<br/>

---

## Standard Storage Options

Storage is applicable only where relevant.

Possible values include:

- 64GB
- 128GB
- 256GB
- 512GB
- 1TB
- 2TB

Products that do not support storage should keep this field **NULL**.

<br/>

---

## Standard Size Options

### Laptops

- 13 Inch
- 14 Inch
- 15 Inch
- 16 Inch

### Tablets

- 8 Inch
- 11 Inch
- 12.4 Inch
- 13 Inch

### Televisions

- 43 Inch
- 50 Inch
- 55 Inch
- 65 Inch
- 75 Inch
- 85 Inch

### Smart Watches

- 40 mm
- 41 mm
- 44 mm
- 45 mm
- 46 mm
- 49 mm

### Home Appliances

Examples:

- 1 Ton
- 1.5 Ton
- 2 Ton
- 7 Kg
- 8 Kg
- 9 Kg
- 240 L
- 300 L
- 450 L

### Kitchen Appliances

Examples:

- 20 L
- 23 L
- 28 L
- 30 L
- 1.5 L
- 2 L
- 4 Slice
- 60 cm

Products where size is not applicable should keep this field **NULL**.

<br/>

---

## Pricing Rules

Pricing is maintained at the variant level.

General pricing rules:

- Cost Price must always be greater than zero.
- Selling Price must always be greater than Cost Price.
- Higher storage variants should have higher prices.
- Larger size variants may have higher prices.
- Premium colors normally use the same price unless the manufacturer prices them differently.
- Variants with identical specifications should maintain identical pricing unless intentionally differentiated.

<br/>

---

## Business Rules

- Every variant belongs to exactly one product.
- Every product must have at least one variant.
- Every variant combination must be unique.
- Duplicate variants are not allowed.
- Storage should remain **NULL** when not applicable.
- Size should remain **NULL** when not applicable.
- Color should remain **NULL** if the product is available in only one standard finish.
- Cost Price and Selling Price are maintained only in the Product_Variants table.
- Inventory, Purchase Orders, Sales Orders, and Returns reference **Variant_ID** instead of **Product_ID**.

<br/>

---

## Dataset Validation Rules

The generated dataset must satisfy the following validations:

- Exactly **812** variants.
- Every Product_ID must exist in the Products table.
- Every product has at least one variant.
- No duplicate combination of Product_ID + Color + Storage + Size.
- Cost Price > 0.
- Selling Price > Cost Price.
- Non-applicable attributes remain NULL.
- Variant pricing remains realistic within the product family.
- Variant_ID values are sequential without gaps.
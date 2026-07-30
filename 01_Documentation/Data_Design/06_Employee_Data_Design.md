# Data Design - Employees Table

## Purpose

This document defines the business rules, assumptions, and distributions used to design the **Employees** table of the **Vovers ERP Database**.

The objective is to ensure that the employee dataset reflects a realistic organizational structure for a mid-sized Indian omnichannel consumer electronics retailer, making it suitable for:

- SQL Analysis
- Python Analytics
- Excel Dashboards
- Power BI Reports
- Business Case Studies
- Portfolio Projects

<br/>

# Employees Table

## Total Employees

- 2,652

<br/>

## Department and Designation Distribution

### Sales Department (Store Employees)

- Store Manager : 120
- Sales Executive : 1,440
- Cashier : 360

**Total Employees:** 1,920

<br/>

---

### Warehouse Department (Warehouse Employees)

- Warehouse Manager : 12
- Warehouse Executive : 180

**Total Employees:** 192

<br/>

---

### Finance Department (Head Office Employees)

- Finance Manager : 3
- Finance Executive : 77

**Total Employees:** 80

<br/>

---

### HR Department (Head Office Employees)

- HR Manager : 2
- HR Executive : 58

**Total Employees:** 60

<br/>

---

### IT Department (Head Office Employees)

- IT Manager : 4
- IT Executive : 116

**Total Employees:** 120

<br/>

---

### Operations Department (Head Office Employees)

- Operations Manager : 5
- Operations Executive : 175

**Total Employees:** 180

<br/>

---

### Marketing Department (Head Office Employees)

- Marketing Manager : 3
- Marketing Executive : 97

**Total Employees:** 100

<br/>

## Grand Total

| Department | Employees |
|------------|----------:|
| Sales | 1,920 |
| Warehouse | 192 |
| Finance | 80 |
| HR | 60 |
| IT | 120 |
| Operations | 180 |
| Marketing | 100 |
| **Total Employees** | **2,652** |

<br/>

--- 

## Gender Ratio

- Male : 64% (1,697 Employees)
- Female : 34% (902 Employees)
- Others : 2% (53 Employees)

<br/>

## Age Group Ratio

- 18–25 : 30% (796 Employees)
- 26–35 : 42% (1,114 Employees)
- 36–45 : 18% (477 Employees)
- 46–60 : 9% (239 Employees)
- 60+ : 1% (26 Employees)

<br/>

## Join Date Distribution

- 2016 : 1% (27 Employees)
- 2017 : 2% (53 Employees)
- 2018 : 4% (106 Employees)
- 2019 : 7% (186 Employees)
- 2020 : 8% (212 Employees)
- 2021 : 10% (265 Employees)
- 2022 : 13% (345 Employees)
- 2023 : 17% (451 Employees)
- 2024 : 19% (504 Employees)
- 2025 : 13% (345 Employees)
- 2026* : 6% (158 Employees)

<br/>

## Salary Distribution by Designation (Monthly Gross Salary)

### Sales Department

- Store Manager : ₹55,000 – ₹85,000
- Sales Executive : ₹22,000 – ₹38,000
- Cashier : ₹18,000 – ₹28,000

<br/>

---

### Warehouse Department

- Warehouse Manager : ₹60,000 – ₹90,000
- Warehouse Executive : ₹22,000 – ₹35,000

<br/>

---

### Finance Department

- Finance Manager : ₹90,000 – ₹1,50,000
- Finance Executive : ₹35,000 – ₹60,000

<br/>

---

### HR Department

- HR Manager : ₹80,000 – ₹1,30,000
- HR Executive : ₹30,000 – ₹50,000

<br/>

---

### IT Department

- IT Manager : ₹1,10,000 – ₹2,00,000
- IT Executive : ₹45,000 – ₹80,000

<br/>

---

### Operations Department

- Operations Manager : ₹1,00,000 – ₹1,70,000
- Operations Executive : ₹40,000 – ₹70,000

<br/>

---

### Marketing Department

- Marketing Manager : ₹90,000 – ₹1,50,000
- Marketing Executive : ₹35,000 – ₹60,000

<br/>

--- 

## Business Assumptions

- Every employee belongs to exactly one department.
- Every employee has exactly one designation.
- Every designation belongs to its respective department.
- Employees work at either a Store, Warehouse, or Head Office.
- Every Store has exactly one Store Manager.
- Every Warehouse has exactly one Warehouse Manager.
- Stores may have multiple Sales Executives and Cashiers.
- Warehouses may have multiple Warehouse Executives.
- Head Office contains employees from Finance, HR, IT, Operations, and Marketing departments.
- Join Date cannot be a future date.
- Salary must always be greater than zero.
- Employee records are retained permanently for historical reporting.
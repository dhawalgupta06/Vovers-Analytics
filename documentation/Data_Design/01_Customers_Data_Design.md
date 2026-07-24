# Data Design - Customers Table

## Purpose

This document defines the business rules, assumptions, and distributions used to design the **Customers** table of the **Vovers ERP Database**.

The objective is to ensure that the generated dataset reflects realistic business behaviour instead of random values, making it suitable for:

- SQL Analysis
- Python Analytics
- Excel Dashboards
- Power BI Reports
- Business Case Studies
- Portfolio Projects

<br/>

# Customers Table

## Total Customers

- **100,000**

<br/>

## Gender Ratio

- Male : 57% (**57,000 Customers**)
- Female : 41% (**41,000 Customers**)
- Others : 2% (**2,000 Customers**)

<br/>

## Customer Type Ratio

- Individual : 66% (**66,000 Customers**)
- Business : 31% (**31,000 Customers**)
- Government : 3% (**3,000 Customers**)

<br/>

## Age Group Ratio

- 18–25 : 37% (**37,000 Customers**)
- 26–35 : 31% (**31,000 Customers**)
- 36–45 : 15% (**15,000 Customers**)
- 46–60 : 11% (**11,000 Customers**)
- 60+ : 6% (**6,000 Customers**)

<br/>

## Region, State and City Distribution

### North : 34%

#### Delhi : 18%

- New Delhi : 100%

<br/>

#### Haryana : 16%

- Gurugram : 65%
- Faridabad : 35%

<br/>

#### Punjab : 14%

- Chandigarh : 45%
- Ludhiana : 55%

<br/>

#### Uttar Pradesh : 32%

- Noida : 45%
- Ghaziabad : 25%
- Lucknow : 30%

<br/>

#### Rajasthan : 20%

- Jaipur : 70%
- Jodhpur : 30%

<br/>

---

### South : 23%

#### Karnataka : 28%

- Bengaluru : 85%
- Mysuru : 15%

<br/>

#### Tamil Nadu : 26%

- Chennai : 70%
- Coimbatore : 30%

<br/>

#### Telangana : 20%

- Hyderabad : 100%

<br/>

#### Kerala : 16%

- Kochi : 60%
- Thiruvananthapuram : 40%

<br/>

#### Andhra Pradesh : 10%

- Visakhapatnam : 100%

<br/>

---

### West : 15%

#### Maharashtra : 55%

- Mumbai : 50%
- Pune : 35%
- Nagpur : 15%

<br/>

#### Gujarat : 35%

- Ahmedabad : 45%
- Surat : 35%
- Vadodara : 20%

<br/>

#### Goa : 10%

- Panaji : 100%

<br/>

---

### East : 15%

#### West Bengal : 40%

- Kolkata : 100%

<br/>

#### Odisha : 22%

- Bhubaneswar : 100%

<br/>

#### Bihar : 20%

- Patna : 100%

<br/>

#### Assam : 18%

- Guwahati : 100%

<br/>

---

### Central : 13%

#### Madhya Pradesh : 75%

- Indore : 60%
- Bhopal : 40%

<br/>

#### Chhattisgarh : 25%

- Raipur : 100%

<br/>

## Join Date Distribution

- 2016 : 2% (**2,000 Customers**)
- 2017 : 3% (**3,000 Customers**)
- 2018 : 4% (**4,000 Customers**)
- 2019 : 5% (**5,000 Customers**)
- 2020 : 7% (**7,000 Customers**)
- 2021 : 10% (**10,000 Customers**)
- 2022 : 13% (**13,000 Customers**)
- 2023 : 16% (**16,000 Customers**)
- 2024 : 18% (**18,000 Customers**)
- 2025 : 15% (**15,000 Customers**)
- 2026* : 7% (**7,000 Customers**)

<br/>

## Business Assumptions

- Vovers was founded in **2016**.
- Customer acquisition increased every year as Vovers expanded into new cities.
- 2026 customer data represents a partial year.
- Metro cities have higher customer concentration than Tier-2 cities.
- Individual customers dominate the customer base.
- Business customers primarily belong to Tier-1 cities.
- Government customers are limited and mostly located in state capitals.
- The customer dataset represents **100,000 unique customers** acquired since the company's inception in 2016.
# Stores Data Design

## Purpose

This document defines the geographical distribution of Vovers retail stores across India.

It specifies the number of stores allocated to each region and city. The distribution has been designed to represent a realistic retail network for a mid-sized omnichannel consumer electronics retailer operating across India. This document serves as the foundation for generating records in the **Stores** table.

<br/>

---

## Region, State and City Distribution

### North : 35 Stores

#### Delhi
- New Delhi : 6

<br/>

#### Haryana
- Gurugram : 5
- Faridabad : 3

<br/>

#### Punjab
- Chandigarh : 2
- Ludhiana : 3

<br/>

#### Uttar Pradesh
- Noida : 5
- Ghaziabad : 3
- Lucknow : 4

<br/>

#### Rajasthan
- Jaipur : 3
- Jodhpur : 1

<br/>

---

### South : 28 Stores

#### Karnataka
- Bengaluru : 7
- Mysuru : 1

<br/>

#### Tamil Nadu
- Chennai : 5
- Coimbatore : 2

<br/>

#### Telangana
- Hyderabad : 6

<br/>

#### Kerala
- Kochi : 4
- Thiruvananthapuram : 1

<br/>

#### Andhra Pradesh
- Visakhapatnam : 2

<br/>

---

### West : 32 Stores

#### Maharashtra
- Mumbai : 8
- Pune : 6
- Nagpur : 3

<br/>

#### Gujarat
- Ahmedabad : 6
- Surat : 5
- Vadodara : 2

<br/>

#### Goa
- Panaji : 2

<br/>

---

### East : 15 Stores

#### West Bengal
- Kolkata : 6

<br/>

#### Odisha
- Bhubaneswar : 3

<br/>

#### Bihar
- Patna : 3

<br/>

#### Assam
- Guwahati : 3

<br/>

---

### Central : 10 Stores

#### Madhya Pradesh
- Indore : 4
- Bhopal : 3

<br/>

#### Chhattisgarh
- Raipur : 3

<br/>

---

## Business Assumptions

- Every store belongs to exactly one city and one region.
- Every city belongs to exactly one state.
- Larger metropolitan cities have a higher concentration of stores.
- Each store is assigned a unique Store_ID during data generation.
- Every store maintains its own inventory and serves customers independently.
- The store distribution is designed to represent a realistic expansion strategy for a mid-sized consumer electronics retailer.

<br/>

---

## Notes

- The regional distribution is based on population density, consumer demand, and major retail markets in India.
- Metropolitan cities such as New Delhi, Mumbai, Bengaluru, Chennai, Hyderabad, Kolkata, and Ahmedabad have the highest number of stores.
- Tier-2 cities are included to provide realistic geographical coverage across the country.
- The exact store names, addresses, contact details, and managers will be generated separately during the data generation phase.
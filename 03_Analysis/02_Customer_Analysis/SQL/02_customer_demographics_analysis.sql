-- Metric : Customer Distribution by Gender
-- Period : All Registered Customers
-- Description : Calculates the distribution of registered customers across different genders.
select
    gender,
    count(customer_id) as total_customers
from
    customers
group by
    gender
order by
    total_customers desc;

-- Metric : Customer Age Distribution
-- Period : All Registered Customers
-- Description : Calculates the distribution of registered customers by age.
select
    age,
    count(customer_id) as total_customers
from
    customers
group by
    age
order by
    age asc;

-- Metric : Customer Age Group Distribution
-- Period : All Registered Customers
-- Description : Calculates the distribution of registered customers across different age groups.
select
    case
        when age >= 18
        and age <= 24 then '18-24'
        when age >= 25
        and age <= 34 then '25-34'
        when age >= 35
        and age <= 44 then '35-44'
        when age >= 45
        and age <= 54 then '45-54'
        when age >= 55 then '55+'
    end as age_group,
    count(customer_id) as total_customers
from
    customers
group by
    age_group
order by
    age_group asc;

-- Metric : Average Customer Age
-- Period : All Registered Customers
-- Description : Calculates the average age of all registered customers.
select
    round(avg(age), 2) as average_customer_age
from
    customers;

-- Metric : Customer Distribution by City
-- Period : All Registered Customers
-- Description : Calculates the distribution of registered customers across different cities.
select
    city,
    state,
    count(customer_id) as total_customers
from
    customers
group by
    city,
    state
order by
    total_customers desc;

-- Metric : Customer Distribution by State
-- Period : All Registered Customers
-- Description : Calculates the distribution of registered customers across different states.
select
    state,
    count(customer_id) as total_customers
from
    customers
group by
    state
order by
    total_customers desc;

-- Metric : Customer Distribution by Region
-- Period : All Registered Customers
-- Description : Calculates the distribution of registered customers across different regions.
select
    region,
    count(customer_id) as total_customers
from
    customers
group by
    region
order by
    total_customers desc;
-- Metric : Total Registered Customers
-- Period : Past 3 Completed Years (2023-2025)
-- Description : Calculates the total number of customers registered during the past 3 completed years.
select
    count(customer_id) as total_registered_customers
from
    customers
where
    join_date >= '2023-01-01'
    and join_date < '2026-01-01';

-- Metric : Total Purchasing Customers
-- Period : Past 3 Completed Years (2023-2025)
-- Description : Calculates the total number of unique customers who placed at least one order during the past 3 completed years.
select
    count(distinct customer_id) as total_purchasing_customers
from
    orders
where
    order_datetime >= '2023-01-01'
    and order_datetime < '2026-01-01';

-- Metric : Customer Acquisition Growth Rate
-- Period : Past 3 Completed Years (2023-2025)
-- Description : Calculates the year-over-year growth rate in new customer registrations during the past 3 completed years.
select
    year(join_date) as year,
    count(customer_id) as current_year_customers_acquired,
    lag(count(customer_id)) over (
        order by
            year(join_date)
    ) as previous_year_customers_acquired,
    round(
        (
            (
                count(customer_id) - lag(count(customer_id)) over (
                    order by
                        year(join_date)
                )
            ) * 100
        ) / lag(count(customer_id)) over (
            order by
                year(join_date)
        ),
        2
    ) as customer_acquisition_growth_rate
from
    customers
where
    join_date >= '2023-01-01'
    and join_date < '2026-01-01'
group by
    year(join_date)
order by
    year(join_date) asc;

-- Metric : Year-Wise Customer Acquisition
-- Period : Past 3 Completed Years (2023-2025)
-- Description : Calculates the number of customers acquired each year during the past 3 completed years.
select
    year(join_date) as year,
    count(customer_id) as customers_acquired
from
    customers
where
    join_date >= '2023-01-01'
    and join_date < '2026-01-01'
group by
    year(join_date)
order by
    year(join_date) asc;

-- Metric : Month-Wise Customer Acquisition
-- Period : Past 3 Completed Years (2023-2025)
-- Description : Calculates the number of customers acquired each month during the past 3 completed years.
select
    monthname(join_date) as month,
    year(join_date) as year,
    count(customer_id) as customers_acquired
from
    customers
where
    join_date >= '2023-01-01'
    and join_date < '2026-01-01'
group by
    year(join_date),
    month(join_date),
    monthname(join_date)
order by
    year(join_date) asc,
    month(join_date) asc;

-- Metric : Quarter-Wise Customer Acquisition
-- Period : Past 3 Completed Years (2023-2025)
-- Description : Calculates the number of customers acquired each quarter during the past 3 completed years.
select
    quarter(join_date) as quarter,
    year(join_date) as year,
    count(customer_id) as customers_acquired
from
    customers
where
    join_date >= '2023-01-01'
    and join_date < '2026-01-01'
group by
    year(join_date),
    quarter(join_date)
order by
    year(join_date) asc,
    quarter(join_date) asc;

-- Metric : Customer Acquisition by State
-- Period : Past 3 Completed Years (2023-2025)
-- Description : Calculates the number of customers acquired from each state during the past 3 completed years.
select
    state,
    count(customer_id) as customers_acquired
from
    customers
where
    join_date >= '2023-01-01'
    and join_date < '2026-01-01'
group by
    state
order by
    customers_acquired desc;

-- Metric : Customer Acquisition by City
-- Period : Past 3 Completed Years (2023-2025)
-- Description : Calculates the number of customers acquired from each city during the past 3 completed years.
select
    city,
    state,
    count(customer_id) as customers_acquired
from
    customers
where
    join_date >= '2023-01-01'
    and join_date < '2026-01-01'
group by
    city,
    state
order by
    customers_acquired desc;

-- Metric : Customer Acquisition by Region
-- Period : Past 3 Completed Years (2023-2025)
-- Description : Calculates the number of customers acquired from each region during the past 3 completed years.
select
    region,
    count(customer_id) as customers_acquired
from
    customers
where
    join_date >= '2023-01-01'
    and join_date < '2026-01-01'
group by
    region
order by
    customers_acquired desc;
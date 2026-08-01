-- Metric: Total Customers
-- Period: Past 3 Years (2023–2025)
-- Description: Calculates the total number of unique customers who placed at least one order.
select
    count(distinct customer_id) as total_customers
from
    orders
where
    order_datetime >= '2023-01-01'
    and order_datetime < '2026-01-01';

-- Metric: Year-Wise Customers
-- Period: Past 3 Years (2023–2025)
-- Description: Calculates the number of unique customers who placed orders each year.
select
    year(order_datetime) as year,
    count(distinct customer_id) as total_customers
from
    orders
where
    order_datetime >= '2023-01-01'
    and order_datetime < '2026-01-01'
group by
    year(order_datetime)
order by
    year(order_datetime) asc;

-- Metric: Month-Wise Customers
-- Period: Past 3 Years (2023–2025)
-- Description: Calculates the number of unique customers who placed orders each month.
select
    monthname(order_datetime) as month,
    year(order_datetime) as year,
    count(distinct customer_id) as total_customers
from
    orders
where
    order_datetime >= '2023-01-01'
    and order_datetime < '2026-01-01'
group by
    year(order_datetime),
    month(order_datetime),
    monthname(order_datetime)
order by
    year(order_datetime) asc,
    month(order_datetime) asc;

-- Metric: Quarter-Wise Customers
-- Period: Past 3 Years (2023–2025)
-- Description: Calculates the number of unique customers who placed orders each quarter.
select
    quarter(order_datetime) as quarter,
    year(order_datetime) as year,
    count(distinct customer_id) as total_customers
from
    orders
where
    order_datetime >= '2023-01-01'
    and order_datetime < '2026-01-01'
group by
    year(order_datetime),
    quarter(order_datetime)
order by
    year(order_datetime) asc,
    quarter(order_datetime) asc;

-- Metric: Customer Growth Percentage
-- Period: Past 3 Years (2023–2025)
-- Description: Calculates year-over-year growth in unique purchasing customers.
select
    year(order_datetime) as year,
    count(distinct customer_id) as current_year_customers,
    lag(count(distinct customer_id)) over (
        order by
            year(order_datetime) asc
    ) as previous_year_customers,
    round(
        (
            (
                count(distinct customer_id) - lag(count(distinct customer_id)) over (
                    order by
                        year(order_datetime) asc
                )
            ) * 100
        ) / lag(count(distinct customer_id)) over (
            order by
                year(order_datetime) asc
        ),
        2
    ) as customer_growth_percentage
from
    orders
where
    order_datetime >= '2023-01-01'
    and order_datetime < '2026-01-01'
group by
    year(order_datetime)
order by
    year(order_datetime) asc;
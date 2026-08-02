-- Metric : Total Orders
-- Period : Past 3 Years (2023-2025)
-- Description : Calculates total orders of last 3 completed years.
select
    count(order_id) as total_orders
from
    orders
where
    order_datetime >= '2023-01-01'
    and order_datetime < '2026-01-01';

-- Metric : Year-Wise Orders
-- Period : Past 3 Years (2023-2025)
-- Description : Calculates year-wise total orders.
select
    year(order_datetime) as year,
    count(order_id) as total_orders
from
    orders
where
    order_datetime >= '2023-01-01'
    and order_datetime < '2026-01-01'
group by
    year(order_datetime)
order by
    year(order_datetime) asc;

-- Metric : Month-Wise Orders
-- Period : Past 3 Years (2023-2025)
-- Description : Calculates month-wise total orders.
select
    monthname(order_datetime) as month,
    year(order_datetime) as year,
    count(order_id) as total_orders
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

-- Metric : Quarter-Wise Orders
-- Period : Past 3 Years (2023-2025)
-- Description : Calculates quarter-wise total orders.
select
    quarter(order_datetime) as quarter,
    year(order_datetime) as year,
    count(order_id) as total_orders
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

-- Metric: Order Growth Percentage
-- Period: Past 3 Years (2023–2025)
-- Description: Calculates year-over-year growth in total orders.
select
    year(order_datetime) as year,
    count(order_id) as current_year_orders,
    lag(count(order_id)) over (
        order by
            year(order_datetime) asc
    ) as previous_year_orders,
    round(
        (
            (
                count(order_id) - lag(count(order_id)) over (
                    order by
                        year(order_datetime) asc
                )
            ) / lag(count(order_id)) over (
                order by
                    year(order_datetime) asc
            )
        ) * 100,
        2
    ) as order_growth_percentage
from
    orders
where
    order_datetime >= '2023-01-01'
    and order_datetime < '2026-01-01'
group by
    year(order_datetime)
order by
    year(order_datetime) asc;

-- Metric : Average Order Value
-- Period : Past 3 years (2023-2025)
-- Description : Calculates average order value of past 3 years.
select
    round(
        (
            sum(
                pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
            ) / count(distinct o.order_id)
        ),
        2
    ) as average_order_value
from
    orders as o
    inner join order_details as od on o.order_id = od.order_id
    inner join product_variants as pv on od.variant_id = pv.variant_id
where
    o.order_datetime >= '2023-01-01'
    and o.order_datetime < '2026-01-01';

-- Metric : Year-Wise Average Order Value
-- Period : Past 3 years (2023-2025)
-- Description : Calculates year-wise average order value of past 3 years.
select
    year(order_datetime) as year,
    round(
        (
            sum(
                pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
            ) / count(distinct o.order_id)
        ),
        2
    ) as average_order_value
from
    orders as o
    inner join order_details as od on o.order_id = od.order_id
    inner join product_variants as pv on od.variant_id = pv.variant_id
where
    o.order_datetime >= '2023-01-01'
    and o.order_datetime < '2026-01-01'
group by
    year(o.order_datetime)
order by
    year(o.order_datetime) asc;

-- Metric : Month-Wise Average Order Value
-- Period : Past 3 years (2023-2025)
-- Description : Calculates month-wise average order value of past 3 years.
select
    monthname(o.order_datetime) as month,
    year(order_datetime) as year,
    round(
        (
            sum(
                pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
            ) / count(distinct o.order_id)
        ),
        2
    ) as average_order_value
from
    orders as o
    inner join order_details as od on o.order_id = od.order_id
    inner join product_variants as pv on od.variant_id = pv.variant_id
where
    o.order_datetime >= '2023-01-01'
    and o.order_datetime < '2026-01-01'
group by
    year(o.order_datetime),
    month(o.order_datetime),
    monthname(o.order_datetime)
order by
    year(o.order_datetime),
    month(o.order_datetime) asc;

-- Metric : Quarter-Wise Average Order Value
-- Period : Past 3 years (2023-2025)
-- Description : Calculates quarter-wise average order value of past 3 years.
select
    quarter(o.order_datetime) as quarter,
    year(order_datetime) as year,
    round(
        (
            sum(
                pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
            ) / count(distinct o.order_id)
        ),
        2
    ) as average_order_value
from
    orders as o
    inner join order_details as od on o.order_id = od.order_id
    inner join product_variants as pv on od.variant_id = pv.variant_id
where
    o.order_datetime >= '2023-01-01'
    and o.order_datetime < '2026-01-01'
group by
    year(o.order_datetime),
    quarter(o.order_datetime)
order by
    year(o.order_datetime),
    quarter(o.order_datetime) asc;
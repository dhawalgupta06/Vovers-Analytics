-- Metric: Total Revenue
-- Period: Past 3 years (2023-2025)
-- Description: Calculates total revenue after item-level discounts.
select
    round(
        sum(
            pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
        ),
        2
    ) as total_revenue
from
    product_variants as pv
    inner join order_details as od on pv.variant_id = od.variant_id
    inner join orders o on o.order_id = od.order_id
where
    o.order_datetime >= '2023-01-01'
    and o.order_datetime < '2026-01-01';

-- Metric : Revenue by Year
-- Period : Past 3 years (2023-2025)
-- Description : Calculates revenue of past 3 years.
select
    year(o.order_datetime) as year,
    round(
        sum(
            pv.selling_price * od.quantity *(1 -(coalesce(od.discount_percentage, 0) / 100))
        ),
        2
    ) as revenue
from
    product_variants pv
    inner join order_details od on pv.variant_id = od.variant_id
    inner join orders o on o.order_id = od.order_id
where
    o.order_datetime >= '2023-01-01'
    and o.order_datetime < '2026-01-01'
group by
    year(o.order_datetime)
order by
    year(o.order_datetime) asc;

-- Metric : Revenue by Month
-- Period : Past 3 years (2023-2025)
-- Description : Calculates revenue of past 3 years.
select
    monthname(o.order_datetime) as month,
    year(o.order_datetime) as year,
    round(
        sum(
            pv.selling_price * od.quantity *(1 -(coalesce(od.discount_percentage, 0) / 100))
        ),
        2
    ) as revenue
from
    product_variants pv
    inner join order_details od on pv.variant_id = od.variant_id
    inner join orders o on o.order_id = od.order_id
where
    o.order_datetime >= '2023-01-01'
    and o.order_datetime < '2026-01-01'
group by
    monthname(o.order_datetime),
    month(o.order_datetime),
    year(o.order_datetime)
order by
    year(o.order_datetime) asc,
    month(o.order_datetime);

-- Metric : Revenue by Quarter
-- Period : Past 3 years (2023-2025)
-- Description : Calculates revenue of past 3 years.
select
    quarter(o.order_datetime) as quarter,
    year(o.order_datetime) as year,
    round(
        sum(
            pv.selling_price * od.quantity *(1 -(coalesce(od.discount_percentage, 0) / 100))
        ),
        2
    ) as revenue
from
    product_variants pv
    inner join order_details od on pv.variant_id = od.variant_id
    inner join orders o on o.order_id = od.order_id
where
    o.order_datetime >= '2023-01-01'
    and o.order_datetime < '2026-01-01'
group by
    quarter(o.order_datetime),
    year(o.order_datetime)
order by
    year(o.order_datetime) asc,
    quarter(o.order_datetime) asc;

-- Metric : Revenue Growth %
-- Period : Last 3 years (2023-2025)
-- Description : Calculates revenue growth rate in comparison of last year revenue.
with revenue_table as (
    select
        year(o.order_datetime) as year,
        round(
            sum(
                pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
            ),
            2
        ) as total_revenue
    from
        product_variants as pv
        inner join order_details as od on pv.variant_id = od.variant_id
        inner join orders as o on o.order_id = od.order_id
    where
        o.order_datetime >= '2023-01-01'
        and o.order_datetime < '2026-01-01'
    group by
        year(o.order_datetime)
)
select
    year,
    total_revenue,
    lag(total_revenue) over (
        order by
            year
    ) as previous_year_revenue,
    round(
        (
            (
                total_revenue - lag(total_revenue) over (
                    order by
                        year
                )
            ) * 100
        ) / lag(total_revenue) over (
            order by
                year
        ),
        2
    ) as revenue_growth_percentage
from
    revenue_table
order by
    year;
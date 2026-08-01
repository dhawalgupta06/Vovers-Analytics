-- Metric: Gross Profit
-- Period: Past 3 years (2023-2025)
-- Description: Calculates gross profit.
select
    round(
        sum(
            (
                pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
            ) -(pv.cost_price * od.quantity)
        ),
        2
    ) as gross_profit
from
    product_variants as pv
    inner join order_details as od on pv.variant_id = od.variant_id
    inner join orders o on o.order_id = od.order_id
where
    o.order_datetime >= '2023-01-01'
    and o.order_datetime < '2026-01-01';

-- Metric : Gross Profit by Year
-- Period : Past 3 years (2023-2025)
-- Description : Calculates gross profit of past 3 years.
select
    year(o.order_datetime) as year,
    round(
        sum(
            (
                pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
            ) -(pv.cost_price * od.quantity)
        ),
        2
    ) as gross_profit
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

-- Metric : Gross Profit by Month
-- Period : Past 3 years (2023-2025)
-- Description : Calculates gross profit of past 3 years.
select
    monthname(o.order_datetime) as month,
    year(o.order_datetime) as year,
    round(
        sum(
            (
                pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
            ) -(pv.cost_price * od.quantity)
        ),
        2
    ) as gross_profit
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

-- Metric : Gross profit by Quarter
-- Period : Past 3 years (2023-2025)
-- Description : Calculates gross profit of past 3 years.
select
    quarter(o.order_datetime) as quarter,
    year(o.order_datetime) as year,
    round(
        sum(
            (
                pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
            ) -(pv.cost_price * od.quantity)
        ),
        2
    ) as gross_profit
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

-- Metric : Gross Profit Growth %
-- Period : Last 3 year (2023-2025)
-- Description : Calculates gross profit growth rate in comparison of last year gross profit.
with gross_profit_table as (
    select
        year(o.order_datetime) as year,
        round(
            sum(
                pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100) -(pv.cost_price * od.quantity)
            ),
            2
        ) as gross_profit
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
    gross_profit,
    lag(gross_profit) over (
        order by
            year
    ) as previous_year_gross_profit,
    round(
        (
            (
                gross_profit - lag(gross_profit) over (
                    order by
                        year
                )
            ) * 100
        ) / lag(gross_profit) over (
            order by
                year
        ),
        2
    ) as gross_profit_growth_percentage
from
    gross_profit_table
order by
    year;

-- Metric : Gross Profit Margin
-- Period : Last 3 years (2023-2025)
-- Description : Calculates gross profit margin of last 3 years.
select
    year(o.order_datetime) as year,
    round(
        (
            sum(
                pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100) -(pv.cost_price * od.quantity)
            ) * 100
        ) / sum(
            pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
        ),
        2
    ) as gross_profit_margin_percentage
from
    product_variants as pv
    inner join order_details as od on pv.variant_id = od.variant_id
    inner join orders o on o.order_id = od.order_id
where
    o.order_datetime >= '2023-01-01'
    and o.order_datetime < '2026-01-01'
group by
    year(o.order_datetime);

-- Metric : Gross Profit Margin (Month wise)
-- Period : Last 3 years (2023-2025)
-- Description : Calculates month wise gross profit margin of last 3 years.
select
    monthname(o.order_datetime) as month,
    year(o.order_datetime) as year,
    round(
        (
            sum(
                pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100) -(pv.cost_price * od.quantity)
            ) * 100
        ) / sum(
            pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
        ),
        2
    ) as gross_profit_margin_percentage
from
    product_variants as pv
    inner join order_details as od on pv.variant_id = od.variant_id
    inner join orders o on o.order_id = od.order_id
where
    o.order_datetime >= '2023-01-01'
    and o.order_datetime < '2026-01-01'
group by
    year(o.order_datetime),
    monthname(o.order_datetime),
    month(o.order_datetime)
order by
    year asc,
    month(o.order_datetime) asc;

-- Metric : Gross Profit Margin (Quarter wise)
-- Period : Last 3 years (2023-2025)
-- Description : Calculates quarter wise gross profit margin of last 3 years.
select
    quarter(o.order_datetime) as quarter,
    year(o.order_datetime) as year,
    round(
        (
            sum(
                pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100) -(pv.cost_price * od.quantity)
            ) * 100
        ) / sum(
            pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
        ),
        2
    ) as gross_profit_margin_percentage
from
    product_variants as pv
    inner join order_details as od on pv.variant_id = od.variant_id
    inner join orders o on o.order_id = od.order_id
where
    o.order_datetime >= '2023-01-01'
    and o.order_datetime < '2026-01-01'
group by
    year(o.order_datetime),
    quarter(o.order_datetime)
order by
    year asc,
    quarter(o.order_datetime) asc;
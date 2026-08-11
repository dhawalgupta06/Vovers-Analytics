-- Metric : Product YoY Revenue Growth
-- Period : Past 3 Completed Years (2023-2025)
-- Description : Calculates annual product revenue and compares each year with the previous year to measure year-over-year revenue growth percentage.
with revenue_comparison_table as (
    select
        p.product_id,
        p.product_name,
        year(o.order_datetime) as order_year,
        round(
            sum(
                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
            ),
            2
        ) as current_year_revenue,
        lag(
            round(
                sum(
                    pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                ),
                2
            )
        ) over(
            partition by p.product_id
            order by
                year(o.order_datetime) asc
        ) as previous_year_revenue
    from
        orders o
        inner join order_details od on o.order_id = od.order_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join products p on p.product_id = pv.product_id
    where
        o.order_datetime >= '2023-01-01'
        and o.order_datetime < '2026-01-01'
    group by
        p.product_id,
        p.product_name,
        year(o.order_datetime)
    order by
        p.product_id,
        p.product_name,
        year(o.order_datetime)
)
select
    *,
    round(
        (
            (current_year_revenue - previous_year_revenue) * 100
        ) / previous_year_revenue,
        2
    ) as revenue_growth_percentage
from
    revenue_comparison_table;

-- Metric : Product YoY Units Sold Growth
-- Period : Past 3 Completed Years (2023-2025)
-- Description : Calculates annual units sold for each product and compares each year with the previous year to measure year-over-year units sold growth percentage.
with units_sold_comparison_table as (
    select
        p.product_id,
        p.product_name,
        year(o.order_datetime) as order_year,
        sum(od.quantity) as current_year_units_sold,
        lag(sum(od.quantity)) over(
            partition by p.product_id
            order by
                year(o.order_datetime) asc
        ) as previous_year_units_sold
    from
        orders o
        inner join order_details od on o.order_id = od.order_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join products p on p.product_id = pv.product_id
    where
        o.order_datetime >= '2023-01-01'
        and o.order_datetime < '2026-01-01'
    group by
        p.product_id,
        p.product_name,
        year(o.order_datetime)
    order by
        p.product_id,
        p.product_name,
        year(o.order_datetime)
)
select
    *,
    round(
        (
            (
                current_year_units_sold - previous_year_units_sold
            ) * 100
        ) / previous_year_units_sold,
        2
    ) as units_sold_growth_percentage
from
    units_sold_comparison_table;

-- Metric : Category YoY Revenue Growth
-- Period : Past 3 Completed Years (2023-2025)
-- Description : Calculates annual revenue for each product category and compares each year with the previous year to measure year-over-year category revenue growth percentage.
with category_revenue_comparison_table as (
    select
        p.category,
        year(o.order_datetime) as order_year,
        round(
            sum(
                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
            ),
            2
        ) as current_year_revenue,
        lag(
            round(
                sum(
                    pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                ),
                2
            )
        ) over(
            partition by p.category
            order by
                year(o.order_datetime) asc
        ) as previous_year_revenue
    from
        orders o
        inner join order_details od on o.order_id = od.order_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join products p on p.product_id = pv.product_id
    where
        o.order_datetime >= '2023-01-01'
        and o.order_datetime < '2026-01-01'
    group by
        p.category,
        year(o.order_datetime)
    order by
        p.category,
        year(o.order_datetime)
)
select
    *,
    round(
        (
            (current_year_revenue - previous_year_revenue) * 100
        ) / previous_year_revenue,
        2
    ) as revenue_growth_percentage
from
    category_revenue_comparison_table;

-- Metric : Brand YoY Revenue Growth
-- Period : Past 3 Completed Years (2023-2025)
-- Description : Calculates annual revenue for each brand and compares each year with the previous year to measure year-over-year brand revenue growth percentage.
with brand_revenue_comparison_table as (
    select
        p.brand,
        year(o.order_datetime) as order_year,
        round(
            sum(
                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
            ),
            2
        ) as current_year_revenue,
        lag(
            round(
                sum(
                    pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                ),
                2
            )
        ) over(
            partition by p.brand
            order by
                year(o.order_datetime) asc
        ) as previous_year_revenue
    from
        orders o
        inner join order_details od on o.order_id = od.order_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join products p on p.product_id = pv.product_id
    where
        o.order_datetime >= '2023-01-01'
        and o.order_datetime < '2026-01-01'
    group by
        p.brand,
        year(o.order_datetime)
    order by
        p.brand,
        year(o.order_datetime)
)
select
    *,
    round(
        (
            (current_year_revenue - previous_year_revenue) * 100
        ) / previous_year_revenue,
        2
    ) as revenue_growth_percentage
from
    brand_revenue_comparison_table;

-- Metric : Fastest-Growing Products
-- Period : Past 3 Completed Years (2023-2025)
-- Description : Identifies and ranks the top 10 fastest-growing products based on their average YoY revenue growth across the past 3 completed years.
with revenue_comparison_table as (
    select
        p.product_id,
        p.product_name,
        year(o.order_datetime) as order_year,
        round(
            sum(
                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
            ),
            2
        ) as current_year_revenue,
        lag(
            round(
                sum(
                    pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                ),
                2
            )
        ) over(
            partition by p.product_id
            order by
                year(o.order_datetime) asc
        ) as previous_year_revenue
    from
        orders o
        inner join order_details od on o.order_id = od.order_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join products p on p.product_id = pv.product_id
    where
        o.order_datetime >= '2023-01-01'
        and o.order_datetime < '2026-01-01'
    group by
        p.product_id,
        p.product_name,
        year(o.order_datetime)
    order by
        p.product_id,
        p.product_name,
        year(o.order_datetime)
),
revenue_growth_table as(
    select
        *,
        round(
            (
                (current_year_revenue - previous_year_revenue) * 100
            ) / previous_year_revenue,
            2
        ) as revenue_growth_percentage
    from
        revenue_comparison_table
)
select
    product_id,
    product_name,
    round(avg(revenue_growth_percentage), 2) as avg_growth_rate,
    rank() over(
        order by
            avg(revenue_growth_percentage) desc
    ) as fastest_growing_products
from
    revenue_growth_table
group by
    product_id,
    product_name
having
    avg(revenue_growth_percentage) > 0
order by
    avg_growth_rate desc
limit
    10;

-- Metric : Fastest-Declining Products
-- Period : Past 3 Completed Years (2023-2025)
-- Description : Identifies and ranks the top 10 fastest-declining products based on their average YoY revenue growth across the past 3 completed years.
with revenue_comparison_table as (
    select
        p.product_id,
        p.product_name,
        year(o.order_datetime) as order_year,
        round(
            sum(
                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
            ),
            2
        ) as current_year_revenue,
        lag(
            round(
                sum(
                    pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                ),
                2
            )
        ) over(
            partition by p.product_id
            order by
                year(o.order_datetime) asc
        ) as previous_year_revenue
    from
        orders o
        inner join order_details od on o.order_id = od.order_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join products p on p.product_id = pv.product_id
    where
        o.order_datetime >= '2023-01-01'
        and o.order_datetime < '2026-01-01'
    group by
        p.product_id,
        p.product_name,
        year(o.order_datetime)
    order by
        p.product_id,
        p.product_name,
        year(o.order_datetime)
),
revenue_growth_table as(
    select
        *,
        round(
            (
                (current_year_revenue - previous_year_revenue) * 100
            ) / previous_year_revenue,
            2
        ) as revenue_growth_percentage
    from
        revenue_comparison_table
)
select
    product_id,
    product_name,
    round(avg(revenue_growth_percentage), 2) as avg_growth_rate,
    rank() over(
        order by
            avg(revenue_growth_percentage) asc
    ) as declining_products
from
    revenue_growth_table
group by
    product_id,
    product_name
having
    avg(revenue_growth_percentage) < 0
order by
    avg_growth_rate asc
limit
    10;
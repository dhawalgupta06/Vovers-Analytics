-- Metric : YoY Units Purchased Growth
-- Period : 2023–2025
-- Description : Calculates annual procurement volume and compares each year's total units purchased with the previous year to measure year-over-year growth in procurement quantity.
with year_wise_units_purchased_table as (
    select
        year(po.purchase_datetime) as year,
        sum(pod.quantity) as current_year_units_purchased,
        lag(sum(pod.quantity)) over(
            order by
                year(po.purchase_datetime)
        ) as previous_year_units_purchased
    from
        purchase_order_details pod
        inner join purchase_orders po on po.purchase_order_id = pod.purchase_order_id
    where
        po.purchase_datetime >= '2023-01-01'
        and po.purchase_datetime < '2026-01-01'
    group by
        year(po.purchase_datetime)
)
select
    *,
    round(
        (
            (
                current_year_units_purchased - previous_year_units_purchased
            ) * 100
        ) / previous_year_units_purchased,
        2
    ) as units_purchased_growth_percentage
from
    year_wise_units_purchased_table;

-- Metric : YoY Estimated Procurement Value Growth
-- Period : 2023–2025
-- Description : Calculates annual estimated procurement value and compares each year's value with the previous year to measure year-over-year growth in estimated procurement value.
with year_wise_estimated_procurement_value_table as (
    select
        year(po.purchase_datetime) as year,
        sum(pod.quantity * pv.cost_price) as current_year_estimated_procurement_value,
        lag(sum(pod.quantity * pv.cost_price)) over(
            order by
                year(po.purchase_datetime)
        ) as previous_year_estimated_procurement_value
    from
        purchase_order_details pod
        inner join purchase_orders po on po.purchase_order_id = pod.purchase_order_id
        inner join product_variants pv on pv.variant_id = pod.variant_id
    where
        po.purchase_datetime >= '2023-01-01'
        and po.purchase_datetime < '2026-01-01'
    group by
        year(po.purchase_datetime)
)
select
    year,
    round(current_year_estimated_procurement_value, 2) as current_year_estimated_procurement_value,
    round(previous_year_estimated_procurement_value, 2) as previous_year_estimated_procurement_value,
    round(
        (
            (
                current_year_estimated_procurement_value - previous_year_estimated_procurement_value
            ) * 100
        ) / previous_year_estimated_procurement_value,
        2
    ) as estimated_procurement_value_growth_percentage
from
    year_wise_estimated_procurement_value_table;

    -- Metric : Procurement Volume CAGR
-- Period : 2023–2025
-- Description : Calculates the compound annual growth rate of procurement volume between 2023 and 2025 using total units purchased in the beginning and ending years.

with year_wise_units_purchased_table as (
    select
        year(po.purchase_datetime) as year,
        sum(pod.quantity) as current_year_units_purchased,
        lag(sum(pod.quantity)) over(
            order by
                year(po.purchase_datetime)
        ) as previous_year_units_purchased
    from
        purchase_order_details pod
        inner join purchase_orders po on po.purchase_order_id = pod.purchase_order_id
    where
        po.purchase_datetime >= '2023-01-01'
        and po.purchase_datetime < '2026-01-01'
    group by
        year(po.purchase_datetime)
),
units_purchased_growth_table as(
select
    *,
    round(
        (
            (
                current_year_units_purchased - previous_year_units_purchased
            ) * 100
        ) / previous_year_units_purchased,
        2
    ) as units_purchased_growth_percentage
from
    year_wise_units_purchased_table
)
select
round(
    (
        power(
            (
                (select current_year_units_purchased
                 from units_purchased_growth_table
                 where year = 2025)
                /
                (select current_year_units_purchased
                 from units_purchased_growth_table
                 where year = 2023)
            ),
            1.0 / 2
        ) - 1
    ) * 100,
    2
) as procurement_volume_cagr;

-- Metric : Supplier Procurement Trend
-- Period : 2023–2025
-- Description : Calculates annual procurement volume for each supplier and compares it with the previous year's units purchased to measure year-over-year supplier procurement growth.

with units_purchased_table as (
select
s.supplier_id,
s.supplier_name,
year(po.purchase_datetime) as year,
sum(pod.quantity) as current_year_units_purchased,
lag(sum(pod.quantity)) over(
    partition by s.supplier_id
    order by year(po.purchase_datetime)
) as previous_year_units_purchased
from purchase_orders po
inner join purchase_order_details pod
    on po.purchase_order_id = pod.purchase_order_id
inner join suppliers s
    on po.supplier_id = s.supplier_id
where
po.purchase_datetime >= '2023-01-01'
and po.purchase_datetime < '2026-01-01'
group by
s.supplier_id,
s.supplier_name,
year(po.purchase_datetime)
)

select *,
round(
    (
        (current_year_units_purchased - previous_year_units_purchased) * 100
    ) / previous_year_units_purchased,
    2
) as units_purchased_growth_percentage
from units_purchased_table;

-- Metric : Category Procurement Trend
-- Period : 2023–2025
-- Description : Calculates annual procurement volume for each product category and compares it with the previous year's units purchased to measure year-over-year category procurement growth.

with units_purchased_table as (
select
p.category,
year(po.purchase_datetime) as year,
sum(pod.quantity) as current_year_units_purchased,
lag(sum(pod.quantity)) over(
    partition by p.category
    order by year(po.purchase_datetime)
) as previous_year_units_purchased
from purchase_orders po
inner join purchase_order_details pod
    on po.purchase_order_id = pod.purchase_order_id
inner join product_variants pv
    on pv.variant_id = pod.variant_id
inner join products p
    on pv.product_id = p.product_id
where
po.purchase_datetime >= '2023-01-01'
and po.purchase_datetime < '2026-01-01'
group by
p.category,
year(po.purchase_datetime)
)

select *,
round(
    (
        (current_year_units_purchased - previous_year_units_purchased) * 100
    ) / previous_year_units_purchased,
    2
) as units_purchased_growth_percentage
from units_purchased_table;
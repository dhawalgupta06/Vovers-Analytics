-- Metric : YoY Units Requested for Return Growth
-- Period : 2023–2025
-- Description : Calculates annual units requested for return and compares each year's volume with the previous year to measure year-over-year growth in return-request quantity.

with units_return_requested_comparison_table as(
select 
year(return_datetime) as year,
sum(returned_quantity) as current_year_units_return_requested,
lag(sum(returned_quantity)) over(
    order by year(return_datetime)
) as previous_year_units_return_requested
from returns
where
return_datetime >= '2023-01-01'
and return_datetime < '2026-01-01'
group by
year(return_datetime)
)

select *,
round(
    (
        (current_year_units_return_requested - previous_year_units_return_requested) * 100
    ) / previous_year_units_return_requested,
    2
) as units_return_requested_growth_percentage
from units_return_requested_comparison_table
order by year;

-- Metric : Return Request Rate Trend by Year
-- Period : 2023–2025
-- Description : Calculates annual return-requested units as a percentage of total units sold in the corresponding year to evaluate the return request rate trend.

with total_units_sold_per_year as(
select
year(o.order_datetime) as sales_year,
sum(od.quantity) as total_units_sold
from order_details od
inner join orders o
    on od.order_id = o.order_id
where
o.order_datetime >= '2023-01-01'
and o.order_datetime < '2026-01-01'
group by
year(o.order_datetime)
),

units_return_requested_table as(
select
year(return_datetime) as return_year,
sum(returned_quantity) as units_return_requested
from returns
where
return_datetime >= '2023-01-01'
and return_datetime < '2026-01-01'
group by
year(return_datetime)
)

select
r.return_year as year,
r.units_return_requested,
s.total_units_sold,
round(
    (r.units_return_requested * 100) / s.total_units_sold,
    2
) as return_request_rate_percentage
from units_return_requested_table r
inner join total_units_sold_per_year s
    on r.return_year = s.sales_year
order by
year;

-- Metric : Return Status Trend
-- Period : 2023–2025
-- Description : Calculates annual units requested for return under each return status to evaluate changes in return status distribution over time.

select
year(return_datetime) as year,
return_status,
sum(returned_quantity) as units_requested_for_return
from returns
where
return_datetime >= '2023-01-01'
and return_datetime < '2026-01-01'
group by
year(return_datetime),
return_status
order by
year,
units_requested_for_return desc;
-- Metric : Category Return Trend
-- Period : 2023–2025
-- Description : Calculates annual units requested for return for each product category to evaluate changes in category-level return activity over time.

select
year(r.return_datetime) as year,
p.category,
sum(r.returned_quantity) as units_requested_for_return
from returns r
inner join order_details od
    on od.order_detail_id = r.order_detail_id
inner join product_variants pv
    on od.variant_id = pv.variant_id
inner join products p
    on p.product_id = pv.product_id
where
r.return_datetime >= '2023-01-01'
and r.return_datetime < '2026-01-01'
group by
year(r.return_datetime),
p.category
order by
p.category,
year;
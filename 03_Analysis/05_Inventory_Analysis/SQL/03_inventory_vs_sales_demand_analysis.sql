-- Metric : Current Inventory vs Recent Units Sold
-- Period : Current Inventory Snapshot vs Last 90 Days of Sales
-- Description : Compares the current inventory quantity of each Product Variant
-- with units sold during the last 90 days, while retaining all Product Variants
-- including those with no current inventory or no recent sales.

with inventory_table as(
select
variant_id,
sum(quantity) as current_inventory_count
from inventory
group by variant_id
),
recent_sales_table as(
select
od.variant_id,
sum(od.quantity) as recent_sales
from orders o
inner join order_details od on o.order_id = od.order_id
where o.order_datetime >= date_sub(
    (select max(order_datetime) from orders),
    interval 90 day
)
group by od.variant_id
)
select
pv.variant_id,
coalesce(i.current_inventory_count,0) as current_inventory_count,
coalesce(r.recent_sales,0) as recent_sales
from product_variants pv
left join inventory_table i on pv.variant_id = i.variant_id
left join recent_sales_table r on r.variant_id = pv.variant_id;

-- Metric : Inventory-to-Sales Ratio by Product Variant
-- Period : Current Inventory Snapshot vs Last 90 Days of Sales
-- Description : Compares the current inventory quantity of each Product Variant
-- with units sold during the last 90 days and calculates the Inventory-to-Sales
-- Ratio to evaluate current stock levels relative to recent sales demand.

with inventory_table as(
select
variant_id,
sum(quantity) as current_inventory_count
from inventory
group by variant_id
),
recent_sales_table as(
select
od.variant_id,
sum(od.quantity) as recent_sales
from orders o
inner join order_details od on o.order_id = od.order_id
where o.order_datetime >= date_sub(
    (select max(order_datetime) from orders),
    interval 90 day
)
group by od.variant_id
),
inventory_and_sales_comparison_table as(
select
pv.variant_id,
coalesce(i.current_inventory_count,0) as current_inventory_count,
coalesce(r.recent_sales,0) as recent_sales
from product_variants pv
left join inventory_table i on pv.variant_id = i.variant_id
left join recent_sales_table r on r.variant_id = pv.variant_id
)
select *,
case
    when current_inventory_count = 0 or recent_sales = 0 then null
    else round((current_inventory_count/recent_sales),2)
end as inventory_to_sales_ratio
from inventory_and_sales_comparison_table;

-- Metric : Inventory Demand Alignment by Product Variant
-- Period : Current Inventory Snapshot vs Last 90 Days of Sales
-- Description : Compares current inventory with recent sales demand for each
-- Product Variant, calculates the Inventory-to-Sales Ratio, and classifies
-- variants as Understock, Balanced Stock, Overstock, or No Recent Demand.

with inventory_table as(
select
variant_id,
sum(quantity) as current_inventory_count
from inventory
group by variant_id
),

recent_sales_table as(
select
od.variant_id,
sum(od.quantity) as recent_sales
from orders o
inner join order_details od
    on o.order_id = od.order_id
where o.order_datetime >= date_sub(
    (select max(order_datetime) from orders),
    interval 90 day
)
group by od.variant_id
),

inventory_and_sales_comparison_table as(
select
pv.variant_id,
coalesce(i.current_inventory_count,0) as current_inventory_count,
coalesce(r.recent_sales,0) as recent_sales
from product_variants pv
left join inventory_table i
    on pv.variant_id = i.variant_id
left join recent_sales_table r
    on r.variant_id = pv.variant_id
),

ratio_table as(
select *,
case
    when current_inventory_count = 0 or recent_sales = 0 then null
    else round((current_inventory_count/recent_sales),2)
end as inventory_to_sales_ratio
from inventory_and_sales_comparison_table
)

select *,
case
    when recent_sales = 0 then "No Recent Demand"
    when current_inventory_count = 0
         or inventory_to_sales_ratio < 1 then "Understock"
    when inventory_to_sales_ratio <= 3 then "Balanced Stock"
    else "Overstock"
end as inventory_status
from ratio_table;
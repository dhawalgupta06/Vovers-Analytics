-- Metric : Inventory Contribution % by Region
-- Period : Current Inventory Snapshot
-- Description : Calculates the current inventory units held across Stores
-- and Warehouses in each region and measures each region's contribution
-- to the company's total current inventory.

with store_inventory as(
select
s.region,
sum(quantity) as store_inventory_count
from inventory i
inner join stores s
    on i.store_id = s.store_id
where i.store_id is not null
group by s.region
),

warehouse_inventory as(
select
w.region,
sum(quantity) as warehouse_inventory_count
from inventory i
inner join warehouses w
    on i.warehouse_id = w.warehouse_id
where i.warehouse_id is not null
group by w.region
),

combined_inventory as(
select
region,
store_inventory_count as inventory_count
from store_inventory

union all

select
region,
warehouse_inventory_count as inventory_count
from warehouse_inventory
),

region_inventory_count as(
select
region,
sum(inventory_count) as inventory_count
from combined_inventory
group by region
)

select
region,
inventory_count,
round(
    (inventory_count * 100) /
    (select sum(quantity) from inventory),
    2
) as inventory_contribution
from region_inventory_count;

-- Metric : Sales Contribution % by Region
-- Period : Last 90 Days of Sales
-- Description : Calculates units sold in each region during the last 90 days
-- and measures each region's contribution to total recent sales demand.

with region_sales_table as(
select
s.region,
sum(od.quantity) as recent_sales_count
from orders o
inner join order_details od
    on od.order_id = o.order_id
inner join stores s
    on s.store_id = o.store_id
where o.order_datetime >= date_sub(
    (select max(order_datetime) from orders),
    interval 90 day
)
group by s.region
)

select
region,
recent_sales_count,
round(
    (recent_sales_count * 100) /
    (select sum(od.quantity)
     from orders o
     inner join order_details od
         on od.order_id = o.order_id
     where o.order_datetime >= date_sub(
         (select max(order_datetime) from orders),
         interval 90 day
     )),
    2
) as sales_contribution
from region_sales_table;

-- Metric : Sales Contribution vs Inventory Contribution by Region
-- Period : Current Inventory Snapshot vs Last 90 Days of Sales
-- Description : Compares each region's contribution to total current inventory
-- with its contribution to total recent sales demand to evaluate whether
-- inventory allocation is aligned with geographic sales demand.

with store_inventory as(
select
s.region,
sum(quantity) as store_inventory_count
from inventory i
inner join stores s
    on i.store_id = s.store_id
where i.store_id is not null
group by s.region
),

warehouse_inventory as(
select
w.region,
sum(quantity) as warehouse_inventory_count
from inventory i
inner join warehouses w
    on i.warehouse_id = w.warehouse_id
where i.warehouse_id is not null
group by w.region
),

combined_inventory as(
select
region,
store_inventory_count as inventory_count
from store_inventory

union all

select
region,
warehouse_inventory_count as inventory_count
from warehouse_inventory
),

region_inventory_count as(
select
region,
sum(inventory_count) as inventory_count
from combined_inventory
group by region
),

region_inventory_contribution_table as(
select
region,
inventory_count,
round(
    (inventory_count * 100) /
    (select sum(quantity) from inventory),
    2
) as inventory_contribution
from region_inventory_count
),

region_sales_table as(
select
s.region,
sum(od.quantity) as recent_sales_count
from orders o
inner join order_details od
    on od.order_id = o.order_id
inner join stores s
    on s.store_id = o.store_id
where o.order_datetime >= date_sub(
    (select max(order_datetime) from orders),
    interval 90 day
)
group by s.region
),

region_sales_contribution_table as(
select
region,
recent_sales_count,
round(
    (recent_sales_count * 100) /
    (select sum(od.quantity)
     from orders o
     inner join order_details od
         on od.order_id = o.order_id
     where o.order_datetime >= date_sub(
         (select max(order_datetime) from orders),
         interval 90 day
     )),
    2
) as sales_contribution
from region_sales_table
)

select
i.region,
inventory_contribution,
sales_contribution
from region_inventory_contribution_table i
inner join region_sales_contribution_table s
    on i.region = s.region;

    -- Metric : Regional Inventory Allocation Analysis
-- Period : Current Inventory Snapshot vs Last 90 Days of Sales
-- Description : Compares each region's contribution to total current inventory
-- with its contribution to recent sales demand, calculates the allocation gap,
-- and classifies regions as Under-Allocated, Balanced, or Over-Allocated.

with store_inventory as(
select
s.region,
sum(quantity) as store_inventory_count
from inventory i
inner join stores s
    on i.store_id = s.store_id
where i.store_id is not null
group by s.region
),

warehouse_inventory as(
select
w.region,
sum(quantity) as warehouse_inventory_count
from inventory i
inner join warehouses w
    on i.warehouse_id = w.warehouse_id
where i.warehouse_id is not null
group by w.region
),

combined_inventory as(
select
region,
store_inventory_count as inventory_count
from store_inventory

union all

select
region,
warehouse_inventory_count as inventory_count
from warehouse_inventory
),

region_inventory_count as(
select
region,
sum(inventory_count) as inventory_count
from combined_inventory
group by region
),

region_inventory_contribution_table as(
select
region,
inventory_count,
round(
    (inventory_count * 100) /
    (select sum(quantity) from inventory),
    2
) as inventory_contribution
from region_inventory_count
),

region_sales_table as(
select
s.region,
sum(od.quantity) as recent_sales_count
from orders o
inner join order_details od
    on od.order_id = o.order_id
inner join stores s
    on s.store_id = o.store_id
where o.order_datetime >= date_sub(
    (select max(order_datetime) from orders),
    interval 90 day
)
group by s.region
),

region_sales_contribution_table as(
select
region,
recent_sales_count,
round(
    (recent_sales_count * 100) /
    (
        select sum(od.quantity)
        from orders o
        inner join order_details od
            on od.order_id = o.order_id
        where o.order_datetime >= date_sub(
            (select max(order_datetime) from orders),
            interval 90 day
        )
    ),
    2
) as sales_contribution
from region_sales_table
),

allocation_gap_table as(
select
i.region,
inventory_contribution,
sales_contribution,
(inventory_contribution - sales_contribution) as allocation_gap
from region_inventory_contribution_table i
inner join region_sales_contribution_table s
    on i.region = s.region
)

select *,
case
    when allocation_gap < -2 then "Under-Allocated"
    when allocation_gap >= -2 and allocation_gap <= 2 then "Balanced"
    when allocation_gap > 2 then "Over-Allocated"
end as classification
from allocation_gap_table;
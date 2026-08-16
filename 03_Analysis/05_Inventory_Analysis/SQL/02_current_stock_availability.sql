-- Metric : Company-Level Out-of-Stock Variants
-- Period : Current Inventory Snapshot
-- Description : Identifies product variants with zero total inventory across all stores and warehouses, including variants with no inventory record.

select
pv.*
from product_variants pv
left join inventory i on pv.variant_id = i.variant_id
group by pv.variant_id
having coalesce(sum(i.quantity),0) = 0;

-- Metric : Stock Availability by Category
-- Period : Current Inventory Snapshot
-- Description : Evaluates stock availability across product categories using total variants, in-stock variants, out-of-stock variants, and stock availability percentage based on current inventory levels.

with stock_count_of_variants_table as (
select
pv.variant_id,
p.category,
coalesce(sum(i.quantity),0) as stock_available
from product_variants pv
left join inventory i on pv.variant_id = i.variant_id
inner join products p on p.product_id = pv.product_id
group by pv.variant_id
),
stock_availability_table as(
select  
p.category,
count(distinct pv.variant_id) as total_variants,
coalesce((select in_stock_variants from (select category, count(distinct variant_id) as in_stock_variants from stock_count_of_variants_table where stock_available > 0 group by category) as is_stock_count_table where category=p.category),0) as in_stock_variants,
coalesce((select out_stock_variants from (select category, count(distinct variant_id) as out_stock_variants from stock_count_of_variants_table where stock_available=0 group by category) as out_stock_count_table where category=p.category),0) as out_stock_variants
from product_variants pv
inner join products p on p.product_id = pv.product_id
group by p.category
)
select *, round((in_stock_variants*100)/total_variants,2) as stock_availability_percentage from stock_availability_table;

-- Metric : Stock Availability by Product
-- Period : Current Inventory Snapshot
-- Description : Evaluates stock availability for each product using total variants, in-stock variants, out-of-stock variants, and stock availability percentage based on current inventory levels.

with stock_count_of_variants_table as (
select
pv.variant_id,
p.product_id,
p.product_name,
coalesce(sum(i.quantity),0) as stock_available
from product_variants pv
left join inventory i on pv.variant_id = i.variant_id
inner join products p on p.product_id = pv.product_id
group by pv.variant_id
),
stock_availability_table as(
select  
p.product_id,
p.product_name,
count(distinct pv.variant_id) as total_variants,
coalesce((select in_stock_variants from (select product_id,product_name, count(distinct variant_id) as in_stock_variants from stock_count_of_variants_table where stock_available > 0 group by product_id, product_name) as is_stock_count_table where product_id=p.product_id and product_name = p.product_name),0) as in_stock_variants,
coalesce((select out_stock_variants from (select product_id,product_name, count(distinct variant_id) as out_stock_variants from stock_count_of_variants_table where stock_available=0 group by product_id,product_name) as out_stock_count_table where product_id=p.product_id and product_name = p.product_name),0) as out_stock_variants
from product_variants pv
inner join products p on p.product_id = pv.product_id
group by p.product_id,
p.product_name
)
select *, round((in_stock_variants*100)/total_variants,2) as stock_availability_percentage from stock_availability_table;

-- Metric : Stock Availability by Location Type
-- Period : Current Inventory Snapshot
-- Description : Evaluates current variant stock availability across Stores
-- and Warehouses using total variants, in-stock variants, out-of-stock
-- variants, and stock availability percentage.

with stock_count_of_variants_table as (
select
    pv.variant_id,
    i.location_type,
    coalesce(sum(i.quantity),0) as stock_available
from product_variants pv
left join inventory i
    on pv.variant_id = i.variant_id
group by
    pv.variant_id,
    i.location_type
),
out_stock_count_table as (
select
    i.location_type,
    (select count(distinct variant_id)
     from product_variants) as total_variants,

    coalesce((
        select in_stock
        from (
            select
                location_type,
                count(distinct variant_id) as in_stock
            from stock_count_of_variants_table
            where stock_available > 0
            group by location_type
        ) as group_by_table
        where location_type = i.location_type
    ),0) as in_stock

from inventory i
group by i.location_type
)
select
    *,
    (total_variants - in_stock) as out_stock,
    round((in_stock * 100) / total_variants,2)
        as stock_availability_percentage
from out_stock_count_table;

-- Metric : Stock Availability by Store
-- Period : Current Inventory Snapshot
-- Description : Evaluates current variant availability for each store by comparing the total company-wide variant assortment with the number of variants having positive stock at that store.

with stock_count_of_variants_table as (
select
pv.variant_id,
i.store_id,
coalesce(sum(i.quantity),0) as stock_available
from product_variants pv
left join inventory i on pv.variant_id = i.variant_id
group by pv.variant_id, i.store_id
),
in_stock_count_table as (
select
s.store_id,
(select count(distinct variant_id) from product_variants) as total_variants,
coalesce((
select in_stock_count
from (
select
store_id,
count(distinct variant_id) as in_stock_count
from stock_count_of_variants_table
where stock_available > 0
group by store_id
) as group_by_table
where s.store_id = store_id
),0) as in_stock_count
from stores s
)
select *,
(total_variants-in_stock_count) as out_stock_count
from in_stock_count_table;

-- Metric : Stock Availability by Warehouse
-- Period : Current Inventory Snapshot
-- Description : Evaluates current variant coverage for each warehouse by comparing the total company-wide variant assortment with the number of variants having positive stock at that warehouse.

with stock_count_of_variants_table as (
select
pv.variant_id,
i.warehouse_id,
coalesce(sum(i.quantity),0) as stock_available
from product_variants pv
left join inventory i on pv.variant_id = i.variant_id
group by pv.variant_id, i.warehouse_id
),
in_stock_count_table as (
select
w.warehouse_id,
(select count(distinct variant_id) from product_variants) as total_variants,
coalesce((
select in_stock_count
from (
select
warehouse_id,
count(distinct variant_id) as in_stock_count
from stock_count_of_variants_table
where stock_available > 0
group by warehouse_id
) as group_by_table
where w.warehouse_id = warehouse_id
),0) as in_stock_count
from warehouses w
)
select *,
(total_variants-in_stock_count) as variants_not_stocked_count
from in_stock_count_table;
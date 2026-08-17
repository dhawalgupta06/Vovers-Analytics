-- Metric : Units Purchased vs Units Sold by Product Variant
-- Period : All-Time
-- Description : Compares total units purchased and total units sold for each Product Variant to evaluate procurement volume against realized sales demand.
with units_purchased_table as(
    select
        pv.variant_id,
        p.product_id,
        p.product_name,
        pv.color,
        pv.size,
        pv.storage,
        sum(pod.quantity) as units_purchased
    from
        product_variants pv
        inner join purchase_order_details pod on pv.variant_id = pod.variant_id
        inner join products p on p.product_id = pv.product_id
    group by
        pv.variant_id,
        p.product_id,
        p.product_name,
        pv.color,
        pv.size,
        pv.storage
),
units_sold_table as(
    select
        pv.variant_id,
        sum(od.quantity) as units_sold
    from
        product_variants pv
        inner join order_details od on pv.variant_id = od.variant_id
    group by
        pv.variant_id
)
select
    p.*,
    coalesce(s.units_sold, 0) as units_sold
from
    units_purchased_table p
    left join units_sold_table s on p.variant_id = s.variant_id;

-- Metric : Units Purchased vs Current Inventory by Product Variant
-- Period : All-Time Purchases vs Current Inventory Snapshot
-- Description : Compares total units purchased for each Product Variant with its current remaining inventory to evaluate how much procured stock is still held by Vovers.
with units_purchased_table as(
    select
        pv.variant_id,
        p.product_id,
        p.product_name,
        pv.color,
        pv.size,
        pv.storage,
        sum(pod.quantity) as units_purchased
    from
        product_variants pv
        inner join purchase_order_details pod on pv.variant_id = pod.variant_id
        inner join products p on p.product_id = pv.product_id
    group by
        pv.variant_id,
        p.product_id,
        p.product_name,
        pv.color,
        pv.size,
        pv.storage
),
current_inventory_table as(
    select
        variant_id,
        sum(quantity) as current_units
    from
        inventory
    group by
        variant_id
)
select
    p.*,
    coalesce(i.current_units, 0) as current_units
from
    units_purchased_table p
    left join current_inventory_table i on p.variant_id = i.variant_id;

-- Metric : Procurement Alignment by Product Variant
-- Period : All-Time Purchases and Sales vs Current Inventory Snapshot
-- Description : Combines total units purchased, total units sold, and current inventory for each Product Variant to evaluate procurement alignment and identify potential over-procurement.
with units_purchased_table as(
    select
        pv.variant_id,
        p.product_id,
        p.product_name,
        pv.color,
        pv.size,
        pv.storage,
        sum(pod.quantity) as units_purchased
    from
        product_variants pv
        inner join purchase_order_details pod on pv.variant_id = pod.variant_id
        inner join products p on p.product_id = pv.product_id
    group by
        pv.variant_id,
        p.product_id,
        p.product_name,
        pv.color,
        pv.size,
        pv.storage
),
units_sold_table as(
    select
        pv.variant_id,
        sum(od.quantity) as units_sold
    from
        product_variants pv
        inner join order_details od on pv.variant_id = od.variant_id
    group by
        pv.variant_id
),
current_inventory_table as(
    select
        variant_id,
        sum(quantity) as current_units
    from
        inventory
    group by
        variant_id
),
units_purchased_and_sold_table as(
    select
        p.*,
        coalesce(s.units_sold, 0) as units_sold
    from
        units_purchased_table p
        left join units_sold_table s on p.variant_id = s.variant_id
)
select
    ps.*,
    coalesce(i.current_units, 0) as current_units
from
    units_purchased_and_sold_table ps
    left join current_inventory_table i on ps.variant_id = i.variant_id;

    -- Metric : Procurement Alignment by Product Variant
-- Period : All-Time Purchases and Sales vs Current Inventory Snapshot
-- Description : Compares units purchased, units sold, and current inventory for each Product Variant, calculates sell-through and remaining inventory percentages, and classifies procurement alignment to identify potential over-procurement risk.

with units_purchased_table as(
select
pv.variant_id,
p.product_id,
p.product_name,
pv.color,
pv.size,
pv.storage,
sum(pod.quantity) as units_purchased
from product_variants pv
inner join purchase_order_details pod
    on pv.variant_id = pod.variant_id
inner join products p
    on p.product_id = pv.product_id
group by
pv.variant_id,
p.product_id,
p.product_name,
pv.color,
pv.size,
pv.storage
),

units_sold_table as(
select
pv.variant_id,
sum(od.quantity) as units_sold
from product_variants pv
inner join order_details od
    on pv.variant_id = od.variant_id
group by
pv.variant_id
),

current_inventory_table as(
select
variant_id,
sum(quantity) as current_units
from inventory
group by
variant_id
),

units_purchased_and_sold_table as(
select
p.*,
coalesce(s.units_sold,0) as units_sold
from units_purchased_table p
left join units_sold_table s
    on p.variant_id = s.variant_id
),

unit_purchased_sold_and_inventory_table as(
select
ps.*,
coalesce(i.current_units,0) as current_units
from units_purchased_and_sold_table ps
left join current_inventory_table i
    on ps.variant_id = i.variant_id
),

sellout_and_inventory_percentage as(
select *,
round((units_sold*100)/units_purchased,2) as sell_through_percentage,
round((current_units*100)/units_purchased,2) as remaining_inventory_percentage
from unit_purchased_sold_and_inventory_table
)

select *,
case
    when sell_through_percentage >= 90 then 'Healthy Procurement'
    when sell_through_percentage >= 80 then 'Moderate Inventory'
    when sell_through_percentage >= 50 then 'Potential Over-Procurement'
    when sell_through_percentage < 50 then 'High Over-Procurement Risk'
end as procurement_alignment_status
from sellout_and_inventory_percentage;
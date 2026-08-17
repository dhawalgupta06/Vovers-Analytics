-- Metric : Units Purchased by Category
-- Period : All-Time
-- Description : Calculates the total quantity of Product Variant units purchased within each product category to measure category-level procurement volume.

select
p.category,
sum(pod.quantity) as total_units_purchased
from purchase_order_details pod
inner join product_variants pv
    on pv.variant_id = pod.variant_id
inner join products p
    on p.product_id = pv.product_id
group by
p.category;

-- Metric : Estimated Procurement Value by Category
-- Period : All-Time
-- Description : Calculates the estimated procurement value for each product category using purchased quantity multiplied by the current cost price of each Product Variant.

select
p.category,
round(sum(pod.quantity * pv.cost_price), 2) as estimated_procurement_value
from purchase_order_details pod
inner join product_variants pv
    on pv.variant_id = pod.variant_id
inner join products p
    on p.product_id = pv.product_id
group by
p.category;

-- Metric : Units Purchased Contribution % by Category
-- Period : All-Time
-- Description : Calculates each product category's contribution to total procurement volume by measuring its purchased units as a percentage of total units purchased.

select
p.category,
sum(pod.quantity) as total_units_purchased,
round(
    (sum(pod.quantity) * 100) /
    (select sum(quantity) from purchase_order_details),
    2
) as units_purchased_contribution
from purchase_order_details pod
inner join product_variants pv
    on pv.variant_id = pod.variant_id
inner join products p
    on p.product_id = pv.product_id
group by
p.category;

-- Metric : Estimated Procurement Value Contribution % by Category
-- Period : All-Time
-- Description : Calculates each product category's contribution to total estimated procurement value using purchased quantity multiplied by the current cost price of each Product Variant.

select
p.category,
round(sum(pod.quantity * pv.cost_price), 2) as estimated_procurement_value,
round(
    (sum(pod.quantity * pv.cost_price) * 100) /
    (
        select sum(pod.quantity * pv.cost_price)
        from purchase_order_details pod
        inner join product_variants pv
            on pv.variant_id = pod.variant_id
    ),
    2
) as estimated_procurement_value_contribution
from purchase_order_details pod
inner join product_variants pv
    on pv.variant_id = pod.variant_id
inner join products p
    on p.product_id = pv.product_id
group by
p.category;

-- Metric : Units Purchased by Product
-- Period : All-Time
-- Description : Calculates the total quantity of units purchased for each product by aggregating procurement volume across all of its Product Variants.

select
p.product_id,
p.product_name,
sum(pod.quantity) as total_units_purchased
from purchase_order_details pod
inner join product_variants pv
    on pv.variant_id = pod.variant_id
inner join products p
    on p.product_id = pv.product_id
group by
p.product_id,
p.product_name;

-- Metric : Estimated Procurement Value by Product
-- Period : All-Time
-- Description : Calculates the estimated procurement value for each product by aggregating purchased quantity multiplied by the current cost price across all of its Product Variants.

select
p.product_id,
p.product_name,
round(sum(pod.quantity * pv.cost_price), 2) as estimated_procurement_value
from purchase_order_details pod
inner join product_variants pv
    on pv.variant_id = pod.variant_id
inner join products p
    on p.product_id = pv.product_id
group by
p.product_id,
p.product_name;

-- Metric : Units Purchased by Product Variant
-- Period : All-Time
-- Description : Calculates the total quantity of units purchased for each Product Variant while displaying its associated product and variant attributes for identification.

select
pv.variant_id,
p.product_id,
p.product_name,
pv.color,
pv.size,
pv.storage,
sum(pod.quantity) as total_units_purchased
from purchase_order_details pod
inner join product_variants pv
    on pv.variant_id = pod.variant_id
inner join products p
    on p.product_id = pv.product_id
group by
pv.variant_id,
pv.color,
pv.size,
pv.storage,
p.product_id,
p.product_name;

-- Metric : Estimated Procurement Value by Product Variant
-- Period : All-Time
-- Description : Calculates the estimated procurement value for each Product Variant using purchased quantity multiplied by its current cost price while displaying the associated product and variant attributes for identification.

select
pv.variant_id,
p.product_id,
p.product_name,
pv.color,
pv.size,
pv.storage,
round(sum(pod.quantity * pv.cost_price), 2) as estimated_procurement_value
from purchase_order_details pod
inner join product_variants pv
    on pv.variant_id = pod.variant_id
inner join products p
    on p.product_id = pv.product_id
group by
pv.variant_id,
p.product_id,
p.product_name,
pv.color,
pv.size,
pv.storage;
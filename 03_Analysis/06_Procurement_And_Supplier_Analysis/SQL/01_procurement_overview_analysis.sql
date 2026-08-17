-- Metric : Total Purchase Orders
-- Period : All-Time
-- Description : Calculates the total number of purchase orders created by Vovers across all suppliers and warehouses.
select
    count(purchase_order_id) as total_purchase_orders
from
    purchase_orders;

-- Metric : Total Units Purchased
-- Period : All-Time
-- Description : Calculates the total quantity of product variants purchased across all purchase orders.
select
    sum(quantity) as total_units_purchased
from
    purchase_order_details;

-- Metric : Estimated Procurement Value
-- Period : All-Time
-- Description : Estimates the total procurement value using purchased quantity multiplied by the current cost price of each Product Variant.
select
    round(sum(pod.quantity * pv.cost_price), 2) as estimated_procurement_value
from
    purchase_order_details pod
    inner join product_variants pv on pod.variant_id = pv.variant_id;

-- Metric : Average Units per Purchase Order
-- Period : All-Time
-- Description : Calculates the average number of units purchased per purchase order using total purchased units divided by the total number of purchase orders.
select
    round(
        sum(quantity) /(
            select
                count(*)
            from
                purchase_orders
        ),
        2
    ) as avg_unit_per_purchase_order
from
    purchase_order_details;

-- Metric : Average Estimated Purchase Order Value
-- Period : All-Time
-- Description : Calculates the average estimated value of a purchase order using total estimated procurement value divided by the total number of purchase orders.
select
    round(
        sum(pod.quantity * pv.cost_price) / (
            select
                count(*)
            from
                purchase_orders
        ),
        2
    ) as avg_estimated_purchase_order_value
from
    purchase_order_details pod
    inner join product_variants pv on pod.variant_id = pv.variant_id;

-- Metric : Units Purchased by Year
-- Period : All-Time
-- Description : Calculates the total quantity of product variants purchased in each year to show the annual procurement volume trend.
select
    year(po.purchase_datetime) as year,
    sum(pod.quantity) as total_units_purchased
from
    purchase_order_details pod
    inner join purchase_orders po on pod.purchase_order_id = po.purchase_order_id
group by
    year(po.purchase_datetime)
order by
    year;

-- Metric : Estimated Procurement Value by Year
-- Period : All-Time
-- Description : Calculates the estimated annual procurement value using purchased quantity multiplied by the current cost price of each Product Variant.
select
    year(po.purchase_datetime) as year,
    round(sum(pod.quantity * pv.cost_price), 2) as estimated_procurement_value
from
    purchase_order_details pod
    inner join purchase_orders po on pod.purchase_order_id = po.purchase_order_id
    inner join product_variants pv on pv.variant_id = pod.variant_id
group by
    year(po.purchase_datetime)
order by
    year;
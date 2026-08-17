-- Metric : Purchase Orders by Supplier
-- Period : All-Time
-- Description : Calculates the total number of distinct purchase orders
-- placed with each supplier to measure supplier-level procurement activity.
select
    s.supplier_id,
    s.supplier_name,
    count(distinct po.purchase_order_id) as total_purchase_orders
from
    purchase_orders po
    inner join suppliers s on s.supplier_id = po.supplier_id
group by
    s.supplier_id,
    s.supplier_name;

-- Metric : Units Purchased by Supplier
-- Period : All-Time
-- Description : Calculates the total quantity of Product Variant units
-- purchased from each supplier to measure supplier-level procurement volume.
select
    s.supplier_id,
    s.supplier_name,
    sum(pod.quantity) as total_units_purchased
from
    purchase_orders po
    inner join purchase_order_details pod on po.purchase_order_id = pod.purchase_order_id
    inner join suppliers s on s.supplier_id = po.supplier_id
group by
    s.supplier_id,
    s.supplier_name;

-- Metric : Estimated Procurement Value by Supplier
-- Period : All-Time
-- Description : Calculates the estimated procurement value associated with
-- each supplier using purchased quantity multiplied by the current cost price
-- of each Product Variant.
select
    s.supplier_id,
    s.supplier_name,
    round(sum(pod.quantity * pv.cost_price), 2) as estimated_procurement_value
from
    purchase_orders po
    inner join purchase_order_details pod on po.purchase_order_id = pod.purchase_order_id
    inner join product_variants pv on pv.variant_id = pod.variant_id
    inner join suppliers s on s.supplier_id = po.supplier_id
group by
    s.supplier_id,
    s.supplier_name;

-- Metric : Average Units per Purchase Order by Supplier
-- Period : All-Time
-- Description : Calculates the average number of units purchased per purchase
-- order for each supplier using total units purchased divided by the number
-- of distinct purchase orders placed with that supplier.
select
    s.supplier_id,
    s.supplier_name,
    round(
        sum(pod.quantity) / count(distinct po.purchase_order_id),
        2
    ) as avg_units_per_purchase_order
from
    purchase_orders po
    inner join purchase_order_details pod on po.purchase_order_id = pod.purchase_order_id
    inner join suppliers s on s.supplier_id = po.supplier_id
group by
    s.supplier_id,
    s.supplier_name;

-- Metric : Average Estimated Purchase Order Value by Supplier
-- Period : All-Time
-- Description : Calculates the average estimated value of purchase orders
-- placed with each supplier using total estimated procurement value divided
-- by the number of distinct purchase orders placed with that supplier.
select
    s.supplier_id,
    s.supplier_name,
    round(
        sum(pod.quantity * pv.cost_price) / count(distinct po.purchase_order_id),
        2
    ) as avg_estimated_purchase_order_value
from
    purchase_orders po
    inner join purchase_order_details pod on po.purchase_order_id = pod.purchase_order_id
    inner join product_variants pv on pv.variant_id = pod.variant_id
    inner join suppliers s on s.supplier_id = po.supplier_id
group by
    s.supplier_id,
    s.supplier_name;

-- Metric : Units Purchased Contribution % by Supplier
-- Period : All-Time
-- Description : Calculates each supplier's contribution to total procurement volume by measuring the percentage of total purchased units supplied by each supplier.
with units_purchased_by_supplier_table as(
    select
        s.supplier_id,
        s.supplier_name,
        sum(pod.quantity) as total_units_purchased
    from
        purchase_orders po
        inner join purchase_order_details pod on po.purchase_order_id = pod.purchase_order_id
        inner join suppliers s on s.supplier_id = po.supplier_id
    group by
        s.supplier_id,
        s.supplier_name
)
select
    *,
    round(
        (total_units_purchased * 100) / (
            select
                sum(quantity)
            from
                purchase_order_details
        ),
        2
    ) as units_purchased_contribution
from
    units_purchased_by_supplier_table;

-- Metric : Estimated Procurement Value Contribution % by Supplier
-- Period : All-Time
-- Description : Calculates each supplier's contribution to the company's
-- total estimated procurement value using purchased quantity multiplied
-- by the current cost price of each Product Variant.
with estimated_procurement_value_table as(
    select
        s.supplier_id,
        s.supplier_name,
        round(
            sum(pod.quantity * pv.cost_price),
            2
        ) as estimated_procurement_value
    from
        purchase_orders po
        inner join purchase_order_details pod on po.purchase_order_id = pod.purchase_order_id
        inner join product_variants pv on pv.variant_id = pod.variant_id
        inner join suppliers s on s.supplier_id = po.supplier_id
    group by
        s.supplier_id,
        s.supplier_name
)
select
    *,
    round(
        (estimated_procurement_value * 100) / (
            select
                sum(pod.quantity * pv.cost_price)
            from
                purchase_order_details pod
                inner join product_variants pv on pv.variant_id = pod.variant_id
        ),
        2
    ) as estimated_procurement_value_contribution
from
    estimated_procurement_value_table;
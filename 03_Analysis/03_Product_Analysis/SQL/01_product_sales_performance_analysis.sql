-- Metric : Product Sales Performance
-- Period : All-Time
-- Description : Calculates product-level revenue, units sold, total orders, average selling price, average units per order, and each product's contribution to total revenue and units sold.
with total_metrics_table as (
    select
        round(
            sum(
                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
            ),
            2
        ) as total_revenue,
        sum(od.quantity) as total_units_sold
    from
        order_details od
        inner join product_variants pv on od.variant_id = pv.variant_id
)
select
    p.product_id,
    p.product_name,
    round(
        sum(
            pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
        ),
        2
    ) as revenue,
    sum(od.quantity) as units_sold,
    count(distinct o.order_id) as total_orders,
    round(
        sum(
            pv.selling_price * od.quantity * (1 - od.discount_percentage / 100)
        ) / sum(od.quantity),
        2
    ) as avg_selling_price,
    round(
        (
            (
                sum(
                    pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                )
            ) * 100
        ) /(
            select
                total_revenue
            from
                total_metrics_table
        ),
        2
    ) as revenue_contribution_percentage,
    round(
        (sum(od.quantity) * 100) /(
            select
                total_units_sold
            from
                total_metrics_table
        ),
        2
    ) as units_contribution_percentage,
    round(
        sum(od.quantity) / count(distinct o.order_id),
        2
    ) as avg_units_per_order
from
    orders o
    inner join order_details od on o.order_id = od.order_id
    inner join product_variants pv on pv.variant_id = od.variant_id
    inner join products p on p.product_id = pv.product_id
group by
    p.product_id,
    p.product_name
order by
    p.product_id asc;
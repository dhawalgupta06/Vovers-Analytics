-- Metric : Sales Channel Performance
-- Period : All-Time
-- Description : Evaluates sales channel performance using revenue, total orders, units sold, average order value, gross profit, gross profit margin, and contribution to total company revenue and gross profit.
with total_metrics_table as(
    select
        round(
            sum(
                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
            ),
            2
        ) as total_revenue,
        round(
            sum(
                (
                    pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                ) -(pv.cost_price * od.quantity)
            ),
            2
        ) as total_gross_profit
    from
        order_details od
        inner join product_variants pv on od.variant_id = pv.variant_id
)
select
    o.sales_channel,
    round(
        sum(
            pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
        ),
        2
    ) as revenue,
    count(distinct o.order_id) as total_orders,
    sum(od.quantity) as qty_sold,
    round(
        sum(
            pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
        ) / count(distinct o.order_id),
        2
    ) as average_order_value,
    round(
        sum(
            (
                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
            ) -(pv.cost_price * od.quantity)
        ),
        2
    ) as gross_profit,
    round(
        (
            sum(
                (
                    pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                ) -(pv.cost_price * od.quantity)
            ) * 100
        ) / sum(
            pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
        ),
        2
    ) as gross_profit_margin,
    round(
        (
            sum(
                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
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
        (
            sum(
                (
                    pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                ) -(pv.cost_price * od.quantity)
            ) * 100
        ) /(
            select
                total_gross_profit
            from
                total_metrics_table
        ),
        2
    ) as gross_profit_contribution_percentage
from
    orders o
    inner join order_details od on o.order_id = od.order_id
    inner join product_variants pv on pv.variant_id = od.variant_id
group by
    o.sales_channel;
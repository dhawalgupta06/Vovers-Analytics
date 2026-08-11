-- Metric : Brand Performance
-- Period : All-Time
-- Description : Evaluates brand-level performance using revenue, units sold, gross profit, gross profit margin, and contribution to total company revenue and gross profit.
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
    p.brand,
    round(
        sum(
            pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
        ),
        2
    ) as revenue,
    sum(od.quantity) as units_sold,
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
    ) as gross_profit_margin_percentage,
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
    inner join products p on p.product_id = pv.product_id
group by
    p.brand
order by
    p.brand asc;

-- Metric : Category Performance
-- Period : All-Time
-- Description : Evaluates category-level performance using revenue, units sold, gross profit, gross profit margin, and contribution to total company revenue and gross profit.
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
    p.category,
    round(
        sum(
            pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
        ),
        2
    ) as revenue,
    sum(od.quantity) as units_sold,
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
    ) as gross_profit_margin_percentage,
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
    inner join products p on p.product_id = pv.product_id
group by
    p.category
order by
    p.category asc;
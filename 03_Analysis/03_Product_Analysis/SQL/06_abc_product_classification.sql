-- Metric : ABC Product Classification
-- Period : All-Time
-- Description : Classifies products into A, B, and C groups based on cumulative gross profit contribution, with A representing the highest-importance products, B representing medium-importance products, and C representing the remaining lower-contribution products.
with total_metrics_table as (
    select
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
),
gross_profit_contribution_percentage_table as(
    select
        p.product_id,
        p.product_name,
        round(
            sum(
                (
                    pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                ) -(pv.cost_price * od.quantity)
            ),
            2
        ) as total_gross_profit,
        round(
            (
                (
                    sum(
                        (
                            pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                        ) -(pv.cost_price * od.quantity)
                    )
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
        p.product_id,
        p.product_name
),
cumulative_gross_profit_contribution_table as(
    select
        *,
        sum(gross_profit_contribution_percentage) over(
            order by
                gross_profit_contribution_percentage desc
        ) as cumulative_gross_profit_contribution_percentage
    from
        gross_profit_contribution_percentage_table
)
select
    *,
    case
        when floor(cumulative_gross_profit_contribution_percentage) <= 80 then "A"
        when floor(cumulative_gross_profit_contribution_percentage) > 80
        and floor(cumulative_gross_profit_contribution_percentage) < 95 then "B"
        else "C"
    end as abc_classification
from
    cumulative_gross_profit_contribution_table;
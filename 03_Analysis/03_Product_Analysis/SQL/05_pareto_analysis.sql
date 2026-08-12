-- Metric : Product Revenue Pareto Analysis
-- Period : All-Time
-- Description : Calculates each product's revenue contribution to total company revenue and cumulative revenue contribution to evaluate revenue concentration across the product portfolio.
with total_metrics_table as (
    select
        round(
            sum(
                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
            ),
            2
        ) as total_revenue
    from
        order_details od
        inner join product_variants pv on od.variant_id = pv.variant_id
),
revenue_contribution_percentage_table as(
    select
        p.product_id,
        p.product_name,
        round(
            sum(
                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
            ),
            2
        ) as total_revenue,
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
        ) as revenue_contribution_percentage
    from
        orders o
        inner join order_details od on o.order_id = od.order_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join products p on p.product_id = pv.product_id
    group by
        p.product_id,
        p.product_name
)
select
    *,
    sum(revenue_contribution_percentage) over(
        order by
            revenue_contribution_percentage desc
    ) as cumulative_revenue_contribution_percentage
from
    revenue_contribution_percentage_table
order by
    total_revenue desc;

-- Metric : Product Revenue Pareto Analysis
-- Period : All-Time
-- Description : Calculates the number and percentage of products generating approximately 80% of total company revenue using cumulative product revenue contribution.
with total_metrics_table as (
    select
        round(
            sum(
                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
            ),
            2
        ) as total_revenue
    from
        order_details od
        inner join product_variants pv on od.variant_id = pv.variant_id
),
revenue_contribution_percentage_table as(
    select
        p.product_id,
        p.product_name,
        round(
            sum(
                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
            ),
            2
        ) as total_revenue,
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
        ) as revenue_contribution_percentage
    from
        orders o
        inner join order_details od on o.order_id = od.order_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join products p on p.product_id = pv.product_id
    group by
        p.product_id,
        p.product_name
),
cumulative_revenue_contribution_table as(
    select
        *,
        sum(revenue_contribution_percentage) over(
            order by
                revenue_contribution_percentage desc
        ) as cumulative_revenue_contribution_percentage
    from
        revenue_contribution_percentage_table
)
select
    count(*) as number_of_products_generating_80_percent_revenue,
    round(
        (count(*) * 100) /(
            select
                count(*)
            from
                products
        ),
        2
    ) as percentage_of_products_generating_80_percent_revenue
from
    cumulative_revenue_contribution_table
where
    floor(cumulative_revenue_contribution_percentage) <= 80;

-- Metric : Product Gross Profit Pareto Analysis
-- Period : All-Time
-- Description : Calculates each product's gross profit contribution to total company gross profit and cumulative gross profit contribution to evaluate gross profit concentration across the product portfolio.
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
)
select
    *,
    sum(gross_profit_contribution_percentage) over(
        order by
            gross_profit_contribution_percentage desc
    ) as cumulative_gross_profit_contribution_percentage
from
    gross_profit_contribution_percentage_table
order by
    total_gross_profit desc;

-- Metric : Gross Profit Portfolio Concentration
-- Period : All-Time
-- Description : Calculates the number and percentage of products generating approximately 80% of total company gross profit using cumulative product gross profit contribution.
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
    count(*) as number_of_products_generating_80_percent_gross_profit,
    round(
        (count(*) * 100) /(
            select
                count(*)
            from
                products
        ),
        2
    ) as percentage_of_products_generating_80_percent_gross_profit
from
    cumulative_gross_profit_contribution_table
where
    floor(cumulative_gross_profit_contribution_percentage) <= 80;
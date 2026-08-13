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
    s.state,
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
    inner join stores s on o.store_id = s.store_id
group by
    s.state;

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
    s.city,
    s.state,
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
    inner join stores s on o.store_id = s.store_id
group by
    s.city,
    s.state;

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
    s.region,
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
    inner join stores s on o.store_id = s.store_id
group by
    s.region;

-- Metric : Top 10 Best-Performing Cities
-- Period : All-Time
-- Description : Identifies and ranks the top 10 cities based on total gross profit generated, with cities generating the highest gross profit considered the best performers.
with city_performance_table as(
    select
        s.city,
        s.state,
        s.region,
        round(
            sum(
                (
                    pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                ) -(pv.cost_price * od.quantity)
            ),
            2
        ) as gross_profit,
        rank() over(
            order by
                sum(
                    (
                        pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                    ) -(pv.cost_price * od.quantity)
                ) desc
        ) as best_performance_rank
    from
        orders o
        inner join order_details od on o.order_id = od.order_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join stores s on o.store_id = s.store_id
    group by
        s.city,
        s.state,
        s.region
)
select
    *
from
    city_performance_table
where
    best_performance_rank <= 10;

-- Metric : Top 10 Lowest-Performing Cities
-- Period : All-Time
-- Description : Identifies and ranks the 10 lowest-performing cities based on total gross profit generated, with cities generating the lowest gross profit considered the lowest performers.
with city_performance_table as(
    select
        s.city,
        s.state,
        s.region,
        round(
            sum(
                (
                    pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                ) -(pv.cost_price * od.quantity)
            ),
            2
        ) as gross_profit,
        rank() over(
            order by
                sum(
                    (
                        pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                    ) -(pv.cost_price * od.quantity)
                ) asc
        ) as lowest_performance_rank
    from
        orders o
        inner join order_details od on o.order_id = od.order_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join stores s on o.store_id = s.store_id
    group by
        s.city,
        s.state,
        s.region
)
select
    *
from
    city_performance_table
where
    lowest_performance_rank <= 10;
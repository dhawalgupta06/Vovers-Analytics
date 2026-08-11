with total_metrics_table as(
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
)
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
            sum(
                (
                    pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                ) -(pv.cost_price * od.quantity)
            )
        ) / sum(od.quantity),
        2
    ) as profit_per_unit,
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
    product_id,
    product_name
order by
    product_id asc;

-- Metric : Revenue vs Profitability Performance
-- Period : All-Time
-- Description : Classifies products into four performance categories by comparing each product's revenue and gross profit margin against the average revenue and average gross profit margin across products.
with benchmarks_table as (
    select
        sum(
            pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
        ) / count(distinct p.product_id) as avg_revenue_per_product,
        (
            select
                avg(gross_profit_margin_per_product)
            from
                (
                    select
                        (
                            (
                                sum(
                                    (
                                        pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                                    ) -(pv.cost_price * od.quantity)
                                ) * 100
                            ) / sum(
                                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                            )
                        ) as gross_profit_margin_per_product
                    from
                        orders o
                        inner join order_details od on od.order_id = o.order_id
                        inner join product_variants pv on pv.variant_id = od.variant_id
                        inner join products p on p.product_id = pv.product_id
                    group by
                        p.product_id,
                        p.product_name
                ) as margin_per_product
        ) as avg_gross_profit_margin_per_product
    from
        orders o
        inner join order_details od on od.order_id = o.order_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join products p on p.product_id = pv.product_id
),
product_wise_metrics_table as(
    select
        p.product_id,
        p.product_name,
        round(
            sum(
                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
            ),
            2
        ) as revenue,
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
        ) as gross_profit_margin_percentage
    from
        orders o
        inner join order_details od on od.order_id = o.order_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join products p on p.product_id = pv.product_id
    group by
        p.product_id,
        p.product_name
)
select
    *,
    case
        when revenue >= (
            select
                avg_revenue_per_product
            from
                benchmarks_table
        )
        and gross_profit_margin_percentage >= (
            select
                avg_gross_profit_margin_per_product
            from
                benchmarks_table
        ) then "High Revenue, High Margin"
        when revenue >= (
            select
                avg_revenue_per_product
            from
                benchmarks_table
        )
        and gross_profit_margin_percentage < (
            select
                avg_gross_profit_margin_per_product
            from
                benchmarks_table
        ) then "High Revenue, Low Margin"
        when revenue < (
            select
                avg_revenue_per_product
            from
                benchmarks_table
        )
        and gross_profit_margin_percentage >= (
            select
                avg_gross_profit_margin_per_product
            from
                benchmarks_table
        ) then "Low Revenue, High Margin"
        else "Low Revenue, Low Margin"
    end as categories
from
    product_wise_metrics_table
order by
    categories;

-- Metric : Loss-Making Products
-- Period : All-Time
-- Description : Identifies products that generated negative gross profit after accounting for discounts and product costs.
select
    p.product_id,
    p.product_name,
    round(
        (
            sum(
                (
                    pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                ) -(pv.cost_price * od.quantity)
            )
        ),
        2
    ) as gross_profit
from
    orders o
    inner join order_details od on od.order_id = o.order_id
    inner join product_variants pv on pv.variant_id = od.variant_id
    inner join products p on p.product_id = pv.product_id
group by
    p.product_id,
    p.product_name
having
    gross_profit < 0;
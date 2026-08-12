-- Metric : Product Variant Performance
-- Period : All-Time
-- Description : Evaluates variant-level product performance using revenue, units sold, gross profit, and gross profit margin across product variants.
select
    pv.product_id,
    p.product_name,
    pv.variant_id,
    pv.color,
    pv.storage,
    pv.size,
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
    ) as gross_profit_margin_percentage
from
    orders o
    inner join order_details od on o.order_id = od.order_id
    inner join product_variants pv on pv.variant_id = od.variant_id
    inner join products p on p.product_id = pv.product_id
group by
    pv.product_id,
    p.product_name,
    pv.variant_id,
    pv.color,
    pv.storage,
    pv.size
order by
    pv.product_id asc,
    p.product_name asc;

-- Metric : Variant Performance within Products
-- Period : All-Time
-- Description : Evaluates and ranks product variants within their respective products based on gross profit while displaying revenue, units sold, gross profit, and gross profit margin for performance comparison.
with variant_performance_table as(
    select
        pv.product_id,
        p.product_name,
        pv.variant_id,
        pv.color,
        pv.storage,
        pv.size,
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
        ) as gross_profit_margin_percentage
    from
        orders o
        inner join order_details od on o.order_id = od.order_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join products p on p.product_id = pv.product_id
    group by
        pv.product_id,
        p.product_name,
        pv.variant_id,
        pv.color,
        pv.storage,
        pv.size
)
select
    *,
    rank() over(
        partition by product_id
        order by
            gross_profit desc
    ) as variant_performance_rank
from
    variant_performance_table
order by
    product_id,
    product_name asc;
-- Metric : Units Requested for Return by Product Variant
-- Period : All-Time
-- Description : Calculates the total quantity of units requested for return for each Product Variant while displaying the associated product and variant attributes for identification.
select
    pv.variant_id,
    p.product_id,
    p.product_name,
    pv.color,
    pv.size,
    pv.storage,
    sum(r.returned_quantity) as units_requested_for_return
from
    returns r
    inner join order_details od on od.order_detail_id = r.order_detail_id
    inner join product_variants pv on pv.variant_id = od.variant_id
    inner join products p on p.product_id = pv.product_id
group by
    pv.variant_id,
    p.product_id,
    p.product_name,
    pv.color,
    pv.size,
    pv.storage
order by
    p.product_id asc,
    variant_id asc;

-- Metric : Return Request Rate % by Product Variant
-- Period : All-Time
-- Description : Calculates the percentage of units sold for each Product Variant that were subsequently requested for return.
with variant_returns_table as(
    select
        pv.variant_id,
        p.product_id,
        p.product_name,
        pv.color,
        pv.size,
        pv.storage,
        sum(r.returned_quantity) as units_requested_for_return,
        (
            select
                total_units_sold
            from
                (
                    select
                        variant_id,
                        sum(quantity) as total_units_sold
                    from
                        order_details
                    group by
                        variant_id
                ) as total_units_sold_table
            where
                variant_id = pv.variant_id
        ) as total_units_sold
    from
        returns r
        inner join order_details od on od.order_detail_id = r.order_detail_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join products p on p.product_id = pv.product_id
    group by
        pv.variant_id,
        p.product_id,
        p.product_name,
        pv.color,
        pv.size,
        pv.storage
)
select
    *,
    round(
        (units_requested_for_return * 100) / total_units_sold,
        2
    ) as return_request_rate_percentage
from
    variant_returns_table
order by
    product_id,
    variant_id;

-- Metric : Estimated Requested Return Value by Product Variant
-- Period : All-Time
-- Description : Calculates the estimated value of units requested for return for each Product Variant using the original selling price and discount percentage of the associated order detail.
select
    pv.variant_id,
    p.product_id,
    p.product_name,
    pv.color,
    pv.size,
    pv.storage,
    round(
        sum(
            r.returned_quantity * pv.selling_price * (1 - (od.discount_percentage / 100))
        ),
        2
    ) as estimated_requested_return_value
from
    returns r
    inner join order_details od on od.order_detail_id = r.order_detail_id
    inner join product_variants pv on pv.variant_id = od.variant_id
    inner join products p on p.product_id = pv.product_id
group by
    pv.variant_id,
    p.product_id,
    p.product_name,
    pv.color,
    pv.size,
    pv.storage
order by
    p.product_id asc,
    pv.variant_id asc;
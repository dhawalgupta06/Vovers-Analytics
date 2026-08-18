-- Metric : Units Requested for Return by Category
-- Period : All-Time
-- Description : Calculates the total quantity of units requested for return for each product category while retaining categories with no return requests.

select
p.category,
coalesce(sum(r.returned_quantity), 0) as units_requested_for_return
from products p
left join product_variants pv
    on p.product_id = pv.product_id
left join order_details od
    on od.variant_id = pv.variant_id
left join returns r
    on od.order_detail_id = r.order_detail_id
group by
p.category
order by
units_requested_for_return desc;

-- Metric : Return Request Rate % by Category
-- Period : All-Time
-- Description : Calculates the percentage of units sold within each product category that were subsequently requested for return.

with category_units_table as (
select
p.category,
coalesce(sum(r.returned_quantity),0) as units_requested_for_return,
(
    select sold_units
    from (
        select
        p.category,
        sum(od.quantity) as sold_units
        from order_details od
        inner join product_variants pv
            on pv.variant_id = od.variant_id
        inner join products p
            on p.product_id = pv.product_id
        group by p.category
    ) as sold_units_table
    where category = p.category
) as total_units_sold
from products p
left join product_variants pv
    on p.product_id = pv.product_id
left join order_details od
    on od.variant_id = pv.variant_id
left join returns r
    on od.order_detail_id = r.order_detail_id
group by p.category
)

select *,
round(
    (units_requested_for_return * 100) / total_units_sold,
    2
) as return_request_rate_percentage
from category_units_table
order by units_requested_for_return desc;

-- Metric : Estimated Requested Return Value by Category
-- Period : All-Time
-- Description : Calculates the estimated value of units requested for return within each product category using the original selling price and discount percentage of the associated order detail.

select
p.category,
round(
    coalesce(
        sum(
            r.returned_quantity
            * pv.selling_price
            * (1 - (od.discount_percentage / 100))
        ),
        0
    ),
    2
) as estimated_returns_requested_value
from products p
left join product_variants pv
    on p.product_id = pv.product_id
left join order_details od
    on od.variant_id = pv.variant_id
left join returns r
    on od.order_detail_id = r.order_detail_id
group by
p.category
order by
estimated_returns_requested_value desc;

-- Metric : Units Requested for Return by Product
-- Period : All-Time
-- Description : Calculates the total quantity of units requested for return for each product while retaining products with no return requests.

select
p.product_id,
p.product_name,
coalesce(sum(r.returned_quantity), 0) as units_requested_for_return
from products p
left join product_variants pv
    on p.product_id = pv.product_id
left join order_details od
    on od.variant_id = pv.variant_id
left join returns r
    on od.order_detail_id = r.order_detail_id
group by
p.product_id,
p.product_name
order by
units_requested_for_return desc;

-- Metric : Return Request Rate % by Product
-- Period : All-Time
-- Description : Calculates the percentage of units sold for each product that were subsequently requested for return.

with product_units_table as (
select
p.product_id,
p.product_name,
coalesce(sum(r.returned_quantity),0) as units_requested_for_return,
(
    select sold_units
    from (
        select
        p.product_id,
        p.product_name,
        sum(od.quantity) as sold_units
        from order_details od
        inner join product_variants pv
            on pv.variant_id = od.variant_id
        inner join products p
            on p.product_id = pv.product_id
        group by
        p.product_id,
        p.product_name
    ) as sold_units_table
    where product_id = p.product_id
) as total_units_sold
from products p
left join product_variants pv
    on p.product_id = pv.product_id
left join order_details od
    on od.variant_id = pv.variant_id
left join returns r
    on od.order_detail_id = r.order_detail_id
group by
p.product_id,
p.product_name
)

select *,
round(
    (units_requested_for_return * 100) / total_units_sold,
    2
) as return_request_rate_percentage
from product_units_table
order by units_requested_for_return desc;

-- Metric : Estimated Requested Return Value by Product
-- Period : All-Time
-- Description : Calculates the estimated value of units requested for return for each product using the original selling price and discount percentage of the associated order detail.

select
p.product_id,
p.product_name,
round(
    coalesce(
        sum(
            r.returned_quantity
            * pv.selling_price
            * (1 - (od.discount_percentage / 100))
        ),
        0
    ),
    2
) as estimated_returns_requested_value
from products p
left join product_variants pv
    on p.product_id = pv.product_id
left join order_details od
    on od.variant_id = pv.variant_id
left join returns r
    on od.order_detail_id = r.order_detail_id
group by
p.product_id,
p.product_name
order by
estimated_returns_requested_value desc;
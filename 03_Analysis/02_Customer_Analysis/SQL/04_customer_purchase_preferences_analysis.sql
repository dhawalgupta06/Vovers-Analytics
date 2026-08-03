-- Metric : Preferred Product
-- Period : Customer Lifetime
-- Description : Identifies the product(s) purchased most frequently by each customer during their lifetime.
with customer_product_purchase_table as (
    select
        c.customer_id,
        c.customer_name,
        p.product_id,
        p.product_name,
        count(p.product_id) as time_purchased,
        rank() over (
            partition by c.customer_id
            order by
                count(p.product_id) desc
        ) as ranks
    from
        orders o
        inner join customers c on c.customer_id = o.customer_id
        inner join order_details od on o.order_id = od.order_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join products p on p.product_id = pv.product_id
    group by
        c.customer_id,
        c.customer_name,
        p.product_id,
        p.product_name
)
select
    customer_id,
    customer_name,
    product_name as preferred_product,
    time_purchased
from
    customer_product_purchase_table
where
    ranks = 1
order by
    time_purchased desc;

-- Metric : Preferred Category
-- Period : Customer Lifetime
-- Description : Identifies the product category or categories purchased most frequently by each customer during their lifetime.
with customer_category_purchase_table as (
    select
        c.customer_id,
        c.customer_name,
        p.category,
        count(p.product_id) as times_purchased,
        rank() over (
            partition by c.customer_id
            order by
                count(p.product_id) desc
        ) as category_rank
    from
        orders as o
        inner join customers as c on c.customer_id = o.customer_id
        inner join order_details as od on o.order_id = od.order_id
        inner join product_variants as pv on pv.variant_id = od.variant_id
        inner join products as p on p.product_id = pv.product_id
    group by
        c.customer_id,
        c.customer_name,
        p.category
)
select
    customer_id,
    customer_name,
    category as preferred_category,
    times_purchased
from
    customer_category_purchase_table
where
    category_rank = 1
order by
    times_purchased desc;

-- Metric : Preferred Brand
-- Period : Customer Lifetime
-- Description : Identifies the product brand or brands purchased most frequently by each customer during their lifetime.
with customer_brand_purchase_table as (
    select
        c.customer_id,
        c.customer_name,
        p.brand,
        count(p.product_id) as times_purchased,
        rank() over (
            partition by c.customer_id
            order by
                count(p.product_id) desc
        ) as brand_rank
    from
        orders as o
        inner join customers as c on c.customer_id = o.customer_id
        inner join order_details as od on o.order_id = od.order_id
        inner join product_variants as pv on pv.variant_id = od.variant_id
        inner join products as p on p.product_id = pv.product_id
    group by
        c.customer_id,
        c.customer_name,
        p.brand
)
select
    customer_id,
    customer_name,
    brand as preferred_brand,
    times_purchased
from
    customer_brand_purchase_table
where
    brand_rank = 1
order by
    times_purchased desc;

-- Metric : Preferred Sales Channel
-- Period : Customer Lifetime
-- Description : Identifies the sales channel or channels used most frequently by each customer during their lifetime.
with customer_sales_channel_purchase_table as (
    select
        c.customer_id,
        c.customer_name,
        o.sales_channel,
        count(o.order_id) as times_used,
        rank() over (
            partition by c.customer_id
            order by
                count(o.order_id) desc
        ) as sales_channel_rank
    from
        orders as o
        inner join customers as c on c.customer_id = o.customer_id
    group by
        c.customer_id,
        c.customer_name,
        o.sales_channel
)
select
    customer_id,
    customer_name,
    sales_channel as preferred_sales_channel,
    times_used
from
    customer_sales_channel_purchase_table
where
    sales_channel_rank = 1
order by
    times_used desc;

-- Metric : Preferred Payment Method
-- Period : Customer Lifetime
-- Description : Identifies the payment method or methods used most frequently by each customer during their lifetime.
with customer_payment_method_purchase_table as (
    select
        c.customer_id,
        c.customer_name,
        o.payment_method,
        count(o.order_id) as times_used,
        rank() over (
            partition by c.customer_id
            order by
                count(o.order_id) desc
        ) as payment_method_rank
    from
        orders as o
        inner join customers as c on c.customer_id = o.customer_id
    group by
        c.customer_id,
        c.customer_name,
        o.payment_method
)
select
    customer_id,
    customer_name,
    payment_method as preferred_payment_method,
    times_used
from
    customer_payment_method_purchase_table
where
    payment_method_rank = 1
order by
    times_used desc;
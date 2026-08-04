-- Dataset : Customer Analytics Dataset
-- Grain : One Row per Purchasing Customer
-- Description : Creates an analysis-ready customer dataset containing customer
-- demographics, lifetime purchasing metrics, purchase preferences, financial
-- contribution, and repeat-purchase status for Python-based loyalty analysis.

select
    c.customer_id,
    c.customer_name,
    c.gender,
    c.age,
    c.city,
    c.state,
    c.region,
    c.join_date,

    min(date(o.order_datetime)) as first_purchase_date,
    max(date(o.order_datetime)) as latest_purchase_date,

    count(distinct o.order_id) as customer_lifetime_orders,

    round(
        sum(
            pv.selling_price
            * od.quantity
            * (1 - coalesce(od.discount_percentage, 0) / 100)
        ),
        2
    ) as customer_lifetime_revenue,

    round(
        sum(
            (
                pv.selling_price
                * od.quantity
                * (1 - coalesce(od.discount_percentage, 0) / 100)
            )
            - (pv.cost_price * od.quantity)
        ),
        2
    ) as customer_lifetime_profit,

    round(
        sum(
            pv.selling_price
            * od.quantity
            * (1 - coalesce(od.discount_percentage, 0) / 100)
        )
        / count(distinct o.order_id),
        2
    ) as average_order_value,

    (
        with customer_product_purchase_table as (
            select
                c.customer_id,
                p.product_id,
                p.product_name,
                count(p.product_id) as times_purchased,
                row_number() over (
                    partition by c.customer_id
                    order by
                        count(p.product_id) desc,
                        p.product_id asc
                ) as product_rank
            from
                orders as o
                inner join customers as c
                    on c.customer_id = o.customer_id
                inner join order_details as od
                    on o.order_id = od.order_id
                inner join product_variants as pv
                    on pv.variant_id = od.variant_id
                inner join products as p
                    on p.product_id = pv.product_id
            group by
                c.customer_id,
                p.product_id,
                p.product_name
        )
        select
            product_name
        from
            customer_product_purchase_table
        where
            customer_id = c.customer_id
            and product_rank = 1
    ) as preferred_product,

    (
        with customer_category_purchase_table as (
            select
                c.customer_id,
                p.category,
                count(p.product_id) as times_purchased,
                row_number() over (
                    partition by c.customer_id
                    order by
                        count(p.product_id) desc,
                        p.category asc
                ) as category_rank
            from
                orders as o
                inner join customers as c
                    on c.customer_id = o.customer_id
                inner join order_details as od
                    on o.order_id = od.order_id
                inner join product_variants as pv
                    on pv.variant_id = od.variant_id
                inner join products as p
                    on p.product_id = pv.product_id
            group by
                c.customer_id,
                p.category
        )
        select
            category
        from
            customer_category_purchase_table
        where
            customer_id = c.customer_id
            and category_rank = 1
    ) as preferred_category,

    (
        with customer_brand_purchase_table as (
            select
                c.customer_id,
                p.brand,
                count(p.product_id) as times_purchased,
                row_number() over (
                    partition by c.customer_id
                    order by
                        count(p.product_id) desc,
                        p.brand asc
                ) as brand_rank
            from
                orders as o
                inner join customers as c
                    on c.customer_id = o.customer_id
                inner join order_details as od
                    on o.order_id = od.order_id
                inner join product_variants as pv
                    on pv.variant_id = od.variant_id
                inner join products as p
                    on p.product_id = pv.product_id
            group by
                c.customer_id,
                p.brand
        )
        select
            brand
        from
            customer_brand_purchase_table
        where
            customer_id = c.customer_id
            and brand_rank = 1
    ) as preferred_brand,

    (
        with customer_sales_channel_purchase_table as (
            select
                c.customer_id,
                o.sales_channel,
                count(o.order_id) as times_used,
                row_number() over (
                    partition by c.customer_id
                    order by
                        count(o.order_id) desc,
                        o.sales_channel asc
                ) as sales_channel_rank
            from
                orders as o
                inner join customers as c
                    on c.customer_id = o.customer_id
            group by
                c.customer_id,
                o.sales_channel
        )
        select
            sales_channel
        from
            customer_sales_channel_purchase_table
        where
            customer_id = c.customer_id
            and sales_channel_rank = 1
    ) as preferred_sales_channel,

    (
        with customer_payment_method_purchase_table as (
            select
                c.customer_id,
                o.payment_method,
                count(o.order_id) as times_used,
                row_number() over (
                    partition by c.customer_id
                    order by
                        count(o.order_id) desc,
                        o.payment_method asc
                ) as payment_method_rank
            from
                orders as o
                inner join customers as c
                    on c.customer_id = o.customer_id
            group by
                c.customer_id,
                o.payment_method
        )
        select
            payment_method
        from
            customer_payment_method_purchase_table
        where
            customer_id = c.customer_id
            and payment_method_rank = 1
    ) as preferred_payment_method,

    round(
        (
            sum(
                pv.selling_price
                * od.quantity
                * (1 - coalesce(od.discount_percentage, 0) / 100)
            ) * 100
        )
        /
        (
            select
                sum(
                    pv.selling_price
                    * od.quantity
                    * (1 - coalesce(od.discount_percentage, 0) / 100)
                )
            from
                product_variants as pv
                inner join order_details as od
                    on pv.variant_id = od.variant_id
                inner join orders as o
                    on o.order_id = od.order_id
        ),
        4
    ) as customer_revenue_contribution_percentage,

    round(
        (
            sum(
                (
                    pv.selling_price
                    * od.quantity
                    * (1 - coalesce(od.discount_percentage, 0) / 100)
                )
                - (pv.cost_price * od.quantity)
            ) * 100
        )
        /
        (
            select
                sum(
                    (
                        pv.selling_price
                        * od.quantity
                        * (1 - coalesce(od.discount_percentage, 0) / 100)
                    )
                    - (pv.cost_price * od.quantity)
                )
            from
                product_variants as pv
                inner join order_details as od
                    on pv.variant_id = od.variant_id
                inner join orders as o
                    on o.order_id = od.order_id
        ),
        4
    ) as customer_gross_profit_contribution_percentage,

    if(
        count(distinct o.order_id) > 1,
        'Yes',
        'No'
    ) as is_repeat_customer

from
    customers as c
    inner join orders as o
        on c.customer_id = o.customer_id
    inner join order_details as od
        on od.order_id = o.order_id
    inner join product_variants as pv
        on pv.variant_id = od.variant_id

group by
    c.customer_id,
    c.customer_name,
    c.gender,
    c.age,
    c.city,
    c.state,
    c.region,
    c.join_date

order by
    c.customer_id;
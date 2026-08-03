-- Metric : Total Orders per Customer
-- Period : Customer Lifetime
-- Description : Calculates the total number of orders placed by each customer.
select
    c.customer_id,
    c.customer_name,
    count(o.order_id) as total_orders
from
    orders as o
    inner join customers as c on o.customer_id = c.customer_id
group by
    c.customer_id,
    c.customer_name
order by
    total_orders desc;

-- Metric : Average Orders per Customer
-- Period : Customer Lifetime
-- Description : Calculates the average number of orders placed by each purchasing customer over their lifetime.
select
    round(
        count(order_id) / count(distinct customer_id),
        2
    ) as average_orders_per_customer
from
    orders;

-- Metric : Repeat Customers
-- Period : Customer Lifetime
-- Description : Identifies customers who have placed more than one order during their lifetime.
select
    c.customer_id,
    c.customer_name,
    count(o.order_id) as total_orders
from
    customers as c
    inner join orders as o on c.customer_id = o.customer_id
group by
    c.customer_id,
    c.customer_name
having
    total_orders > 1
order by
    total_orders desc,
    c.customer_name asc;

-- Metric : One-Time Customers
-- Period : Customer Lifetime
-- Description : Identifies customers who have placed exactly one order during their lifetime.
select
    c.customer_id,
    c.customer_name,
    count(o.order_id) as total_orders
from
    customers as c
    inner join orders as o on c.customer_id = o.customer_id
group by
    c.customer_id,
    c.customer_name
having
    total_orders = 1
order by
    c.customer_name asc;

-- Metric : Repeat Purchase Rate
-- Period : Customer Lifetime
-- Description : Calculates the percentage of purchasing customers who placed more than one order during their lifetime.
select
    round(
        (
            (
                select
                    count(customer_id)
                from
                    (
                        select
                            customer_id,
                            count(order_id) as total_orders
                        from
                            orders
                        group by
                            customer_id
                        having
                            total_orders > 1
                    ) as repeat_customers_table
            ) / count(distinct customer_id)
        ) * 100,
        2
    ) as repeat_purchase_rate_percentage
from
    orders;

-- Metric : Average Days Between Purchases
-- Period : Customer Lifetime
-- Description : Calculates the average number of days between consecutive purchases for each repeat customer during their lifetime.
with customer_purchase_gap_table as (
    select
        c.customer_id,
        c.customer_name,
        min(o.order_datetime) as first_purchase_date,
        max(o.order_datetime) as last_purchase_date,
        timestampdiff(
            day,
            min(o.order_datetime),
            max(o.order_datetime)
        ) as purchase_gap,
        count(o.order_id) as total_orders
    from
        orders o
        inner join customers c on c.customer_id = o.customer_id
    group by
        c.customer_id,
        c.customer_name
    having
        count(o.order_id) > 1
)
select
    customer_id,
    customer_name,
    round(purchase_gap / (total_orders - 1), 2) as average_days_between_purchases
from
    customer_purchase_gap_table;

-- Metric : First Purchase Date
-- Period : Customer Lifetime
-- Description : Identifies the date on which each customer made their first purchase.
select
    c.customer_id,
    c.customer_name,
    min(date(o.order_datetime)) as first_purchase_date
from
    customers c
    inner join orders o on c.customer_id = o.customer_id
group by
    c.customer_id,
    c.customer_name;

-- Metric : Latest Purchase Date
-- Period : Customer Lifetime
-- Description : Identifies the date on which each customer made their most recent purchase.
select
    c.customer_id,
    c.customer_name,
    max(date(o.order_datetime)) as latest_purchase_date
from
    customers c
    inner join orders o on c.customer_id = o.customer_id
group by
    c.customer_id,
    c.customer_name;
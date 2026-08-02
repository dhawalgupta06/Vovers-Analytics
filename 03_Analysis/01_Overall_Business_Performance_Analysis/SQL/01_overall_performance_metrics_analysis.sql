
-- Metric: Total Revenue
-- Period: All Available Data
-- Description: Calculates total revenue after item-level discounts.

select
    round(
        sum(
            pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
        ),
        2
    ) as total_revenue
from
    product_variants as pv
    inner join order_details as od on pv.variant_id = od.variant_id;


-- Metric: Gross Profit
-- Period: All Available Data
-- Description: Calculates gross profit by subtracting the cost of goods sold from discounted revenue.

select
    round(
        sum(
            (
                pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
            ) - (
                pv.cost_price * od.quantity
            )
        ),
        2
    ) as gross_profit
from
    product_variants as pv
    inner join order_details as od on pv.variant_id = od.variant_id;
    

-- Metric: Gross Profit Margin
-- Period: All Available Data
-- Description: Calculates gross profit as a percentage of total revenue.

select
    round(
        (
            sum(
                (
                    pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
                ) - (
                    pv.cost_price * od.quantity
                )
            ) / nullif(
                sum(
                    pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
                ),
                0
            )
        ) * 100,
        2
    ) as gross_profit_margin
from
    product_variants as pv
    inner join order_details as od on pv.variant_id = od.variant_id;


-- Metric: Total Orders
-- Period: All Available Data
-- Description: Calculates the total number of orders placed.

select
    count(order_id) as total_orders
from
    orders;


-- Metric: Average Order Value
-- Period: All Available Data
-- Description: Calculates the average revenue generated per order.

select
    round(
        sum(
            pv.selling_price * od.quantity * (1 - coalesce(od.discount_percentage, 0) / 100)
        ) / 
            count(distinct od.order_id)
        ,
        2)
     as average_order_value
from
    order_details as od
    inner join product_variants as pv on od.variant_id = pv.variant_id;

-- Metric: Total Customers
-- Period: All Available Data
-- Description: Calculates the total number of unique customers who have placed at least one order.

select
    count(distinct customer_id) as total_customers
from
    orders;

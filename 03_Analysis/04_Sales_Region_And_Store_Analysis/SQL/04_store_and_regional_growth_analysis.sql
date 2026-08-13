-- Metric : YoY State Revenue Growth
-- Period : 2023–2025
-- Description : Calculates annual revenue for each state and compares it with the previous year's revenue to measure year-over-year revenue growth across geographic markets.
with revenue_comparison_table as(
    select
        s.state,
        year(o.order_datetime) as order_year,
        round(
            sum(
                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
            ),
            2
        ) as current_year_revenue,
        round(
            lag(
                sum(
                    pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                )
            ) over(
                partition by s.state
                order by
                    year(o.order_datetime) asc
            ),
            2
        ) as previous_year_revenue
    from
        orders o
        inner join order_details od on o.order_id = od.order_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join stores s on o.store_id = s.store_id
    where
        o.order_datetime >= '2023-01-01'
        and o.order_datetime < '2026-01-01'
    group by
        s.state,
        year(o.order_datetime)
)
select
    *,
    round(
        ((current_year_revenue - previous_year_revenue) * 100) / previous_year_revenue,
        2
    ) as revenue_growth_percentage
from
    revenue_comparison_table;

-- Metric : YoY Regional Revenue Growth
-- Period : 2023–2025
-- Description : Calculates annual revenue for each region and compares it with the previous year's revenue to measure year-over-year revenue growth across geographic regions.
with revenue_comparison_table as(
    select
        s.region,
        year(o.order_datetime) as order_year,
        round(
            sum(
                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
            ),
            2
        ) as current_year_revenue,
        round(
            lag(
                sum(
                    pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                )
            ) over(
                partition by s.region
                order by
                    year(o.order_datetime) asc
            ),
            2
        ) as previous_year_revenue
    from
        orders o
        inner join order_details od on o.order_id = od.order_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join stores s on o.store_id = s.store_id
    where
        o.order_datetime >= '2023-01-01'
        and o.order_datetime < '2026-01-01'
    group by
        s.region,
        year(o.order_datetime)
)
select
    *,
    round(
        ((current_year_revenue - previous_year_revenue) * 100) / previous_year_revenue,
        2
    ) as revenue_growth_percentage
from
    revenue_comparison_table;

-- Metric : Average State Revenue Growth
-- Period : 2023–2025
-- Description : Calculates the average YoY revenue growth for each state across the past 3 completed years to identify geographic markets with sustained growth or decline.
with revenue_comparison_table as(
    select
        s.state,
        year(o.order_datetime) as order_year,
        round(
            sum(
                pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
            ),
            2
        ) as current_year_revenue,
        round(
            lag(
                sum(
                    pv.selling_price * od.quantity *(1 -(od.discount_percentage / 100))
                )
            ) over(
                partition by s.state
                order by
                    year(o.order_datetime) asc
            ),
            2
        ) as previous_year_revenue
    from
        orders o
        inner join order_details od on o.order_id = od.order_id
        inner join product_variants pv on pv.variant_id = od.variant_id
        inner join stores s on o.store_id = s.store_id
    where
        o.order_datetime >= '2023-01-01'
        and o.order_datetime < '2026-01-01'
    group by
        s.state,
        year(o.order_datetime)
),
state_revenue_growth_percentage_table as(
    select
        *,
        round(
            ((current_year_revenue - previous_year_revenue) * 100) / previous_year_revenue,
            2
        ) as revenue_growth_percentage
    from
        revenue_comparison_table
)
select
    state,
    round(avg(revenue_growth_percentage), 2) as avg_growth_percentage
from
    state_revenue_growth_percentage_table
group by
    state;

    -- Metric : YoY Store Revenue Growth
-- Period : 2023–2025
-- Description : Calculates annual revenue for each store and compares it with the previous year's revenue to measure year-over-year store revenue growth.

with revenue_comparison_table as(select 
s.store_id,
s.city,
s.state, 
s.region,
s.store_type,
year(o.order_datetime) as order_year,
round(sum(pv.selling_price*od.quantity*(1-(od.discount_percentage/100))),2) as current_year_revenue,
round(lag(sum(pv.selling_price*od.quantity*(1-(od.discount_percentage/100)))) over(partition by s.store_id order by year(o.order_datetime) asc),2) as previous_year_revenue
from 
orders o
    inner join order_details od on o.order_id = od.order_id
    inner join product_variants pv on pv.variant_id = od.variant_id
    inner join stores s on o.store_id = s.store_id
    where o.order_datetime >= '2023-01-01' and o.order_datetime < '2026-01-01'
    group by s.store_id ,s.city,
s.state, 
s.region,
s.store_type,year(o.order_datetime)
    )
    select * 
    , round(((current_year_revenue-previous_year_revenue)*100)/previous_year_revenue,2) as revenue_growth_percentage from revenue_comparison_table;

    -- Metric : YoY Store Gross Profit Growth
-- Period : 2023–2025
-- Description : Calculates annual gross profit for each store and compares it with the previous year's gross profit to measure year-over-year store gross profit growth.

with gross_profit_comparison_table as(select 
s.store_id,
s.city,
s.state, 
s.region,
s.store_type,
year(o.order_datetime) as order_year,
round(sum((pv.selling_price*od.quantity*(1-(od.discount_percentage/100)))-(pv.cost_price * od.quantity)),2) as current_year_gross_profit,
round(lag(sum((pv.selling_price*od.quantity*(1-(od.discount_percentage/100)))-(pv.cost_price * od.quantity))) over(partition by s.store_id order by year(o.order_datetime) asc),2) as previous_year_gross_profit
from 
orders o
    inner join order_details od on o.order_id = od.order_id
    inner join product_variants pv on pv.variant_id = od.variant_id
    inner join stores s on o.store_id = s.store_id
    where o.order_datetime >= '2023-01-01' and o.order_datetime < '2026-01-01'
    group by s.store_id ,s.city,
s.state, 
s.region,
s.store_type,year(o.order_datetime)
    )
    select * 
    , round(((current_year_gross_profit-previous_year_gross_profit)*100)/previous_year_gross_profit,2) as gross_profit_growth_percentage from gross_profit_comparison_table;
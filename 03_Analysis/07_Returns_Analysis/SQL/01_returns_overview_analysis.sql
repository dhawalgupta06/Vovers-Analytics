-- Metric : Total Return Requests
-- Period : All-Time
-- Description : Calculates the total number of return requests recorded across all customer orders.
select
    count(*) as total_return_requests
from
    returns;

-- Metric : Units Requested for Return
-- Period : All-Time
-- Description : Calculates the total quantity of units requested for return across all return requests regardless of their final return status.
select
    sum(returned_quantity) as units_requested_for_return
from
    returns;

-- Metric : Return Request Rate %
-- Period : All-Time
-- Description : Calculates the percentage of total units sold that were subsequently requested for return across all customer orders.
select
    round(
        (sum(returned_quantity) * 100) / (
            select
                sum(quantity)
            from
                order_details
        ),
        2
    ) as return_request_rate_percentage
from
    returns;

-- Metric : Estimated Requested Return Value
-- Period : All-Time
-- Description : Estimates the total value of units requested for return using the original Product Variant selling price and discount percentage recorded on the associated order detail.
select
    round(
        sum(
            r.returned_quantity * pv.selling_price * (1 - (coalesce(od.discount_percentage, 0) / 100))
        ),
        2
    ) as estimated_requested_return_value
from
    returns r
    inner join order_details od on r.order_detail_id = od.order_detail_id
    inner join product_variants pv on pv.variant_id = od.variant_id;

-- Metric : Average Units per Return Request
-- Period : All-Time
-- Description : Calculates the average number of units requested for return per return request across all customer orders.
select
    round(
        sum(returned_quantity) / count(return_id),
        2
    ) as avg_units_per_return_request
from
    returns;

    -- Metric : Return Requests by Return Status
-- Period : All-Time
-- Description : Calculates the number of return requests recorded under each return status to understand the overall distribution of return outcomes.

select
return_status,
count(return_id) as number_of_requests
from returns
group by return_status;

-- Metric : Return Status Contribution %
-- Period : All-Time
-- Description : Calculates the percentage contribution of each return status to total return requests to understand the distribution of return outcomes.

select
return_status,
count(return_id) as number_of_requests,
round(
    (count(return_id) * 100) /
    (select count(*) from returns),
    2
) as contribution_percentage
from returns
group by return_status
order by contribution_percentage desc;
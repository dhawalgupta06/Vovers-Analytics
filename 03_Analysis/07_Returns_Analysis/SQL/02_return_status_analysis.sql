-- Metric : Units Requested for Return by Return Status
-- Period : All-Time
-- Description : Calculates the total quantity of units requested for return under each return status to measure quantity exposure across return outcomes.

select
return_status,
sum(returned_quantity) as units_requested
from returns
group by return_status
order by units_requested desc;

-- Metric : Estimated Requested Return Value by Return Status
-- Period : All-Time
-- Description : Calculates the estimated value of units requested for return under each return status using the original selling price and discount percentage of the associated order detail.

select
r.return_status,
round(
    sum(
        r.returned_quantity
        * pv.selling_price
        * (1 - (od.discount_percentage / 100))
    ),
    2
) as estimated_return_request_value
from returns r
inner join order_details od
    on r.order_detail_id = od.order_detail_id
inner join product_variants pv
    on pv.variant_id = od.variant_id
group by r.return_status
order by estimated_return_request_value desc;

-- Metric : Units Requested Contribution % by Return Status
-- Period : All-Time
-- Description : Calculates each return status's contribution to total units requested for return to measure the quantity distribution across return outcomes.

select
return_status,
sum(returned_quantity) as units_requested,
round(
    (sum(returned_quantity) * 100) /
    (select sum(returned_quantity) from returns),
    2
) as units_requested_contribution_percentage
from returns
group by return_status
order by units_requested_contribution_percentage desc;

-- Metric : Estimated Requested Return Value Contribution % by Return Status
-- Period : All-Time
-- Description : Calculates each return status's contribution to total estimated requested return value using the original selling price and discount percentage of the associated order detail.

select
r.return_status,
round(
    sum(
        r.returned_quantity
        * pv.selling_price
        * (1 - (od.discount_percentage / 100))
    ),
    2
) as estimated_return_request_value,
round(
    (
        sum(
            r.returned_quantity
            * pv.selling_price
            * (1 - (od.discount_percentage / 100))
        ) * 100
    ) /
    (
        select
        sum(
            r.returned_quantity
            * pv.selling_price
            * (1 - (od.discount_percentage / 100))
        )
        from returns r
        inner join order_details od
            on r.order_detail_id = od.order_detail_id
        inner join product_variants pv
            on pv.variant_id = od.variant_id
    ),
    2
) as estimated_return_request_value_contribution_percentage
from returns r
inner join order_details od
    on r.order_detail_id = od.order_detail_id
inner join product_variants pv
    on pv.variant_id = od.variant_id
group by r.return_status
order by estimated_return_request_value desc;
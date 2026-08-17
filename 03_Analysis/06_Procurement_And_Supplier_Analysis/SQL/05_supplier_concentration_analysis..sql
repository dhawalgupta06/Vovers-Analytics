-- Metric : Cumulative Supplier Procurement Contribution %
-- Period : All-Time
-- Description : Calculates each supplier's contribution to total estimated procurement value and the cumulative contribution percentage to evaluate supplier concentration.

with estimated_procurement_value_table as(
    select
        s.supplier_id,
        s.supplier_name,
        round(
            sum(pod.quantity * pv.cost_price),
            2
        ) as estimated_procurement_value
    from
        purchase_orders po
        inner join purchase_order_details pod on po.purchase_order_id = pod.purchase_order_id
        inner join product_variants pv on pv.variant_id = pod.variant_id
        inner join suppliers s on s.supplier_id = po.supplier_id
    group by
        s.supplier_id,
        s.supplier_name
),
supplier_contribution_table as(
    select
        *,
        round(
            (estimated_procurement_value * 100) / (
                select
                    sum(pod.quantity * pv.cost_price)
                from
                    purchase_order_details pod
                    inner join product_variants pv on pv.variant_id = pod.variant_id
            ),
            2
        ) as estimated_procurement_value_contribution
    from
        estimated_procurement_value_table
)
select
    *,
    sum(estimated_procurement_value_contribution) over(
        order by estimated_procurement_value_contribution desc
    ) as cumulative_procurement_contribution
from
    supplier_contribution_table
order by
    estimated_procurement_value_contribution desc;

    -- Metric : Suppliers Accounting for Approximately 80% of Procurement
-- Period : All-Time
-- Description : Identifies the suppliers whose cumulative contribution accounts for approximately 80% of total estimated procurement value to evaluate supplier concentration and dependency.

with estimated_procurement_value_table as(
    select
        s.supplier_id,
        s.supplier_name,
        round(
            sum(pod.quantity * pv.cost_price),
            2
        ) as estimated_procurement_value
    from
        purchase_orders po
        inner join purchase_order_details pod on po.purchase_order_id = pod.purchase_order_id
        inner join product_variants pv on pv.variant_id = pod.variant_id
        inner join suppliers s on s.supplier_id = po.supplier_id
    group by
        s.supplier_id,
        s.supplier_name
),
supplier_contribution_table as(
    select
        *,
        round(
            (estimated_procurement_value * 100) / (
                select
                    sum(pod.quantity * pv.cost_price)
                from
                    purchase_order_details pod
                    inner join product_variants pv on pv.variant_id = pod.variant_id
            ),
            2
        ) as estimated_procurement_value_contribution
    from
        estimated_procurement_value_table
),
cumulative_procurement_contribution_table as(
select
    *,
    sum(estimated_procurement_value_contribution) over(
        order by estimated_procurement_value_contribution desc
    ) as cumulative_procurement_contribution
from
    supplier_contribution_table
order by
    estimated_procurement_value_contribution desc
)
select *
from cumulative_procurement_contribution_table
where floor(cumulative_procurement_contribution) <= 80;

-- Metric : Supplier Concentration at Approximately 80% of Procurement
-- Period : All-Time
-- Description : Calculates the number and percentage of suppliers that cumulatively account for approximately 80% of total estimated procurement value to evaluate supplier concentration and dependency.

with estimated_procurement_value_table as(
    select
        s.supplier_id,
        s.supplier_name,
        round(
            sum(pod.quantity * pv.cost_price),
            2
        ) as estimated_procurement_value
    from
        purchase_orders po
        inner join purchase_order_details pod on po.purchase_order_id = pod.purchase_order_id
        inner join product_variants pv on pv.variant_id = pod.variant_id
        inner join suppliers s on s.supplier_id = po.supplier_id
    group by
        s.supplier_id,
        s.supplier_name
),
supplier_contribution_table as(
    select
        *,
        round(
            (estimated_procurement_value * 100) / (
                select
                    sum(pod.quantity * pv.cost_price)
                from
                    purchase_order_details pod
                    inner join product_variants pv on pv.variant_id = pod.variant_id
            ),
            2
        ) as estimated_procurement_value_contribution
    from
        estimated_procurement_value_table
),
cumulative_procurement_contribution_table as(
select
    *,
    sum(estimated_procurement_value_contribution) over(
        order by estimated_procurement_value_contribution desc
    ) as cumulative_procurement_contribution
from
    supplier_contribution_table
order by
    estimated_procurement_value_contribution desc
),
comparison_table as(
    select
        count(*) as total_suppliers,
        (
            select count(*)
            from (
                select *
                from cumulative_procurement_contribution_table
                where floor(cumulative_procurement_contribution) <= 80
            ) as suppliers_contributing_upto_80_percent
        ) as number_of_suppliers_contributing_upto_80_percent
    from suppliers
)
select *,
round(
    (number_of_suppliers_contributing_upto_80_percent * 100) / total_suppliers,
    2
) as percentage_of_suppliers_contributing_upto_80_percent
from comparison_table;
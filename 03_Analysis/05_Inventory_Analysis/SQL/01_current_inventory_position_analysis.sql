-- Metric : Overall Inventory Position
-- Period : Current Inventory Snapshot
-- Description : Calculates total inventory units, total inventory value at cost, and total inventory value at listed selling prices across all stores and warehouses.
select
    sum(i.quantity) as total_units,
    round(sum(i.quantity * pv.cost_price), 2) as total_value_at_cost,
    round(sum(i.quantity * pv.selling_price), 2) as total_value_at_selling_price
from
    inventory i
    inner join product_variants pv on i.variant_id = pv.variant_id;

-- Metric : Inventory Position by Location Type
-- Period : Current Inventory Snapshot
-- Description : Evaluates current inventory held across stores and warehouses using total inventory units, inventory value at cost, and inventory value at listed selling prices.
select
    i.location_type,
    sum(i.quantity) as total_units,
    round(sum(i.quantity * pv.cost_price), 2) as total_value_at_cost,
    round(sum(i.quantity * pv.selling_price), 2) as total_value_at_selling_price
from
    inventory i
    inner join product_variants pv on i.variant_id = pv.variant_id
group by
    i.location_type;

-- Metric : Inventory Position by Category
-- Period : Current Inventory Snapshot
-- Description : Evaluates current inventory across product categories using total inventory units, inventory value at cost, and inventory value at listed selling prices.
select
    p.category,
    sum(i.quantity) as total_units,
    round(sum(i.quantity * pv.cost_price), 2) as total_value_at_cost,
    round(sum(i.quantity * pv.selling_price), 2) as total_value_at_selling_price
from
    inventory i
    inner join product_variants pv on i.variant_id = pv.variant_id
    inner join products p on p.product_id = pv.product_id
group by
    p.category;

-- Metric : Inventory Position by Product
-- Period : Current Inventory Snapshot
-- Description : Evaluates current inventory for each product using total inventory units, inventory value at cost, and inventory value at listed selling prices across all variants and inventory locations.
select
    p.product_id,
    p.product_name,
    sum(i.quantity) as total_units,
    round(sum(i.quantity * pv.cost_price), 2) as total_value_at_cost,
    round(sum(i.quantity * pv.selling_price), 2) as total_value_at_selling_price
from
    inventory i
    inner join product_variants pv on i.variant_id = pv.variant_id
    inner join products p on p.product_id = pv.product_id
group by
    p.product_id,
    p.product_name;

-- Metric : Inventory Position by Variant
-- Period : Current Inventory Snapshot
-- Description : Evaluates current inventory for each product variant using total inventory units, inventory value at cost, and inventory value at listed selling prices across all inventory locations.
select
    p.product_id,
    pv.variant_id,
    p.product_name,
    pv.color,
    pv.storage,
    pv.size,
    sum(i.quantity) as total_units,
    round(sum(i.quantity * pv.cost_price), 2) as total_value_at_cost,
    round(sum(i.quantity * pv.selling_price), 2) as total_value_at_selling_price
from
    inventory i
    inner join product_variants pv on i.variant_id = pv.variant_id
    inner join products p on p.product_id = pv.product_id
group by
    p.product_id,
    pv.variant_id,
    p.product_name,
    pv.color,
    pv.storage,
    pv.size;

-- Metric : Inventory Position by Store
-- Period : Current Inventory Snapshot
-- Description : Evaluates current inventory held at each store using total inventory units, inventory value at cost, and inventory value at listed selling prices.
select
    s.store_id,
    s.city,
    s.state,
    s.region,
    s.store_type,
    sum(i.quantity) as total_units,
    round(sum(i.quantity * pv.cost_price), 2) as total_value_at_cost,
    round(sum(i.quantity * pv.selling_price), 2) as total_value_at_selling_price
from
    inventory i
    inner join product_variants pv on i.variant_id = pv.variant_id
    inner join stores s on i.store_id = s.store_id
group by
    s.store_id,
    s.city,
    s.state,
    s.region,
    s.store_type
order by
    s.store_id;

-- Metric : Inventory Position by Warehouse
-- Period : Current Inventory Snapshot
-- Description : Evaluates current inventory held at each warehouse using total inventory units, inventory value at cost, and inventory value at listed selling prices.
select
    w.*,
    sum(i.quantity) as total_units,
    round(sum(i.quantity * pv.cost_price), 2) as total_value_at_cost,
    round(sum(i.quantity * pv.selling_price), 2) as total_value_at_selling_price
from
    inventory i
    inner join product_variants pv on i.variant_id = pv.variant_id
    inner join warehouses w on w.warehouse_id = i.warehouse_id
group by
    w.warehouse_id
order by
    w.warehouse_id;
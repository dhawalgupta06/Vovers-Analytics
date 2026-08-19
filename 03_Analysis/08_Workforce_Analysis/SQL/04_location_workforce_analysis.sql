-- Metric : Employees by Store
-- Period : Current Workforce
-- Description : Calculates the total number of employees working at each store.

select
store_id,
count(*) as number_of_employees
from employees
where store_id is not null
group by store_id;


-- Metric : Average Monthly Salary by Store
-- Period : Current Workforce
-- Description : Calculates the average monthly salary of employees working at each store.

select
store_id,
round(avg(salary), 2) as avg_monthly_salary
from employees
where store_id is not null
group by store_id;


-- Metric : Annual Payroll by Store
-- Period : Current Workforce
-- Description : Calculates the estimated annual payroll cost of employees working at each store by annualizing their monthly salaries.

select
store_id,
round(sum(salary * 12), 2) as total_annual_payroll
from employees
where store_id is not null
group by store_id;


-- Metric : Employees by Store Region
-- Period : Current Workforce
-- Description : Calculates the total number of store employees working within each geographic region.

select
s.region as store_region,
count(*) as number_of_employees
from employees e
inner join stores s
    on s.store_id = e.store_id
where e.store_id is not null
group by
s.region;


-- Metric : Employees by Warehouse
-- Period : Current Workforce
-- Description : Calculates the total number of employees working at each warehouse.

select
warehouse_id,
count(*) as number_of_employees
from employees
where warehouse_id is not null
group by warehouse_id;


-- Metric : Average Monthly Salary by Warehouse
-- Period : Current Workforce
-- Description : Calculates the average monthly salary of employees working at each warehouse.

select
warehouse_id,
round(avg(salary), 2) as avg_monthly_salary
from employees
where warehouse_id is not null
group by warehouse_id;


-- Metric : Annual Payroll by Warehouse
-- Period : Current Workforce
-- Description : Calculates the estimated annual payroll cost of employees working at each warehouse by annualizing their monthly salaries.

select
warehouse_id,
round(sum(salary * 12), 2) as total_annual_payroll
from employees
where warehouse_id is not null
group by warehouse_id;


-- Metric : Employees by Warehouse Region
-- Period : Current Workforce
-- Description : Calculates the total number of warehouse employees working within each geographic region.

select
w.region as warehouse_region,
count(*) as number_of_employees
from employees e
inner join warehouses w
    on w.warehouse_id = e.warehouse_id
where e.warehouse_id is not null
group by
w.region;
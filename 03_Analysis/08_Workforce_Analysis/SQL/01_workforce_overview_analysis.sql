-- Metric : Total Employees
-- Period : Current Workforce
-- Description : Calculates the total number of employees currently recorded in the Vovers workforce.
select
    count(*) as total_employees
from
    employees;

-- Metric : Total Departments
-- Period : Current Workforce
-- Description : Calculates the total number of distinct departments represented in the current workforce.
select
    count(distinct department) as total_departments
from
    employees;

-- Metric : Average Employee Age
-- Period : Current Workforce
-- Description : Calculates the average age of employees across the current workforce.
select
    round(avg(age), 2) as avg_employee_age
from
    employees;

-- Metric : Average Monthly Salary
-- Period : Current Workforce
-- Description : Calculates the average monthly salary of employees across the current workforce.
select
    round(avg(salary), 2) as avg_monthly_salary
from
    employees;

-- Metric : Total Annual Payroll
-- Period : Current Workforce
-- Description : Calculates the estimated annual payroll cost of the current workforce by annualizing employee monthly salaries.
select
    round(sum(salary * 12), 2) as total_annual_payroll
from
    employees;

-- Metric : Average Employee Tenure
-- Period : Current Workforce
-- Description : Calculates the average employee tenure in years using the latest order date in the dataset as the reference date.
select
    round(
        avg(
            timestampdiff(
                month,
                join_date,
                (
                    select
                        max(order_datetime)
                    from
                        orders
                )
            ) / 12
        ),
        2
    ) as avg_employee_tenure
from
    employees;

-- Metric : Employee Joinings by Year
-- Period : All-Time
-- Description : Calculates the number of employees who joined Vovers in each year to evaluate annual workforce hiring activity.
select
    year(join_date) as year,
    count(*) as employees_joined
from
    employees
group by
    year(join_date)
order by
    year;
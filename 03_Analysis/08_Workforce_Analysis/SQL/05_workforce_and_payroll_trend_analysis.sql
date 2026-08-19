-- Metric : Employee Joinings Trend
-- Period : 2023–2025
-- Description : Calculates the number of employees who joined Vovers in each year to evaluate annual hiring activity.
select
    year(join_date) as year,
    count(*) as employees_joined
from
    employees
where
    join_date >= '2023-01-01'
    and join_date < '2026-01-01'
group by
    year(join_date)
order by
    year;

-- Metric : YoY Employee Joinings Growth
-- Period : 2023–2025
-- Description : Calculates annual employee joinings and compares each year's hiring volume with the previous year to measure year-over-year growth in workforce additions.
with emp_joining_comparison as(
    select
        year(join_date) as year,
        count(*) as employees_joined_in_current_year,
        lag(count(*)) over(
            order by
                year(join_date)
        ) as employees_joined_in_previous_year
    from
        employees
    where
        join_date >= '2023-01-01'
        and join_date < '2026-01-01'
    group by
        year(join_date)
)
select
    *,
    round(
        (
            (
                employees_joined_in_current_year - employees_joined_in_previous_year
            ) * 100
        ) / employees_joined_in_previous_year,
        2
    ) as employees_joined_growth_percentage
from
    emp_joining_comparison
order by
    year;

-- Metric : Annual Payroll Added by Joining Year
-- Period : 2023–2025
-- Description : Calculates the annualized payroll represented by employees who joined Vovers in each year based on their current monthly salaries.
select
    year(join_date) as year,
    round(sum(salary * 12), 2) as annual_payroll_added
from
    employees
where
    join_date >= '2023-01-01'
    and join_date < '2026-01-01'
group by
    year(join_date)
order by
    year;

-- Metric : Average Current Monthly Salary by Joining Year
-- Period : 2023–2025
-- Description : Calculates the current average monthly salary of employees grouped by the year in which they joined Vovers.
select
    year(join_date) as year,
    round(avg(salary), 2) as avg_current_monthly_salary
from
    employees
where
    join_date >= '2023-01-01'
    and join_date < '2026-01-01'
group by
    year(join_date)
order by
    year;
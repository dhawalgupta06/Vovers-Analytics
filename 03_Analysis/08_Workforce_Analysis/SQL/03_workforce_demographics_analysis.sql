-- Metric : Employees by Gender
-- Period : Current Workforce
-- Description : Calculates the total number of employees within each gender group across the current workforce.

select
gender,
count(*) as number_of_employees
from employees
group by gender;

-- Metric : Gender Distribution %
-- Period : Current Workforce
-- Description : Calculates each gender group's percentage contribution to the total current workforce.

select
gender,
round(
    (count(*) * 100) /
    (select count(*) from employees),
    2
) as gender_distribution_percentage
from employees
group by gender;

-- Metric : Average Monthly Salary by Gender
-- Period : Current Workforce
-- Description : Calculates the average monthly salary of employees within each gender group.

select
gender,
round(avg(salary), 2) as avg_monthly_salary
from employees
group by gender;

-- Metric : Employees by Age Group
-- Period : Current Workforce
-- Description : Calculates the total number of employees within each defined workforce age group.

select
case
    when age >= 18 and age <= 24 then "18-24"
    when age >= 25 and age <= 34 then "25-34"
    when age >= 35 and age <= 44 then "35-44"
    when age >= 45 and age <= 54 then "45-54"
    else "55+"
end as age_group,
count(*) as number_of_employees
from employees
group by age_group
order by age_group;

-- Metric : Age Group Distribution %
-- Period : Current Workforce
-- Description : Calculates each age group's percentage contribution to the total current workforce.

select
case
    when age >= 18 and age <= 24 then "18-24"
    when age >= 25 and age <= 34 then "25-34"
    when age >= 35 and age <= 44 then "35-44"
    when age >= 45 and age <= 54 then "45-54"
    else "55+"
end as age_group,
count(*) as number_of_employees,
round(
    (count(*) * 100) /
    (select count(*) from employees),
    2
) as age_group_distribution_percentage
from employees
group by age_group
order by age_group;
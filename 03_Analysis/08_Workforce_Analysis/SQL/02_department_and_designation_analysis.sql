-- Metric : Employees by Department
-- Period : Current Workforce
-- Description : Calculates the total number of employees working in each department.

select
department,
count(*) as total_employees
from employees
group by department;

-- Metric : Workforce Contribution % by Department
-- Period : Current Workforce
-- Description : Calculates each department's percentage contribution to the total current workforce.

select
department,
count(*) as total_employees,
round(
    (count(*) * 100) /
    (select count(*) from employees),
    2
) as workforce_contribution_percentage
from employees
group by department;

-- Metric : Average Monthly Salary by Department
-- Period : Current Workforce
-- Description : Calculates the average monthly salary of employees within each department.

select
department,
round(avg(salary), 2) as avg_monthly_salary
from employees
group by department;

-- Metric : Annual Payroll by Department
-- Period : Current Workforce
-- Description : Calculates the estimated annual payroll cost for each department by annualizing employee monthly salaries.

select
department,
round(sum(salary * 12), 2) as annual_payroll
from employees
group by department;

-- Metric : Payroll Contribution % by Department
-- Period : Current Workforce
-- Description : Calculates each department's contribution to total annual payroll cost across the current workforce.

select
department,
round(sum(salary * 12), 2) as annual_payroll,
round(
    (sum(salary * 12) * 100) /
    (select sum(salary * 12) from employees),
    2
) as annual_payroll_contribution_percentage
from employees
group by department;

-- Metric : Employees by Designation
-- Period : Current Workforce
-- Description : Calculates the total number of employees working in each designation.

select
designation,
count(*) as total_employees
from employees
group by designation;


-- Metric : Workforce Contribution % by Designation
-- Period : Current Workforce
-- Description : Calculates each designation's percentage contribution to the total current workforce.

select
designation,
count(*) as total_employees,
round(
    (count(*) * 100) /
    (select count(*) from employees),
    2
) as workforce_contribution_percentage
from employees
group by designation;


-- Metric : Average Monthly Salary by Designation
-- Period : Current Workforce
-- Description : Calculates the average monthly salary of employees within each designation.

select
designation,
round(avg(salary), 2) as avg_monthly_salary
from employees
group by designation;


-- Metric : Annual Payroll by Designation
-- Period : Current Workforce
-- Description : Calculates the estimated annual payroll cost for each designation by annualizing employee monthly salaries.

select
designation,
round(sum(salary * 12), 2) as annual_payroll
from employees
group by designation;


-- Metric : Payroll Contribution % by Designation
-- Period : Current Workforce
-- Description : Calculates each designation's percentage contribution to the total annual payroll cost of the current workforce.

select
designation,
round(sum(salary * 12), 2) as annual_payroll,
round(
    (sum(salary * 12) * 100) /
    (select sum(salary * 12) from employees),
    2
) as annual_payroll_contribution_percentage
from employees
group by designation;
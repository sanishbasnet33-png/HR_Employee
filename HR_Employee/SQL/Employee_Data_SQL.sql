select *
from employee_dataset;

describe employee_dataset;

-- Total number of employees, and count of Active vs. Inactive vs. Pending
select Status, count(Employee_ID) as Employee
from employee_dataset
group by Status;

-- Average Age and average Salary overall
select avg(Age) as AVG_Age, round(avg(Salary),3) as Avg_Salary
from employee_dataset
;

-- Total and average Salary by Department
select Department, round(sum(Salary),4) as Total_Salary, round(avg(Salary),4) as Avg_salary 
from employee_dataset
group by Department
;

-- Employee count per Region, and per Department
select Region, Department, count(Employee_ID) As `Employee Count`
from employee_dataset
group by Region , Department
order by Region , `Employee Count` Desc;


-- Average Salary by Department and Region together (two-column grouping)
select Region, Department, round(avg(Salary)) as AVG_Salary
from employee_dataset
group by Region, Department
order by Region, AVG_Salary desc;

-- Which Department has the highest count of "Excellent" Performance Score employees
select Department, count(*) as Excellent
from employee_dataset
Where Performance_Score = "Excellent"
group by Department
order by Excellent desc
;

-- How many employees joined each year (extract year from Join_Date, group by it)
select year(Join_Date) as Join_Year, count(Employee_ID) as Employee_Count
from employee_dataset
group by year(Join_Date);


-- Average tenure (in years) of currently Active employees, based on Join_Date vs. today's date
select Department,	
	round(Avg(datediff(CURDATE(),Join_Date)/365),3 )as Avg_Tenure
from employee_dataset
where Status = "Active"
group by Department
order by Avg_Tenure desc;

-- Bucket employees into age groups (under 25, 25–34, 35–44, 45+) using CASE WHEN, then average Salary per bucket

select case 
when age <25 Then "Under 25"
when age >= 25 and age <= 34 then "25 - 34"
when age >= 35 and age <= 44 then "35 - 44"
else "45+"
end as Age_Bucket,
round(avg(salary),3) as Avg_Salary
from employee_dataset
group by Age_Bucket 
order by Avg_Salary;

-- Rank employees within each Department by Salary, highest to lowest
select Department,
`Full Name`, 
rank() over( partition by Department order by salary desc) As Salary_Rank,
 Salary
from employee_dataset;




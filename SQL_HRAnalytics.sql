create database analyst;
use analyst;
--------------------------------------------------------------------------------------
# 1.Average Attrition rate for all Departments

select Department,(sum(case Attrition when 'yes' then 1 else 0 end)/count(*))*100 as avg_attrition 
from hr_1_hr 
group by department
order by department ;
--------------------------------------------------------------------------------------------------
# 2.Average Hourly rate of Male Research Scientist   

use analyst;

select avg(HourlyRate) from hr_1_hr  where Gender="male" and JobRole="Research Scientist";

select Gender, JobRole, avg(HourlyRate) as avg_hourlyrate FROM hr_1_hr
where gender='male'and jobrole="research scientist";
------------------------------------------------------------------------------------------------------------

# 3.Attrition rate Vs Monthly income stats      

select floor(monthlyincome/10000)*10000 as income_bin ,
sum(case attrition when 'yes' then 1 else 0 end)/count(employeecount)*100 as Atr_rate 
from  hr_1_hr
inner join hr_2_hr
on hr_1_hr.EmployeeNumber = hr_2_hr.`Employee ID`
group by income_bin
order by income_bin ;
--------------------------
select income_range,floor( ac/ec*100)AttritionRate from (
 select  case                when monthlyincome between 1000 and 10000 then '0k-10k'
                                      when monthlyincome between 10000 and 20000 then '10k-20k'
                                      when monthlyincome between 20000 and 30000 then '20k-30k'
                                      when monthlyincome between 30000 and 40000 then '30k-40k'
                                      when monthlyincome between 40000 and 50000 then '40k-50k'
                                      else '50k-60k' end as Income_Range,
count(if(Attrition='yes',1,null))ac,
count(EmployeeCount)ec
 from hr_1_hr
 inner join hr_2_hr
 on hr_1_hr.EmployeeNumber = hr_2_hr.`Employee ID`
 group by Income_Range )x
 group by income_range
 order by income_range;
--------------------------------------------------------------------------------------
# 4.Average working years for each Department


select hr_1_hr.Department ,avg(hr_2_hr.YearsAtCompany) as avg_work_year 
from  hr_1_hr
inner join hr_2_hr
on hr_1_hr.EmployeeNumber = hr_2_hr.`Employee ID`
group by hr_1_hr.Department;
----------------------------------------------------------------------------------------------------
  5.Job Role Vs Work life balance
 
  select JobRole,
 case
    when worklifebalance=1 then 'excellent'
    when worklifebalance=2 then 'good'
    when worklifebalance=3 then 'average'
    when worklifebalance=4 then 'poor'
    else 'null'
 end as worklife_balance 
 from hr_1_hr
 inner join hr_2_hr
 on hr_1_hr.EmployeeNumber = hr_2_hr.`Employee ID`
GROUP  by jobrole
order by jobrole ;
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
 
 -------------------------------------------------------------------------------------------------
  # 6.Attrition rate Vs Year since last promotion relation     
 

 select distinct YearsSinceLastPromotion, sum(case attrition when 'yes' then 1 else 0 end)/count(employeecount)*100 as atr_rate 
 from hr_1_hr
 join hr_2_hr
 on hr_1_hr.EmployeeNumber= hr_2_hr.`Employee ID`
 group by YearsSinceLastPromotion
 order by YearsSinceLastPromotion;
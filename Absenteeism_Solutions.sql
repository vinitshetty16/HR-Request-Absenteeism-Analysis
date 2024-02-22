-- Create a Join table

select * from Absenteeism_at_work as ab
Left join compensation as comp
on ab.ID = comp.ID
left join Reasons as r
on ab.Reason_for_absence = r.Number;

-- Find a list of healthy & Low Absenteeism Employees for Bonus
-- Criteria for Healthy - Not a Social Drinker, Smoker, BMI < 25

select * from Absenteeism_at_work
where Social_drinker = 0 and Social_smoker = 0
and Body_mass_index < 25 and 
Absenteeism_time_in_hours < (select AVG(Absenteeism_time_in_hours) from Absenteeism_at_work);

-- Calculate Wage Increase or Annual Compensation for non-smokers
-- Insurance Budget for Non-Smokers = $983,22 which comes to around $0.68 increase per hour or $1,414.4 annually 
select COUNT(*) as Non_Smokers from Absenteeism_at_work
where Social_smoker = 0

-- Optimize the below query
select 
ab.ID,
r.Reason,
Body_mass_index,
Case WHEN Body_mass_index < 18.5 Then 'Underweight'
	WHEN Body_mass_index between 18.5 and 25 Then 'Healthy'
	WHEN Body_mass_index between 25 and 30 Then 'Overweight'
	WHEN Body_mass_index > 30 Then 'Obese'
	ELSE 'Unknown'
END as BMI_Category,

Case WHEN Month_of_absence IN (12,1,2) Then 'Winter'
	WHEN Month_of_absence IN (3,4,5) Then 'Spring'
	WHEN Month_of_absence IN (6,7,8) Then 'Summer'
	WHEN Month_of_absence IN (9,10,11) Then 'Autumn'
	ELSE 'Unknown'
END as Seasons,
Month_of_absence,
Day_of_the_week,
Transportation_expense,
Education,
Son,
Social_drinker,
Social_smoker,
pet,
Disciplinary_failure,
Age,
Work_load_Average_day,
Absenteeism_time_in_hours
from Absenteeism_at_work as ab
Left join compensation as comp
on ab.ID = comp.ID
left join Reasons as r
on ab.Reason_for_absence = r.Number;




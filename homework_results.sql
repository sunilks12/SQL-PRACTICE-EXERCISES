
/*
Given the homework results of a group of students, calculate the average grade and the completion rate of each student. A homework is considered not completed if no grade has been assigned.
Output first name of a student, their average grade, and completion rate in percentages. Note that it's possible for several students to have the same first name but their results should still be shown separately.
*/

with cte1 as (
select a.*,b.student_firstname,b.student_lastname,
case when a.grade is not null then 1 else 0 end as complet
from allstate_homework a
inner join allstate_students b 
on a.student_id=b.student_id),
cte2 as (
select *,avg(grade) as avg_grade,count(grade) as cntgrade, count(*) as cnt from cte1 group by 1
),
cte3 as (select student_firstname,student_lastname,avg_grade,cntgrade/cnt *100 as perc_comp from 
cte2 group by 1,student_lastname order by 2 desc)select  student_firstname,avg_grade,perc_comp from cte3 order by 2 desc

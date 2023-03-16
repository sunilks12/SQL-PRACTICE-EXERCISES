/*
Write a query to calculate the longest period (in days) that the company has gone without hiring anyone. Also, calculate the longest
period without firing anyone. Limit yourself to dates 
inside the table (last hiring/termination date should be the latest hiring /termination date from table), don't go into future.
*/

select max(datediff(hire_date,prev_dte)),
max(datediff(termination_date, prev_dte)) from (
select 
    hire_date, termination_date,
    LAG(hire_date) over (order by hire_date) as prev_dte,
    LAG(termination_date) over (order by termination_date) as prev_ter_dte
    from uber_employees )a

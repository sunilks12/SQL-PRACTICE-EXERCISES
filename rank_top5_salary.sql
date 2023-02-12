with cte1 as (
select * from lyft_drivers
where end_date is null),
cte2 as (
select start_date, rank() over( order by yearly_salary desc ) rnk
from cte1) select start_date from cte2 where rnk in (1,2,3,4,5)

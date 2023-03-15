

with cte1 as(
select a.*,b.company_id, b.status from rc_calls a 
join rc_users b on a.user_id=b.user_id), cte2 as (
select company_id, user_id, dense_rank() over (partition BY company_id order by count(call_id) desc) rnk 
from cte1 group by user_id)
select * from cte2 where rnk<=2

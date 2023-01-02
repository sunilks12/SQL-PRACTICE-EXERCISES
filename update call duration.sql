/*
Redfin helps clients to find agents. Each client will have a unique request_id and each request_id has several calls. 
For each request_id, the first call is an
“initial call” and all the following calls are “update calls”.  What's the average call duration for all update calls?
*/

with cte1 as (
select *,
row_number() over(partition by request_id order by created_on) as rnk 
from redfin_call_tracking),
cte2 as (select * from cte1 where rnk!=1)
select sum(1.0*call_duration)/count(*) as avg from cte2

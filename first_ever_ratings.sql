/*
Looking at Dashers completing their first-ever order: what percentage of Dashers' first-ever orders have a rating of 0?
*/

with cte1 as (
select *, rank() over(partition by dasher_id order by actual_delivery_time) rnk from delivery_orders)
select (select sum(case when delivery_rating=0 then 1 else 0 end))/count(*)*100 from cte1 where rnk=1

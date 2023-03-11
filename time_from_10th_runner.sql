/*
In a marathon, gun time is counted from the moment of the formal start of the race while net time is counted from the moment a runner crosses a starting line. Both variables are in seconds.
How much net time separates Chris Doe from the 10th best net time (in ascending order)? Avoid gaps in the ranking calculation. Output absolute net time difference.
*/

with cte1 as (
select person_name, net_time,
dense_rank() over (order by net_time) as net_rank from marathon_male),
cte2 as (
select net_time from marathon_male where person_name='Chris Doe')
select distinct cte2.net_time-cte1.net_time from cte1,cte2
where net_rank=10

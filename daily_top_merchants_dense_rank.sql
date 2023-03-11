/*
For each day, find the top 3 merchants with the highest number of orders on that day. In case of a tie, multiple merchants can share the same place but on each day, there should always be at least 1 merchant on the first, second and third place.
Output the date, the name of the merchant and their place in the daily ranking.
*/

select ord_date, name, rnk from (
select date(o.order_timestamp) ord_date,
name, dense_rank() over(partition by date(o.order_timestamp) order by count(o.id) desc) rnk
from doordash_orders o
join doordash_merchants m on o.merchant_id=m.id 
group by 1,2
)a 
where rnk <=3

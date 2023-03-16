/*
For each merchant, find how many orders and first-time orders they had. First-time orders are meant from the perspective of a customer and are the first order that a customer ever made. In order words, for how many customers was this the first-ever merchant they ordered with?
Output the name of the merchant, the total number of their orders and the number of these orders that were first-time orders.

*/


with cte1 as (
select a.*,b.name,b.category,b.zipcode from doordash_orders a
join doordash_merchants b on
a.merchant_id=b.id),
cte2 as (select name,
rank() over(partition by customer_id order by order_timestamp) rnk
from cte1
)select name, count(*) as  total_order, sum(case when rnk=1 then 1 else 0 end) first_order from cte2
group by name

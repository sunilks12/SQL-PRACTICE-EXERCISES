with cte1 as (
select *, cost_in_dollars*units_sold as total 
from facebook_sales)
select top 5 product_id, sum(total) as revenue 
from cte1 
group by product_id
order by  sum(total) desc

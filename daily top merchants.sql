select ord_date, name, rnk from (
select date(o.order_timestamp) ord_date,
name, dense_rank() over(partition by date(o.order_timestamp) order by count(o.id) desc) rnk
from doordash_orders o
join doordash_merchants m on o.merchant_id=m.id 
group by 1,2
)a 
where rnk <=3

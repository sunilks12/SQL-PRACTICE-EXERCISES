with cte1 as (select a.*,b.order_date,b.promo_code, b.order_fare from lyft_orders a
left join lyft_payments b on a.order_id=b.order_id),
cte2 as (select * from cte1 where YEAR(order_date) =2021 and month(order_date)=08 and promo_code='FALSE'), cte3 as (
select city, rank() over(order by count(*) desc) rnk
 from cte2 group by city)select city from cte3
 where rnk=1

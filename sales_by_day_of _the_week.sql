with cte1 as(
select distinct item_category,
case when dayname(order_date)='Monday' then sum(quantity) over(partition by item_category,dayname(order_date)) else 0 end as Monday,
Case when dayname(order_date)='Tuesday' then sum(quantity) over(partition by item_category,dayname(order_date)) else 0 end as Tuesday,
Case when dayname(order_date)='Wednesday' then sum(quantity) over(partition by item_category,dayname(order_date)) else 0 end as Wednesday,
Case when dayname(order_date)='Thursday' then sum(quantity) over(partition by item_category,dayname(order_date)) else 0 end as Thursday,
Case when dayname(order_date)='Friday' then sum(quantity) over(partition by item_category,dayname(order_date)) else 0 end as Friday,
Case when dayname(order_date)='Saturday' then sum(quantity) over(partition by item_category,dayname(order_date)) else 0 end as Saturday,
Case when dayname(order_date)='Sunday' then sum(quantity) over(partition by item_category,dayname(order_date)) else 0 end as Sunday
from orders o
right join items i
using (item_id)) 
select item_category as category, sum(Monday) as Monday, sum(Tuesday) as Tuesday, sum(Wednesday) Wednesday, sum(Thursday) Thursday,
sum(Friday) Friday, sum(Saturday) Saturday, sum(Sunday) Sunday
from cte1
group by item_category

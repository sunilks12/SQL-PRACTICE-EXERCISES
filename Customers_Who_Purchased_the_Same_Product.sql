/* In order to improve customer segmentation efforts for users interested in purchasing furniture, you have been asked to find customers who have purchased the same items of furniture.
Output the product_id, brand_name, unique customer ID's who purchased that product, and the count of unique customer ID's who purchased that product. Arrange the output in descending order with the highest count at the top.
*/


with cte1 as (
select * from 
(select a.*,b.product_class,b.brand_name,
is_low_fat,b.is_recyclable, b.product_category, product_family from online_orders a inner join online_products b
on a.product_id=b.product_id) a
where product_class='FURNITURE'
),
cte2 as (select product_id,brand_name,customer_id,
count(customer_id) over (partition by product_id) from cte1 
group by 1,2,3) select * from cte2 order by 4 desc

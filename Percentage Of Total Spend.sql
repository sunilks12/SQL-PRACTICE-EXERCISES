/* Calculate the percentage of the total spend a customer spent on each order. Output the customer’s first name, order details, and percentage of the order cost to their total spend across all orders.

Assume each customer has a unique first name (i.e., there is only 1 customer named Karen in the dataset) and that customers place at most only 1 order a day.

Percentages should be represented as decimals
*/

with cte1 as (
select a.*,b.first_name from orders a inner join
customers b on a.cust_id=b.id),
cte2 as (
select first_name, order_details, total_order_cost/sum(total_order_cost) 
over(partition by first_name)as perc from cte1 )select * from cte2

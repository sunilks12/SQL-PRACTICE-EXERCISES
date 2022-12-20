'''
Estimate the growth of Airbnb each year using the number of hosts registered as the growth metric. The rate of growth is calculated by taking ((number of hosts registered in the current year - number of hosts registered in the previous year) / the number of hosts registered in the previous year) * 100.
Output the year, number of hosts in the current year, number of hosts in the previous year, and the rate of growth. Round the rate of growth to the nearest percent and order the result in the ascending order based on the year.
Assume that the dataset consists only of unique hosts, meaning there are no duplicate hosts listed.
'''

with cte1 as (
select  *, year(host_since) as year from airbnb_search_details
order by year),
cte2 as (
select year, count(id) as count from cte1 group by year order by 2 asc),
cte3 as (select year, count, lag(count) over(order by year ) as previous_year from cte2),
cte4 as (select *, round(((count- previous_year)/previous_year)*100,0) as estimated_growth from cte3)
select * from cte4

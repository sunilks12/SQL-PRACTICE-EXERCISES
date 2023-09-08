
with cte1 as (
select  user_id  from ad_impressions
where impression_id ='Excited' 
),
cte2 as (
 select  user_id  from ad_impressions
where impression_id ='Bored'    
)
select distinct user_id from (select a.user_id,b.user_id as id from cte1 a
left join cte2 b 
on a.user_id=b.user_id) x
where id is null

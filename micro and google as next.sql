with cte1 as (
select *,lead(employer) over(partition by user_id order by start_date) next from linkedin_users)select sum(case when
employer='Microsoft' and next='Google' then 1 else 0 end) from cte1

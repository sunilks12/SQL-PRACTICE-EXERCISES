select * from (
select *,row_number() over(partition by department order by salary desc) rnk from worker) a
where rnk<=3

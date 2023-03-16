

select * from (
select *,ntile(2) over() rnk from worker)a
where rnk=1

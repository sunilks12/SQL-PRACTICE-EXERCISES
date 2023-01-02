select jobtitle 
from (
    select *, rank () over(order by overtimepay desc) as rnk 
    from sf_public_salaries
) as t
where isnull(overtimepay, 0) <> 0 and rnk <= 3;




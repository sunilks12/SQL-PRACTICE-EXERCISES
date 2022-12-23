with pop as (
    select employee_id, row_number() over(order by popularity desc, employee_id asc) fan, 
    row_number() over(order by popularity asc, employee_id asc) hater
from facebook_hack_survey)

select f.employee_id as employee_fan_id, h.employee_id as employee_opposition_id
from pop f
join  pop h
on f.fan = h.hater
order by f.fan;

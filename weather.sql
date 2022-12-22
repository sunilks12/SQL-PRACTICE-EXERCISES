select w2.id
from weather w1
join weather w2 on date_add(w2.recorddate, interval -1 day) = w1.recorddate and w2.temperature > w1.temperature

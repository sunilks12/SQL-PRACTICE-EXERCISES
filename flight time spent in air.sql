Let’s say you work in air traffic control. You are given the table below containing information on flights between two cities.

Write a query to find out how much time, in minutes (rounded down), each plane spent in the air each day.

Note: Both cities are in the same time zone, so you do not need to worry about converting time zones.

WITH cte_1 AS 
(
  SELECT id, destination_location,source_location, plane_id, 
  CAST(DATE(flight_start) AS DATETIME) day_begin, flight_start, 
  CAST(DATE(flight_end) AS DATETIME) day_change, flight_end 
  FROM flights
),
cte_2 AS (
SELECT 
  plane_id,
  DATE(day_begin) as day_begin, 
  IF (day_begin = day_change, TIME_TO_SEC(TIMEDIFF(flight_end,flight_start)) DIV 60, TIME_TO_SEC(TIMEDIFF(day_change,flight_start)) DIV 60) AS delta_current_min,
  DATE(day_change) AS day_change, 
  IF (day_begin = day_change, TIME_TO_SEC(TIMEDIFF(flight_start,flight_start)) DIV 60,TIME_TO_SEC(TIMEDIFF(flight_end,day_change)) DIV 60) AS delta_next_min 
FROM cte_1
),
cte_3 AS (
SELECT plane_id, day_begin as calendar_day, delta_current_min AS time_in_min FROM cte_2
UNION ALL
SELECT plane_id, day_change as calendar_day, delta_next_min AS time_in_min FROM cte_2
)
SELECT plane_id, calendar_day, SUM(time_in_min) AS time_in_min
FROM cte_3 
GROUP BY plane_id, calendar_day
HAVING time_in_min > 0
ORDER BY plane_id, calendar_day

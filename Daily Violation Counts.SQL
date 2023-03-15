/*
Determine the change in the number of daily violations by calculating the difference between the count of current and previous violations by inspection date.
Output the inspection date and the change in the number of daily violations. Order your results by the earliest inspection date first.
*/

SELECT date_, (cur_cnt-pre_cnt) AS diff
    FROM (SELECT
    date(inspection_date) as date_,
    COUNT(distinct violation_id) as cur_cnt,
    LAG(COUNT(DISTINCT violation_id),1) OVER(ORDER BY date(inspection_date) asc) AS pre_cnt
    FROM sf_restaurant_health_violations
    GROUP BY 1) Tbl
ORDER BY 1 ASC


SELECT * 
FROM(
    SELECT T.id, name,Total_Distance_Travelled, RANK() OVER(ORDER BY Total_Distance_Travelled DESC) as TOP
    FROM
    (
            select lyft_users.id, name, SUM(distance) as Total_Distance_Travelled
        from lyft_rides_log JOIN lyft_users ON user_id=lyft_users.id
        GROUP BY user_id
        ORDER BY Total_Distance_Travelled DESC) as T) as U
WHERE TOP<11

SELECT *
FROM (SELECT hotel_name 
     ,RANK() OVER (ORDER BY AVG(average_score) DESC) AS rkn
     ,AVG(average_score) as avg
    FROM hotel_reviews
    GROUP BY hotel_name) a
WHERE a.rkn < 11

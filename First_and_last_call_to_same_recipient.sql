WITH calls AS 
(
    SELECT *
        , CAST(date_called AS DATE) AS date_only
        , MIN(date_called) OVER (PARTITION BY caller_id, date_called) AS first_date_called
        , FIRST_VALUE(recipient_id) OVER (PARTITION BY caller_id, CAST(date_called AS DATE) ORDER BY CAST(date_called AS DATETIME)) AS first_recipient
        , FIRST_VALUE(recipient_id) OVER (PARTITION BY caller_id, CAST(date_called AS DATE) ORDER BY CAST(date_called AS DATETIME) DESC) AS last_recipient
    FROM caller_history
)
SELECT DISTINCT 
    caller_id, recipient_id, date_only
FROM calls
WHERE first_recipient = last_recipient
    AND recipient_id = first_recipient

;

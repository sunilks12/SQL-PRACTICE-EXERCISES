WITH sessions AS (
    SELECT
        user_id,
        COUNT(CASE WHEN session_type='streamer' THEN 1 END) AS stream_sessions,
        COUNT(CASE WHEN session_type='viewer' THEN 1 END) AS view_sessions,
        RANK() OVER (PARTITION BY user_id ORDER BY (COUNT(CASE WHEN session_type='streamer' THEN 1 END) + COUNT(CASE WHEN session_type='viewer' THEN 1 END)) DESC) AS rnk 
    FROM twitch_sessions
    GROUP BY user_id
)
SELECT  
    user_id,
    stream_sessions,
    view_sessions
FROM sessions
WHERE stream_sessions>view_sessions AND rnk<=10

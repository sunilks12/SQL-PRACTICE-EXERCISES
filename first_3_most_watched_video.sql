After a new user creates an account and starts watching videos, the user ID, video ID, and date watched are captured in the database. Find the top 3 videos most users have watched as their first 3 videos. Output the video ID and the number of times it has been watched as the users' first 3 videos.
In the event of a tie, output all the videos in the top 3 that users watched as their first 3 videos.

Select video_id, ct
from 
(Select video_id, count(user_id) ct, dense_rank()Over(Order by count(user_id) desc) rk
from
(select user_id, video_id, rank()Over(Partition by user_id Order by watched_at) time_rk
from videos_watched) tb
where time_rk <= 3
Group by video_id) tb2
where rk <=3

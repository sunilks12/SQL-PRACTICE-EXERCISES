
/* For each hotel find the number of reviews from the most active reviewer. The most active is the one with highest number of total reviews.
Output the hotel name along with the highest total reviews of that reviewer. Output only top 5 hotels with highest total reviews.
Order records based on the highest total reviews in descending order
*/



WITH base AS
(
SELECT hotel_name,
       total_number_of_reviews_reviewer_has_given,
       RANK() OVER (PARTITION BY hotel_name ORDER BY total_number_of_reviews_reviewer_has_given DESC) AS rank_revs
FROM hotel_reviews
),
ranking_cte AS
(
SELECT hotel_name,
       total_number_of_reviews_reviewer_has_given,
      rank() OVER(ORDER BY total_number_of_reviews_reviewer_has_given DESC) AS rank_hotel
FROM base
WHERE rank_revs = 1
)
SELECT hotel_name,
       total_number_of_reviews_reviewer_has_given
FROM ranking_cte
WHERE rank_hotel < 6

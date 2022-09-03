WITH RECURSIVE t1 AS(
                    SELECT visit_date,
                           COALESCE(num_visits,0) as num_visits,
                           COALESCE(num_trans,0) as num_trans
                    FROM ((
                          SELECT visit_date, user_id, COUNT(*) as num_visits
                          FROM visits
                          GROUP BY 1, 2) AS a
                         LEFT JOIN
                          (
                           SELECT transaction_date,
                                 user_id,
                                 count(*) as num_trans
                            FROM transactions
                          GROUP BY 1, 2) AS b
                         ON a.visit_date = b.transaction_date and a.user_id = b.user_id)
                      ),

              t2 AS (
                      SELECT MAX(num_trans) as trans
                        FROM t1
                      UNION ALL
                      SELECT trans-1 
                        FROM t2
                      WHERE trans >= 1)

SELECT trans as transactions_count, 
       COALESCE(visits_count,0) as visits_count
  FROM t2 LEFT JOIN (
                    SELECT num_trans as transactions_count, COALESCE(COUNT(*),0) as visits_count
                    FROM t1 
                    GROUP BY 1
                    ORDER BY 1) AS a
ON a.transactions_count = t2.trans
ORDER BY 1
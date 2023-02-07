SELECT  client,
        date_due,
        amount_due,
        DATEDIFF ('2020-04-30', date_due) AS days_due,
        CASE
    WHEN  DATEDIFF ('2020-04-30', date_due) <= 30 THEN '0-30 days'
    WHEN  DATEDIFF ('2020-04-30', date_due) > 30 AND DATEDIFF ('2020-04-30', date_due) <=90 THEN '31-90 days'
    WHEN  DATEDIFF ('2020-04-30', date_due) > 90 AND DATEDIFF ('2020-04-30', date_due) <=180 THEN '91-180 days'
    WHEN  DATEDIFF ('2020-04-30', date_due) > 180 AND DATEDIFF ('2020-04-30', date_due) <=365 THEN '181-365 days'
    ELSE '> 365 days'
END AS time_bucket
 
FROM debt;

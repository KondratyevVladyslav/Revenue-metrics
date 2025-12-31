WITH monthly_revenue AS (
    SELECT
        DATE(DATE_TRUNC('month', payment_date)) AS payment_month,
        user_id,
        SUM(revenue_amount_usd) AS total_revenue,
        SUM(revenue_amount_usd) AS MRR     
    FROM project.games_payments gp
    GROUP BY payment_month, user_id
),
 dates AS ( SELECT
    payment_month,
    user_id,
    total_revenue,MRR,
    DATE(payment_month - INTERVAL '1 month') AS previous_calendar_month,
    DATE(payment_month + INTERVAL '1 month') AS next_calendar_month,
    LAG(total_revenue) OVER (PARTITION BY user_id ORDER BY payment_month) AS previous_paid_month_revenue,
    LAG(payment_month) OVER (PARTITION BY user_id ORDER BY payment_month) AS previous_paid_month,
    LEAD(payment_month) OVER (PARTITION BY user_id ORDER BY payment_month) AS next_paid_month
FROM monthly_revenue),
metrics   AS (SELECT
    payment_month,
    user_id,
    total_revenue,MRR,
    CASE WHEN previous_paid_month IS NULL THEN total_revenue END AS new_MRR,
    CASE WHEN previous_paid_month IS NULL THEN 1 END AS new_paid_users,
    CASE WHEN next_paid_month IS NULL OR next_paid_month != next_calendar_month THEN total_revenue END AS churned_revenue,
    CASE WHEN next_paid_month IS NULL OR next_paid_month != next_calendar_month THEN 1 END AS churned_users,
    CASE WHEN  previous_paid_month = previous_calendar_month
         AND  total_revenue > previous_paid_month_revenue
         THEN  total_revenue - previous_paid_month_revenue
END  AS  expansion_revenue,
   CASE  WHEN  previous_paid_month = previous_calendar_month
AND  total_revenue < previous_paid_month_revenue 
THEN  total_revenue - previous_paid_month_revenue
END AS  contraction_revenue,CASE 
    WHEN  next_paid_month IS NULL  
    OR  next_paid_month != next_calendar_month
        THEN  next_calendar_month
END AS  churn_month
FROM dates )
SELECT  payment_month,
   metrics. user_id,
    total_revenue,MRR ,new_MRR ,churned_revenue, expansion_revenue,contraction_revenue,new_paid_users,gpu."language" ,gpu.has_older_device_model ,gpu.game_name ,gpu.age, 
     churned_users,churn_month FROM metrics LEFT JOIN project.games_paid_users gpu 
on metrics.user_id=gpu.user_id ;
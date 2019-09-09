-- LEAD
SELECT occurred_at, total_revenue,
LEAD(total_revenue) OVER (ORDER BY total_revenue) AS lead,
LEAD(total_revenue) OVER (ORDER BY total_revenue) - total_revenue AS lead_difference
FROM(SELECT occurred_at, SUM(total_amt_usd) total_revenue
     FROM orders
     GROUP BY 1) sub;

-- LAG
SELECT occurred_at, total_revenue,
LAG(total_revenue) OVER (ORDER BY total_revenue) AS lag,
total_revenue - LAG(total_revenue) OVER (ORDER BY total_revenue) AS lag_difference
FROM(SELECT occurred_at, SUM(total_amt_usd) total_revenue
     FROM orders
     GROUP BY 1) sub;

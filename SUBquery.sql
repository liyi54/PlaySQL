SELECT channel, AVG(num_events) avg_count
FROM(SELECT channel, DATE_TRUNC('day',occurred_at) day_, COUNT(*) num_events
    FROM web_events
    GROUP BY 1,2) sub
GROUP BY 1
ORDER BY 2 DESC;

SELECT AVG(standard_qty) std_avg, AVG(gloss_qty) gloss_avg, AVG(poster_qty) post_avg, SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = (SELECT DATE_TRUNC('month', MIN(occurred_at)) mth
    FROM orders);

-- Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
SELECT sub2.rep_name, sub1.region_name, sub1.max_sum
FROM(SELECT s.name rep_name, r.name reg_name, SUM(o.total_amt_usd) sum_total
     FROM sales_reps s
     JOIN region r
     ON r.id = s.region_id
     JOIN accounts a
     ON s.id = a.sales_rep_id
     JOIN orders o
     ON a.id = o.account_id
     GROUP BY 1,2) sub2
JOIN(SELECT foo.reg_name region_name, MAX(foo.sum_total) max_sum
     FROM(SELECT s.name rep_name, r.name reg_name, SUM(o.total_amt_usd) sum_total
          FROM sales_reps s
          JOIN region r
          ON r.id = s.region_id
          JOIN accounts a
          ON s.id = a.sales_rep_id
          JOIN orders o
          ON a.id = o.account_id
          GROUP BY 1,2) foo
      GROUP BY 1) sub1
ON sub1.region_name = sub2.reg_name AND sub1.max_sum = sub2.sum_total
ORDER BY 3 DESC;

-- For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?
SELECT sub.reg_name, sub.total_sales, sub.order_count
FROM(SELECT r.name reg_name, SUM(total_amt_usd) total_sales, COUNT(o.id) order_count
     FROM region r
     JOIN sales_reps s
     ON r.id = s.region_id
     JOIN accounts a
     ON s.id = a.sales_rep_id
    JOIN orders o
    ON a.id = o.account_id
    GROUP BY 1) sub
ORDER BY 2 DESC
LIMIT 1;

-- How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?
SELECT COUNT(*) FROM
(SELECT a.name, SUM(o.total) total_sales
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
HAVING(SUM(o.total))> (SELECT total_sales
FROM(SELECT a.name acct_name, SUM(o.standard_qty) total_std, SUM(total) total_sales
     FROM accounts a
     JOIN orders o
     ON a.id = o.account_id
     GROUP BY 1
     ORDER BY 2 DESC
     LIMIT 1) foo)
)foo1;

-- For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?
SELECT a.name, w.channel, COUNT(w.occurred_at)
FROM web_events w
JOIN accounts a
ON a.id = w.account_id AND a.name = (SELECT cust_name FROM
    (SELECT a.name cust_name, SUM(o.total_amt_usd) total_amt_spent
    FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 1) sub)
GROUP BY 1,2
ORDER BY 3 DESC;

-- What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
SELECT AVG(total_spent) lt_avg
FROM(SELECT a.name cust_name, SUM(total_amt_usd) total_spent
     FROM accounts a
     JOIN orders o
     ON a.id = o.account_id
     GROUP BY 1
     ORDER BY 2 DESC
     LIMIT 10) sub;

-- What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.

SELECT AVG(avg_sum) FROM(
SELECT a.name, AVG(o.total_amt_usd) avg_sum
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) order_avg
FROM orders o)) foo;

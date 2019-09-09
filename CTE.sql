-- Using a previous subquery as an example
WITH query1 AS (SELECT foo.reg_name region_name, MAX(foo.sum_total) max_sum
     FROM(SELECT s.name rep_name, r.name reg_name, SUM(o.total_amt_usd) sum_total
          FROM sales_reps s
          JOIN region r
          ON r.id = s.region_id
          JOIN accounts a
          ON s.id = a.sales_rep_id
          JOIN orders o
          ON a.id = o.account_id
          GROUP BY 1,2) foo
      GROUP BY 1),

      query2 AS (SELECT s.name rep_name, r.name reg_name, SUM(o.total_amt_usd) sum_total
           FROM sales_reps s
           JOIN region r
           ON r.id = s.region_id
           JOIN accounts a
           ON s.id = a.sales_rep_id
           JOIN orders o
           ON a.id = o.account_id
           GROUP BY 1,2)

SELECT query2.rep_name, query1.region_name, query1.max_sum
FROM query2
JOIN query1
ON query1.region_name = query2.reg_name AND query1.max_sum = query2.sum_total
ORDER BY 3 DESC;

-- Using a previous subquery as an example
WITH query1 AS (SELECT r.name reg_name, SUM(total_amt_usd) total_sales, COUNT(o.id) order_count
     FROM region r
     JOIN sales_reps s
     ON r.id = s.region_id
     JOIN accounts a
     ON s.id = a.sales_rep_id
     JOIN orders o
     ON a.id = o.account_id
     GROUP BY 1)

SELECT reg_name, total_sales, order_count
FROM query1
ORDER BY 2 DESC
LIMIT 1;

-- Using a previous subquery as an example
WITH query1 AS (SELECT a.name acct_name, SUM(o.standard_qty) total_std, SUM(total) total_sales
     FROM accounts a
     JOIN orders o
     ON a.id = o.account_id
     GROUP BY 1
     ORDER BY 2 DESC
     LIMIT 1),

     query2 AS (SELECT total_sales FROM query1),

     query3 AS (SELECT a.name, SUM(o.total) total_sales
     FROM accounts a
     JOIN orders o
     ON a.id = o.account_id
     GROUP BY 1
     HAVING SUM(o.total) > (SELECT total_sales FROM query2))

SELECT COUNT(*) FROM query3;

-- Using a previous subquery as an example

WITH query1 AS (SELECT cust_name FROM
    (SELECT a.name cust_name, SUM(o.total_amt_usd) total_amt_spent
    FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 1) sub)

SELECT a.name, w.channel, COUNT(w.occurred_at)
FROM web_events w
JOIN accounts a
ON a.id = w.account_id AND a.name = (SELECT * FROM query1)
GROUP BY 1,2
ORDER BY 3 DESC;

-- Using a previous subquery as an example

WITH query1 AS (SELECT a.name cust_name, SUM(total_amt_usd) total_spent
     FROM accounts a
     JOIN orders o
     ON a.id = o.account_id
     GROUP BY 1
     ORDER BY 2 DESC
     LIMIT 10)

SELECT AVG(total_spent) lt_avg
FROM query1;

-- Using a previous subquery as an example

WITH query1 AS (SELECT AVG(o.total_amt_usd) order_avg
               FROM orders o),

     query2 AS (SELECT a.name, AVG(o.total_amt_usd) avg_sum
     FROM accounts a
     JOIN orders o
     ON a.id = o.account_id
     GROUP BY 1
     HAVING AVG(o.total_amt_usd) > (SELECT * FROM query1))

SELECT AVG(avg_sum) FROM query2;

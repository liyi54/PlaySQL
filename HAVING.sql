-- How many of the sales reps have more than 5 accounts that they manage?
SELECT s.name, COUNT(a.id) tally
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.name
HAVING COUNT(a.id) >5;

-- Using a subquery: Say you want to get just the number and not the actual entries
SELECT COUNT(*)
FROM(
        SELECT s.name, COUNT(a.id) tally
        FROM accounts a
        JOIN sales_reps s
        ON a.sales_rep_id = s.id
        GROUP BY s.name
        HAVING COUNT(a.id) > 5
    ) foo;

-- How many accounts have more than 20 orders?
SELECT a.name, COUNT(o.id) order_count
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING COUNT(o.id) > 20;

-- Which account has the most orders?
SELECT a.name, COUNT(o.id) order_count
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY order_count DESC
LIMIT 1;

-- How many accounts spent more than 30,000 usd total across all orders?
SELECT a.name, SUM(o.total_amt_usd) total_amt_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) >30000
ORDER BY total_amt_spent DESC;

-- How many accounts spent less than 1,000 usd total across all orders?
SELECT a.name, SUM(o.total_amt_usd) total_amt_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) <1000
ORDER BY total_amt_spent DESC;

-- Which account has spent the most with us?
SELECT a.name, SUM(o.total_amt_usd) total_amt_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_amt_spent DESC
LIMIT 1;

-- Which account has spent the least with us?
SELECT a.name, SUM(o.total_amt_usd) total_amt_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_amt_spent
LIMIT 1;

-- Which accounts used facebook as a channel to contact customers more than 6 times?
SELECT a.name, w.channel, COUNT(occurred_at) num_times
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.name, w.channel
HAVING COUNT(occurred_at) > 6
ORDER BY num_times;
-- OR
SELECT a.name, w.channel, COUNT(occurred_at) num_times
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.name, w.channel
HAVING COUNT(occurred_at) > 6 AND w.channel = 'facebook'
ORDER BY num_times;

-- Which account used facebook most as a channel?
SELECT a.name, w.channel, COUNT(occurred_at) num_times
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.name, w.channel
ORDER BY num_times DESC
LIMIT 1;

-- Which channel was most frequently used by most accounts?
SELECT DISTINCT a.name, channel, COUNT(occurred_at) frequency
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY 1, 2
ORDER BY frequency DESC;

-- SELECT MIN(o.occurred_at) earliest_order, a.name
-- FROM orders o
-- JOIN accounts a
-- ON o.account_id = a.id
-- GROUP BY a.name
-- ORDER BY a.name
-- LIMIT 1;

-- Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.
SELECT o.occurred_at, a.name
FROM orders o
JOIN accounts a
ON o.account_id = a.id
ORDER BY o.occurred_at
LIMIT 1;

-- Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.
SELECT SUM(total_amt_usd) sales_total, a.name comp_name
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name;

-- Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.
SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;

-- Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.
SELECT channel, COUNT(occurred_at) tally
FROM web_events
GROUP BY channel;

-- Who was the primary contact associated with the earliest web_event?
SELECT a.primary_poc, w.occurred_at
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at
LIMIT 1;

-- What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.
SELECT a.name, MIN(total_amt_usd) min_order
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY min_order;

-- Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.
SELECT r.name, COUNT(s.id) reps
FROM sales_reps s
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
ORDER BY reps;

-- For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.
SELECT a.name, AVG(gloss_qty) avg_gloss, AVG(poster_qty) avg_poster, AVG(standard_qty) avg_std
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name;

-- For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.
SELECT a.name, AVG(standard_amt_usd) std_avg, AVG(gloss_amt_usd) gloss_avg, AVG(poster_amt_usd) poster_avg
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name;

-- Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
SELECT s.name, w.channel, COUNT(w.occurred_at) tally
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY channel, tally DESC;

-- Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

SELECT r.name, w.channel, COUNT(w.occurred_at) tally
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON s.region_id = r.id
GROUP BY r.name, w.channel
ORDER BY tally DESC;

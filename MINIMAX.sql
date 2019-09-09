s-- When was the earliest order ever placed?
SELECT MIN(occurred_at) earliest_order
FROM orders;

-- Try performing the same query as in question 1 without using an aggregation function.
SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1;

-- When did the most recent (latest) web_event occur?
SELECT MAX(occurred_at)
FROM web_events;

-- Try to perform the result of the previous query without using an aggregation function.
SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;

-- Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.
SELECT AVG(standard_amt_usd) std_avg_amt, AVG(poster_amt_usd) post_avg_amt, AVG(gloss_amt_usd) gloss_avg_amt,
       AVG(standard_qty) std_avg, AVG(poster_qty) post_avg, AVG(gloss_qty) gloss_avg
FROM orders;

SELECT total_amt_usd
FROM(
SELECT row_number() OVER(ORDER BY total_amt_usd) AS rownumber, (COUNT(total_amt_usd)+1)/2 AS med_index
FROM orders
) AS foo
WHERE rownumber = med_index;

DECLARE @med_index uniqueidentifer = (SELECT (COUNT(total_amt_usd)-((COUNT(total_amt_usd)+1)/2)))
SELECT total_amt_usd,
FROM(
    SELECT total_amt_usd FROM orders
    ORDER BY total_amt_usd
) AS foo
LIMIT 1 OFFSET @med_index-1;

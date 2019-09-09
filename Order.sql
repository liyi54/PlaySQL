/*Order by ascending for the earliest 10 orders*/
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

/*Return top 5 largest orders in terms of total_amt_usd*/
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

/*Return least 20 orders in terms of total_amt_usd*/
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;

/*Return largest orders in descending order for each account ID in ascending order*/
SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;

/*Since the leftmost query is executed first, in this case the query returns the columns
ordered by the total_amt_usd first and the account_id can't be returned in ascending order*/
SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;

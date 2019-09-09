SELECT *
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
LIMIT 10;

SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.primary_poc, accounts.website
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
LIMIT 10;

/*Provide a table for all web_events associated with account name of Walmart.
There should be three columns. Be sure to include the primary_poc,
time of the event, and the channel for each event.
 Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.*/
SELECT a.name, w.occurred_at, a.primary_poc, w.channel
FROM web_events w
JOIN accounts a
ON w.account_id = a.id;

/*Provide a table for all web_events associated with account name of Walmart.
There should be three columns. Be sure to include the primary_poc,
time of the event, and the channel for each event.
 Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.*/
SELECT a.name, w.occurred_at, a.primary_poc, w.channel
FROM web_events AS w
JOIN accounts AS a
ON w.account_id = a.id;

-- Provide a table that provides the region for each sales_rep along with
-- their associated accounts. Your final table should include three columns:
-- the region name, the sales rep name, and the account name. Sort the accounts
-- alphabetically (A-Z) according to account name.
SELECT r.name AS reg_name, s.name As sales_name, a.name AS acct_name
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a
ON s.id = a.sales_rep_id
ORDER BY a.name;

-- Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.

SELECT r.name AS reg_name, a.name AS acct_name, o.total_amt_usd/(o.total+0.01) AS unit_price
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a
ON s.id = a.sales_rep_id
JOIN orders AS o
ON a.id = o.account_id;

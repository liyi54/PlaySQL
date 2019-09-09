/*First 5 orders that have a gloss_amt_usd>=1000*/
SELECT *
FROM orders
WHERE gloss_amt_usd >=1000
LIMIT 5;

/*First 10 orders that have a total_amt_usd<500*/
SELECT *
FROM orders
WHERE total_amt_usd<500
LIMIT 10;

/*Query returns results with Company name 'Exxon Mobil'*/
SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';

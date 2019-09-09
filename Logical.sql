/*All the companies whose names start with 'C'. */
SELECT *
FROM accounts
WHERE name LIKE 'C%';

/*All companies whose names contain the string 'one' somewhere in the name.*/
SELECT *
FROM accounts
WHERE name LIKE '%one%';

/*All companies whose names end with 's'.*/
SELECT *
FROM accounts
WHERE name LIKE '%s';

/*Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.*/
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN('Walmart', 'Target', 'Nordstrom');

/*Use the web_events table to find all information regarding
individuals who were contacted via the channel of organic or adwords.*/
SELECT *
FROM web_events
WHERE channel IN('organic','adwords');

/*Same operation as the above using an OR operator*/
SELECT *
FROM web_events
WHERE channel LIKE '%organic%' OR channel LIKE '%adwords%';

/*Find list of orders ids where either gloss_qty or poster_qty is greater
than 4000. Only include the id field in the resulting table.*/
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

/*Write a query that returns a list of orders where the standard_qty
is zero and either the gloss_qty or poster_qty is over 1000.*/
SELECT *
FROM orders
WHERE standard_qty=0 AND (gloss_qty>1000 OR poster_qty>1000);

/*Find all the company names that start with a 'C' or 'W', and the primary
contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.*/
SELECT name
FROM accounts
WHERE (name LIKE 'C%' or name LIKE 'W%') AND ((primary_poc LIKE '%ana%' or primary_poc LIKE '%Ana%')
AND (primary_poc NOT LIKE '%eana%'));

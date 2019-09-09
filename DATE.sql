-- Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?
SELECT DATE_PART('year', occurred_at), SUM(total_amt_usd) total_dollars
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

-- Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?
-- In order for this to be 'fair', we should remove the sales from 2013 and 2017. For the same reasons as discussed above.
SELECT DATE_PART('month', occurred_at), SUM(total_amt_usd) total_dollars
FROM orders
WHERE occured_at BETWEEN '2014-01-01' AND '2016-12-31'
GROUP BY 1
ORDER BY 2 DESC;

-- Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?
SELECT DATE_PART('year', occurred_at ), COUNT(id) order_count
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

-- Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?
SELECT DATE_PART('month', occurred_at ), COUNT(id) order_count
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017'
GROUP BY 1
ORDER BY 2 DESC;

-- In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
SELECT a.name, DATE_TRUNC('month', occurred_at), SUM(gloss_amt_usd) gloss_usd
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 1;

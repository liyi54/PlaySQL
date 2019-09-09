/**
THe Limit command limits the number of rows returned from the query to the number set e.g
in this query, only 15 rows will be returned
The Limit command always appears last in any SQL query
*/
SELECT occured_at, account_id, channel
FROM web_events
LIMIT 15;

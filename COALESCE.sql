SELECT
a.id, COALESCE(a.id,a.id) modified_id, o.id, COALESCE(o.id,a.id) modified_id2,
standard_qty, COALESCE(standard_qty,'0') modified_stdqty, gloss_qty, COALESCE(gloss_qty,'0') modified_glossqty,
poster_qty, COALESCE(poster_qty,'0') modified_posterqty, standard_amt_usd, COALESCE(standard_amt_usd,'0') modified_std_amt_usd,
gloss_amt_usd, COALESCE(gloss_amt_usd,'0') modified_gloss_amt_usd, poster_amt_usd, COALESCE(poster_amt_usd,'0') modified_poster_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;


SELECT COUNT(COALESCE(o.id,a.id))
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;

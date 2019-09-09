SELECT a.name acct_name, a.primary_poc, s.name rep_name
FROM accounts a
LEFT JOIN sales_reps s
ON a.sales_rep_id = s.id AND a.primary_poc < s.name;

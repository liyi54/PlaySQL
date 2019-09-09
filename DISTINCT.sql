-- Use DISTINCT to test if there are any accounts associated with more than one region.
SELECT DISTINCT a.name, COUNT(s.region_id) reg_count
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY a.name;

-- Have any sales reps worked on more than one account?
SELECT DISTINCT s.name, COUNT(a.id) tally
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.name;

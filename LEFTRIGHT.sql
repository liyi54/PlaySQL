-- In the accounts table, there is a column holding the website for each company. The last three digits specify what type of web address they are using. A list of extensions (and pricing) is provided here. Pull these extensions and provide how many of each website type exist in the accounts table.
SELECT RIGHT(website, 4) AS domain, COUNT(RIGHT(website, 4)) AS domain_count
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

-- There is much debate about how much the name (or even the first letter of a company name) matters. Use the accounts table to pull the first letter of each company name to see the distribution of company names that begin with each letter (or number).
SELECT LEFT(name, 1) AS first_letter, COUNT(LEFT(name, 1)) AS letter_count
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

-- Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number and a second group of those company names that start with a letter. What proportion of company names start with a letter?
SELECT
CASE WHEN LEFT(name, 1) IN('1','2','3','4','5','6','7','8','9','0') THEN 'number'
ELSE 'letter' END AS category, COUNT(LEFT(name, 1)) AS category_count
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

-- OR
SELECT SUM(num) nums, SUM(letter) letters FROM
(SELECT name, CASE WHEN LEFT(UPPER(name),1) IN ('1','2','3','4','5','6','7','8','9','0')
              THEN 1 ELSE 0 END AS num,
              CASE WHEN LEFT(UPPER(name),1) IN ('1','2','3','4','5','6','7','8','9','0')
              THEN 0 ELSE 1 END AS letter
 FROM accounts) sub;


-- Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with anything else?
SELECT 
CASE WHEN LEFT(UPPER(name), 1) IN('A','E','I','O','U') THEN 'vowels'
ELSE 'others' END AS starts_with, COUNT(LEFT(name, 1)) proportion
FROM accounts
GROUP BY 1;

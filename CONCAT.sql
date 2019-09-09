-- Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.

-- You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work in an email address. See if you can create an email address that will work by removing all of the spaces in the account name, but otherwise your solution should be just as in question 1
SELECT name, primary_poc, CONCAT(LEFT(LOWER(primary_poc), POSITION(' ' IN primary_poc)-1),
'.',RIGHT(LOWER(primary_poc), LENGTH(primary_poc) - POSITION(' ' IN primary_poc)),'@',
LOWER(REPLACE(name, ' ','')),'.com')
FROM accounts;

-- We would also like to create an initial password, which they will change after their first log in. The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name, the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces.

WITH sub AS (SELECT LEFT(LOWER(primary_poc), POSITION(' ' IN primary_poc)-1) fname,
            RIGHT(LOWER(primary_poc), LENGTH(primary_poc) - POSITION(' ' IN primary_poc)) lname,
            REPLACE(name, ' ','') company_name
            FROM accounts)

SELECT fname, lname,
CONCAT(LEFT(fname,1), RIGHT(fname,1), LEFT(lname,1), RIGHT(lname,1), LENGTH(fname),LENGTH(lname),
UPPER(company_name)) AS password
FROM sub;

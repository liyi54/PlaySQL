SELECT *
FROM sf_crime_data
LIMIT 10;

SELECT date orig_date, CAST(substring(date,7,4) || '-' || substring(date,1,2) || '-' || substring(date,4,2) AS date) AS new_date
FROM
sf_crime_data
LIMIT 10;

SELECT date orig_date, (substring(date,7,4) || '-' || substring(date,1,2) || '-' || substring(date,4,2 ))::date AS new_date
FROM
sf_crime_data
LIMIT 10;

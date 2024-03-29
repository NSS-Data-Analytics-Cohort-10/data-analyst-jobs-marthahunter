-- The dataset for this exercise has been derived from the Indeed Data Scientist/Analyst/Engineer dataset on kaggle.com. Before beginning to answer questions, take some time to review the data dictionary and familiarize yourself with the data that is contained in each column. Provide the SQL queries and answers for the following questions/tasks using the data_analyst_jobs table you have created in PostgreSQL:

-- #1. How many rows are in the data_analyst_jobs table?

SELECT COUNT (*)
FROM data_analyst_jobs;

-- 1793

-- #2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM data_analyst_jobs
LIMIT 10;

-- ExxonMobil

-- #3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

SELECT (location)
FROM data_analyst_jobs
WHERE location = 'TN';

-- 21 in TN

SELECT (location)
FROM data_analyst_jobs
WHERE location = 'TN' OR location = 'KY';

-- 27 in TN or KY

-- #4. How many postings in Tennessee have a star rating above 4?

SELECT (location, star_rating)
FROM data_analyst_jobs
WHERE location = 'TN' AND star_rating > 4;

-- 3 

-- #5. How many postings in the dataset have a review count between 500 and 1000?

SELECT (title, review_count)
FROM data_analyst_jobs
WHERE review_count
BETWEEN 500 AND 1000;

-- 151

-- #6. Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?

SELECT AVG (star_rating), location
FROM data_analyst_jobs
GROUP BY location
ORDER BY avg DESC;

-- Nebraska (NE) is highest with an average rating of 4.1999998090000000

-- #7. Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT DISTINCT (title)
FROM data_analyst_jobs;

-- 881

-- #8. How many unique job titles are there for California companies?

SELECT DISTINCT (title), location
FROM data_analyst_jobs
WHERE location = 'CA';

-- 230

-- #9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT AVG (star_rating), company, review_count
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company, review_count;

-- 46

-- #10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT AVG (star_rating), company, review_count
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company, review_count
ORDER BY avg DESC;

-- Microsoft: 4.1999998090000000 (Runners up: Unilever, Nike, Kaiser Permanente, AmEx, General Motors)

-- #11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?

SELECT (title)
FROM data_analyst_jobs
WHERE title LIKE '%Analyst' 
OR title LIKE 'Analyst%' 
OR title = 'Analyst';

-- 1083 total titles

SELECT DISTINCT (title)
FROM data_analyst_jobs
WHERE title LIKE '%Analyst' 
OR title LIKE 'Analyst%' 
OR title = 'Analyst';

-- 330 distinct titles

-- #12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

SELECT (title)
FROM data_analyst_jobs
WHERE title NOT iLIKE '%Analyst%'
AND title NOT iLIKE '%Analytics%';

-- 4 total titles

SELECT DISTINCT (title)
FROM data_analyst_jobs
WHERE title NOT iLIKE '%Analyst%'
AND title NOT iLIKE '%Analytics%';

-- 4 distinct titles

-- BONUS: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.

SELECT title, domain, skill, days_since_posting
FROM data_analyst_jobs
WHERE skill LIKE '%SQL%'
AND days_since_posting > 21
ORDER BY domain;

-- 619

-- Disregard any postings where the domain is NULL.

SELECT title, domain, skill, days_since_posting
FROM data_analyst_jobs
WHERE domain IS NOT NULL
AND skill LIKE '%SQL%'
AND days_since_posting > 21
ORDER BY domain;

-- 403

-- Order your results so that the domain with the greatest number of hard to fill jobs is at the top.

SELECT domain, COUNT(title) as hard_to_fill_count
FROM data_analyst_jobs
WHERE domain IS NOT NULL
AND skill LIKE '%SQL%'
AND days_since_posting > 21
GROUP BY domain
ORDER BY hard_to_fill_count DESC;

-- Which four industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?

-- Internet and Software: 62
-- Banks and Financial Services: 61
-- Consulting and Business Services: 57
-- Health Care: 52
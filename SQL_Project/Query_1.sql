/* Question : what are the top paying Data Analyst jobs

- Top 10 that are available remotely
- With specified salaries(remove nulls)
- Also mention company names for the respected jobs

*/

SELECT 
    job.job_id,
    company.name,
    job.job_title_short,
    job.job_location,
    job.job_schedule_type,
    job.salary_year_avg,
    job.job_posted_date
FROM
    job_postings_fact as job
LEFT JOIN
    company_dim as company
ON
    company.company_id = job.company_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10


/*
    Question - Skills required for the top paying data analyst jobs
- Add the specific skills to the previous data of top 10 highest paying jobs
*/


with top_jobs AS(
    SELECT 
        job_id,
        name as company__name,
        job_title_short,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim 
    ON
        company_dim.company_id = job_postings_fact.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT
        10
)

SELECT 
    top_jobs.*,
    skills
FROM
    top_jobs
INNER JOIN
    skills_job_dim ON skills_job_dim.job_id = top_jobs.job_id
INNER JOIN
    skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY
    top_jobs.salary_year_avg DESC

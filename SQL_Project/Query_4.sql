/* what are the top skills based on salary

-average salary associated with each skill 
-focus on roles with specified salary , regardless of location

*/

SELECT 
    skills_dim.skills,
    round(AVG(salary_year_avg),0) as average_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skills
ORDER BY
    average_salary DESC

LIMIT 25
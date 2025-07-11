/* Question: what are the top 10 skills that are required for the data analyst role

- Find the total number of jobs associated with the respected skills
- order the skills according to the demand in the sector 

*/


WITH demanding_skills AS(
    SELECT
        count(job_postings_fact.job_id) as skill_count,
        skills_job_dim.skill_id
    FROM
        skills_job_dim
    INNER JOIN
        job_postings_fact
    ON
        job_postings_fact.job_id = skills_job_dim.job_id
    WHERE
        job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

-- SELECT * FROM demanding_skills
SELECT
    demanding_skills.skill_count,
    skills_dim.skills AS Skills
FROM
    skills_dim
INNER JOIN
    demanding_skills
ON
    skills_dim.skill_id = demanding_skills.skill_id
ORDER BY 
    skill_count DESC
LIMIT 10


/* there is one more method fir solving this problem 
*/

SELECT 
    count(*) as demand_count,
    skills_dim.skills
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY
    skills_dim.skills
ORDER BY
    demand_count DESC

LIMIT 10

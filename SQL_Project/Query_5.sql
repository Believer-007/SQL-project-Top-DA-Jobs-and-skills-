-- 5-Most optimal skills to learn for Data Analyst (high demand and high paying)

WITH optimal_skills AS (
    SELECT
        skills_dim.skill_id,
        skills,
        count(*) as demand_count
    FROM
        job_postings_fact 
    INNER JOIN
        skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN
        skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst' AND
        job_postings_fact.salary_year_avg IS NOT NULL AND
        job_postings_fact.job_location = 'Anywhere'
    GROUP BY
         skills_dim.skill_id
), average_sal AS (
    SELECT 
        skills_dim.skill_id,
        skills,
        round(AVG(salary_year_avg),0) as average_salary
    FROM
        job_postings_fact
    INNER JOIN
        skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst' AND
        job_postings_fact.salary_year_avg IS NOT NULL AND
        job_postings_fact.job_location = 'Anywhere'
    GROUP BY
         skills_dim.skill_id

)

SELECT
    optimal_skills.skill_id,
    average_sal.skills,
    optimal_skills.demand_count,
    average_sal.average_salary
FROM
    average_sal
INNER JOIN
    optimal_skills ON average_sal.skill_id = optimal_skills.skill_id
ORDER BY
    optimal_skills.demand_count DESC
LIMIT 5


-- we can solve this problem by using short code also 

SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) as demand_count,
        round(avg(job_postings_fact.salary_year_avg),0) as average_salary
    FROM
        job_postings_fact 
    INNER JOIN
        skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN
        skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst' AND
        job_postings_fact.salary_year_avg IS NOT NULL AND
        job_postings_fact.job_location = 'Anywhere'
    GROUP BY
         skills_dim.skill_id
    HAVING
        count(skills_job_dim.job_id) > 10
    ORDER BY
        average_salary DESC,
        demand_count DESC
    LIMIT 5


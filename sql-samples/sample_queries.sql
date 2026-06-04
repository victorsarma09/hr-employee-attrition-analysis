-- Attrition Rate by Department
SELECT department,
       COUNT(*) AS total_employees,
       SUM(attrition_flag) AS attrition_count,
       ROUND(SUM(attrition_flag) * 100.0 / COUNT(*), 1) AS attrition_rate
FROM hr_analytics
GROUP BY department
ORDER BY attrition_rate DESC;

-- Attrition Rate by Salary Slab
SELECT salary_slab,
       COUNT(*) AS total_employees,
       SUM(attrition_flag) AS attrition_count,
       ROUND(SUM(attrition_flag) * 100.0 / COUNT(*), 1) AS attrition_rate
FROM hr_analytics
GROUP BY salary_slab
ORDER BY
CASE salary_slab
    WHEN 'Upto 5k' THEN 1
    WHEN '5k-10k' THEN 2
    WHEN '10k-15k' THEN 3
    WHEN '15k+' THEN 4
END;

--  Attrition Rate by Years Since Last Promotion 
SELECT
CASE
    WHEN years_since_last_promotion = 0 THEN 'Just Promoted'
    WHEN years_since_last_promotion <= 2 THEN '1-2 Years'
    WHEN years_since_last_promotion <= 5 THEN '3-5 Years'
    ELSE '5+ Years (Stagnant)'
END AS promotion_bucket,
COUNT(*) AS total_employees,
SUM(attrition_flag) AS attrition_count,
ROUND(SUM(attrition_flag) * 100.0 / COUNT(*), 1) AS attrition_rate
FROM hr_analytics
GROUP BY promotion_bucket
ORDER BY MIN(years_since_last_promotion);

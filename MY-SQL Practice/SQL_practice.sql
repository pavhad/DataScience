Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. Output just the absolute difference in salaries.

SELECT  ABS(MAX(CASE WHEN department = 'marketing' THEN salary ELSE NULL END) -
MAX(CASE WHEN department = 'engineering' THEN salary ELSE NULL END)) AS DIFF

FROM db_employee de 
LEFT JOIN db_dept dd 
ON de.department_id = dd.id;


Find the average score for grades A, B, and C.
Output the results along with the corresponding grade (ex: 'A', avg(score))



select 'A',(AVG(CASE WHEN grade = 'A' THEN score ELSE NULL END)) as avg_A,
'B',(AVG(CASE WHEN grade = 'B' THEN score ELSE NULL END))  as avg_B,
'C',(AVG(CASE WHEN grade = 'C' THEN score ELSE NULL END))  as avg_C
from los_angeles_restaurant_health_inspections;



Find the number of employees in each department.
Output the department name along with the corresponding number of employees.
Sort records based on the number of employees in descending order.




select department, COUNT(*)  from employee group by department;


We have a table with employees and their salaries, however, some of the records are old and contain outdated salary information. Find the current salary of each employee assuming that salaries increase each year. Output their id, first name, last name, department ID, and current salary. Order your list by employee ID in ascending order.

WITH CTE AS (
    SELECT  *
          ,row_number() OVER(PARTITION BY first_name ORDER BY salary desc) AS row_num
    FROM    ms_employee_salary
)
SELECT  id, first_name, last_name, department_ID,salary
FROM    CTE
WHERE   row_num = 1
ORDER BY ID asc;





SELECT user_id, AVG(TIMESTAMPDIFF(SECOND, load_time, exit_time)) AS session_time
FROM (
    SELECT 
        DATE(timestamp), 
        user_id, 
        MAX(IF(action = 'page_load', timestamp, NULL)) as load_time,
        MIN(IF(action = 'page_exit', timestamp, NULL)) as exit_time
    FROM facebook_web_log
    GROUP BY 1, 2
) t 
GROUP BY user_id
HAVING session_time IS NOT NULL;
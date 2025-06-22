-- Task 3: Find Employees Without an Assigned Manager (Self-Join)
-- Scenario: You have an employees table where each employee (except the CEO)
-- has a manager_id that refers to another employee_id in the same table.
-- Find all employees who do not have a manager assigned
-- (i.e., their manager_id is NULL). Then, find all employees
-- who are not managers themselves but report to someone.
--
-- employee_id	employee_name	manager_id
-- 1	Alice	NULL
-- 2	Bob	1
-- 3	Charlie	1
-- 4	David	2
-- 5	Eve	NULL

-- Expected Output 1 (Employees without a manager):
-- employee_name
-- Alice
-- Eve
--
-- Expected Output 2 (Employees who report to someone but are not managers themselves):
--
-- employee_name	manager_name
-- David	Bob

--Solution: Output 1 (Employees without a manager):
SELECT
    employee_name
FROM
    employees
WHERE
    manager_id IS NULL;

-- Solution (Part 2: Employees who report to someone but are not managers themselves):
SELECT
    e.employee_name,
    m.employee_name as manager_name
FROM
    employees e
INNER JOIN
    employees m ON e.manager_id = m.employee_id
WHERE
    e.employee_id NOT IN (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL)
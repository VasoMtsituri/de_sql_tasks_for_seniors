-- Step 1: Generate a complete set of records for every employee for every working day.
-- A working day is any day where at least one employee's attendance is recorded.
-- We create a cartesian product between all employees and all unique working days.
AllEmployeeDays AS (
    SELECT
        e.employee_id,
        e.employee_name,
        d.attendance_date
    FROM
        Employees e
    CROSS JOIN
        (SELECT DISTINCT attendance_date FROM Attendance) d
)

-- Step 2: Find the absences by selecting records from the complete set
-- that do not have a corresponding entry in the Attendance table.
-- Using NOT EXISTS is often more efficient than a LEFT JOIN for this pattern.
SELECT
    aed.employee_name,
    aed.attendance_date AS absent_date
FROM
    AllEmployeeDays aed
WHERE
    NOT EXISTS (
        SELECT 1
        FROM Attendance a
        WHERE a.employee_id = aed.employee_id
          AND a.attendance_date = aed.attendance_date
    )
ORDER BY
    aed.employee_name,
    aed.attendance_date;
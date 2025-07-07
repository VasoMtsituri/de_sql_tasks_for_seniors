-- Step 1: Identify all unique dates that are considered "working days".
-- A working day is any day where at least one employee's attendance is recorded.
WITH WorkingDays AS (
    SELECT DISTINCT date
    FROM working_days
),

-- Step 2: Generate a complete set of records for every employee for every working day.
-- This creates a baseline of all possible attendance records that should exist.
AllPossibleAttendance AS (
    SELECT
        wd.date,
        e.emp_id,
        e.emp_name
    FROM WorkingDays wd
    CROSS JOIN emp_absence e -- Create a row for each employee for each working day
),

-- Step 3: Find the absences by comparing the complete set of possible attendances
-- with the actual recorded attendances.
-- We use a LEFT JOIN and look for records where there is no matching attendance.
Absences AS (
    SELECT
        apa.emp_name,
        apa.date
    FROM AllPossibleAttendance apa
    LEFT JOIN working_days a ON apa.emp_id = a.emp_id AND apa.date = a.date
    WHERE a.emp_id IS NULL -- If the join finds no match, the employee was absent
)

-- Final Step: Select the results to display the employee names and their absent dates.
SELECT
    emp_name,
    date AS absent_date
FROM Absences
ORDER BY
    emp_name,
    absent_date;
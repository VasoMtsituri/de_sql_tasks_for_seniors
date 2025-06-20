-- Task 1: Calculate Rolling 3-Day Average of Daily Sales
-- Scenario: You have a table of daily sales transactions.
-- You need to calculate the rolling 3-day average of sales amount for each day.
--
-- sale_date	amount
-- 2025-01-01	100
-- 2025-01-02	150
-- 2025-01-03	120
-- 2025-01-04	200
-- 2025-01-05	130
-- 2025-01-06	180
-- 2025-01-07	110
--

-- Expected output:
-- sale_date	daily_sales	rolling_avg_3_day
-- 2025-01-01	100	100.00
-- 2025-01-02	150	125.00
-- 2025-01-03	120	123.33
-- 2025-01-04	200	156.67
-- 2025-01-05	130	150.00
-- 2025-01-06	180	170.00
-- 2025-01-07	110	140.00

WITH daily_sales AS (
    SELECT
        sale_date,
        SUM(amount) AS daily_sales
    FROM
        sales
    GROUP BY
        sale_date
)

SELECT
    sale_date,
    daily_sales,
    AVG(daily_sales) OVER (ORDER BY sale_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_avg_3_day
FROM
    daily_sales
ORDER BY
    sale_date
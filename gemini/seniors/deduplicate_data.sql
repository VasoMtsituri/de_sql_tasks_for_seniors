-- Task 2: Deduplicate Records and Keep the Latest One
-- Scenario: You have a user events log where events might be recorded
-- multiple times due to system retries or inconsistencies.
-- You need to get the most recent (latest) event for each unique (user_id,event_type) combination.
--
-- event_id	user_id	event_timestamp	     event_type
-- 101	    1	    2025-05-01 10:00:00	 login
-- 102	    2	    2025-05-01 10:05:00	 logout
-- 103	    1	    2025-05-01 10:01:00	 login
-- 104	    3	    2025-05-01 10:10:00	 view_product
-- 105	    2	    2025-05-01 10:06:00	 logout
-- 106	    1	    2025-05-01 10:02:00	 login
-- 107	    3	    2025-05-01 10:11:00	 view_product

-- Expected output:
-- event_id	user_id	event_timestamp	event_type
-- 106	1	2025-05-01 10:02:00	login
-- 105	2	2025-05-01 10:06:00	logout
-- 107	3	2025-05-01 10:11:00	view_product

WITH rank_cte AS (
    SELECT
        event_id,
        user_id,
        event_timestamp,
        event_type,
        ROW_NUMBER() OVER (
            PARTITION BY user_id, event_type
            ORDER BY event_timestamp DESC, event_id DESC
        ) AS rn
    FROM
        user_events
)

SELECT
    event_id,
    user_id,
    event_timestamp,
    event_type
FROM rank_cte
WHERE
    rn=1
ORDER BY
    user_id, event_type;

WITH user_first_session AS (
    SELECT
        user_id,
        MIN(session_start) AS first_session_time,
        DATE(MIN(session_start)) AS user_cohort_date
    FROM {{ ref('int_sessions') }}
    GROUP BY user_id
),

user_purchase_journey AS (
    SELECT
        s.user_id,
        u.user_cohort_date,
        s.session_number,
        s.session_duration,
        s.purchase_count,
        CASE WHEN s.purchase_count > 0 THEN 1 ELSE 0 END AS has_purchase
    FROM {{ ref('int_sessions') }} s
    LEFT JOIN user_first_session u ON s.user_id = u.user_id
),

user_first_purchase AS (
    SELECT
        user_id,
        MIN(session_number) AS first_purchase_session
    FROM user_purchase_journey
    WHERE has_purchase = 1
    GROUP BY user_id
),

sessions_before_purchase AS (
    SELECT
        j.user_cohort_date,
        j.session_number AS first_purchase_session,
        j.session_duration
    FROM user_purchase_journey j
    LEFT JOIN user_first_purchase fp ON j.user_id = fp.user_id
    WHERE j.session_number < fp.first_purchase_session
)

SELECT
    user_cohort_date,
    ARRAY_AGG(first_purchase_session ORDER BY first_purchase_session) AS sessions_array,
    ARRAY_AGG(session_duration ORDER BY session_duration) AS durations_array,
    COUNT(*) AS total_count
FROM sessions_before_purchase
GROUP BY user_cohort_date
WITH data AS (
    SELECT *
    FROM {{ ref('int_customer_journey_data') }}
)
SELECT
    user_cohort_date,
    CASE 
        WHEN MOD(total_count, 2) = 1 THEN 
            -- Odd count: single middle element
            CAST(sessions_array[SAFE_OFFSET(DIV(total_count+1,2)-1)] AS FLOAT64)
        ELSE 
            -- Even count: average of the two middle elements
            (
                CAST(sessions_array[SAFE_OFFSET(DIV(total_count,2)-1)] AS FLOAT64) 
                + CAST(sessions_array[SAFE_OFFSET(DIV(total_count,2))] AS FLOAT64)
            ) / 2
    END AS median_sessions_before_purchase,
    CASE 
        WHEN MOD(total_count, 2) = 1 THEN 
            CAST(durations_array[SAFE_OFFSET(DIV(total_count+1,2)-1)] AS FLOAT64)
        ELSE 
            (
                CAST(durations_array[SAFE_OFFSET(DIV(total_count,2)-1)] AS FLOAT64) 
                + CAST(durations_array[SAFE_OFFSET(DIV(total_count,2))] AS FLOAT64)
            ) / 2
    END AS median_session_duration_before_purchase
FROM data
ORDER BY user_cohort_date
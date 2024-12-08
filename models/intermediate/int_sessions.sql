WITH events AS (
    SELECT
        user_id,
        event_timestamp,
        event_type,
        product_id,
        referrer
    FROM {{ ref('stg_events_flat_partitioned_clustered') }}
    WHERE user_id IS NOT NULL
),

session_boundaries AS (
    SELECT
        e.*,
        CASE WHEN prev_event_timestamp IS NULL 
            OR TIMESTAMP_DIFF(event_timestamp, prev_event_timestamp, MINUTE) > 30 
            THEN 1 
            ELSE 0 
        END AS is_new_session
    FROM 
    (SELECT
        events.*,
        LAG(event_timestamp) OVER (PARTITION BY user_id ORDER BY event_timestamp) AS prev_event_timestamp
        FROM events ) AS e
),

assigned_sessions AS (
    SELECT
        *,
        SUM(is_new_session) OVER (PARTITION BY user_id ORDER BY event_timestamp) AS session_number
    FROM session_boundaries
)

SELECT
    user_id,
    session_number,
    CONCAT(CAST(user_id AS STRING), "_", CAST(session_number AS STRING)) AS session_id,
    MIN(event_timestamp) AS session_start,
    MAX(event_timestamp) AS session_end,
    TIMESTAMP_DIFF(MAX(event_timestamp), MIN(event_timestamp), SECOND) AS session_duration,
    COUNT(*) AS event_count,
    COUNT(DISTINCT product_id) AS unique_products_viewed,
    COUNTIF(event_type = "search") AS search_count,
    COUNTIF(event_type = "page_view") AS page_view_count,
    COUNTIF(event_type = "add_product_to_cart") AS add_to_cart_count,
    COUNTIF(event_type = "placed_order") AS purchase_count,
    ARRAY_AGG(referrer ORDER BY event_timestamp LIMIT 1)[SAFE_OFFSET(0)] AS referrer
FROM assigned_sessions
GROUP BY user_id, session_number

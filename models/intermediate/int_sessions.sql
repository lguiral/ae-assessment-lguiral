WITH base AS (
    SELECT
        user_id,
        event_timestamp,
        event_type,
        referrer,
        product_id,
        query,
        os_device,
        ip_address,
        search_engine,
        event_id,
        page_source,
        event_date,
        LAG(event_timestamp) OVER (PARTITION BY user_id ORDER BY event_timestamp) AS previous_event_time
    FROM {{ ref('stg_events_flat_partitioned_clustered') }}
),

sessionized AS (
    SELECT
        *,
        CASE
            WHEN TIMESTAMP_DIFF(event_timestamp, previous_event_time, MINUTE) > 30 THEN 1
            ELSE 0
        END AS is_new_session
    FROM base
),

assign_session_ids AS (
    SELECT
        *,
        SUM(is_new_session) OVER (PARTITION BY user_id ORDER BY event_timestamp) AS session_number
    FROM sessionized
)

SELECT
    user_id,
    session_number,
    MIN(event_timestamp) AS session_start,
    MAX(event_timestamp) AS session_end,
    COUNT(*) AS event_count,
    COUNTIF(event_type = "page_view") AS page_view_count,
    COUNTIF(event_type = "add_product_to_cart") AS add_to_cart_count,
    COUNTIF(event_type = "placed_order") AS placed_order_count,
    referrer
FROM assign_session_ids
GROUP BY user_id, session_number, referrer

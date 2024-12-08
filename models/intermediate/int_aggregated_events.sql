WITH event_data AS (
    SELECT
        e.event_id,
        e.user_id,
        e.event_timestamp,
        e.event_type,
        e.product_id,
        e.referrer,
        e.page_source,
        e.query,
        s.session_id,
        s.session_start,
        s.session_end,
        s.session_duration
    FROM {{ ref('stg_events_flat_partitioned_clustered') }} e
    LEFT JOIN {{ ref('int_sessions') }} s
        ON e.user_id = s.user_id
        AND e.event_timestamp BETWEEN s.session_start AND s.session_end
)

SELECT
    event_id,
    user_id,
    event_timestamp,
    event_type,
    product_id,
    referrer,
    page_source,
    query,
    session_id,
    session_start,
    session_end,
    session_duration,
    EXTRACT(HOUR FROM event_timestamp) AS event_hour_of_day,
    EXTRACT(DAYOFWEEK FROM event_timestamp) AS event_day_of_week
FROM event_data

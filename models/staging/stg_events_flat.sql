SELECT
    event_id AS event_id,
    LOWER(event_type) AS event_type,
    IF(REGEXP_CONTAINS(user_agent, "Opera") = TRUE,"Opera","Mozilla") AS search_engine,
    REGEXP_EXTRACT(user_agent, "Windows|Android|iPad|iPhone|Macintosh|iPod|compatible|X11|Linux") AS os_device,
    ip_address,
    CAST(customer_id AS INT64) AS user_id,
    CAST(date_timestamp AS TIMESTAMP) AS event_timestamp,
    CAST(EXTRACT(DATE FROM CAST(date_timestamp AS TIMESTAMP)) AS DATE) AS event_date,
    LOWER(query) AS query,
    LOWER(page) AS page_source,
    CAST(product AS INT64) AS product_id,
    LOWER(referrer) AS referrer
FROM {{ source('ae_assessment_lguiral', 'events_flat') }}
WHERE event_id IS NOT NULL
AND customer_id IS NOT NULL
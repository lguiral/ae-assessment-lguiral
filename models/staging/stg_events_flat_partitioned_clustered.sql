SELECT
    CAST(event_date AS DATE) AS event_date,
    CAST(event_timestamp AS TIMESTAMP) AS event_timestamp,
    event_id,
    user_id,
    event_type,
    search_engine,
    os_device,
    ip_address,
    query,
    page_source,
    product_id,
    referrer
FROM {{source('ae_assessment_lguiral', 'events_flat_partitioned_clustered')}}
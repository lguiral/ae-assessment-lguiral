-- Test to ensure no future timestamps exist in event data
SELECT *
FROM {{ source('ae_assessment_lguiral', 'events_flat_partitioned_clustered') }}
WHERE event_timestamp > CURRENT_TIMESTAMP

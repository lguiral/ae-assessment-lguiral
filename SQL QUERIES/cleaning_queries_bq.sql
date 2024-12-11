--- TRANSFORM CSV FILE INTO BIGQUERY TABLE ---
--- START ---
LOAD DATA OVERWRITE ae_assessment_lguiral.events (id STRING, type STRING, event STRING) -- Load would not work unless id would be cast as STRING
FROM FILES (
  format = 'CSV',
  uris = ['gs://ae-assessment-lguiral-xccelerated/raw/events_202412061456.csv']);
--- END ---

--- UNNEST DIMENSIONS FROM RAW TABLE ---
--- START ---
CREATE TABLE `bigquery-projet-data.ae_assessment_lguiral.events_flat`  AS (
SELECT
SAFE_CAST(id as INT64) AS event_id,
type as event_type,
JSON_EXTRACT_SCALAR(event, '$.user-agent') AS user_agent,
JSON_EXTRACT_SCALAR(event, '$.ip') AS ip_address,
JSON_EXTRACT_SCALAR(event, '$.customer-id') AS customer_id,
JSON_EXTRACT_SCALAR(event, '$.timestamp') AS date_timestamp,
JSON_EXTRACT_SCALAR(event, '$.query') AS query,
JSON_EXTRACT_SCALAR(event, '$.page' ) AS page,
JSON_EXTRACT_SCALAR(event, '$.product' ) AS product
FROM `bigquery-projet-data.ae_assessment_lguiral.events`
)
--- END ---

--- CREATE PARTITIONED AND CLUSTERED TABLE ---
--- START ---
CREATE TABLE `bigquery-projet-data.ae_assessment_lguiral.events_flat_partitioned_clustered`
PARTITION BY event_date
CLUSTER BY event_type, user_id, product_id AS (
SELECT * FROM `bigquery-projet-data.dbt_lguiral.stg_events_flat` )
--- END ---
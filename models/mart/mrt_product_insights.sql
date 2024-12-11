WITH product_events AS (
    SELECT
        product_id,
        COUNTIF(event_type = "page_view") AS total_views,
        COUNTIF(event_type = "placed_order") AS total_purchases
    FROM {{ ref('int_aggregated_events') }}
    WHERE product_id IS NOT NULL
    GROUP BY product_id
)

SELECT
    product_id,
    total_views,
    total_purchases,
    SAFE_DIVIDE(total_purchases, total_views) AS view_to_purchase_rate
FROM product_events
ORDER BY total_views DESC
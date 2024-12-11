WITH product_events AS (
    SELECT
        product_id,
        COUNTIF(event_type = "search") AS total_searches,
        COUNTIF(event_type = "page_view") AS total_views,
        COUNTIF(event_type = "placed_order") AS total_purchases,
        COUNTIF(event_type = "visit_recently_visited_product") AS total_recent_visits,
        COUNTIF(event_type = "add_product_to_cart") AS total_atc,
        COUNTIF(event_type = "visit_personal_recommendation") AS total_visit_recommendations,
        COUNTIF(event_type = "visit_related_product") AS total_visit_related,
        COUNTIF(event_type = "remove_product_from_cart") AS total_remove_from_cart
    FROM {{ ref('int_aggregated_events') }}
    WHERE product_id IS NOT NULL
    GROUP BY product_id
)

SELECT
    product_id,
    total_searches,
    total_views,
    total_recent_visits,
    total_atc,
    total_visit_recommendations,
    total_visit_related,
    total_remove_from_cart,
    total_purchases,
    SAFE_DIVIDE(total_purchases, total_views) AS view_to_purchase_rate
FROM product_events
ORDER BY total_views DESC
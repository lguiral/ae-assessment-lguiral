WITH daily_sessions AS (
    SELECT
        DATE(session_start) AS date,
        COUNT(DISTINCT session_id) AS total_sessions,
        COUNT(DISTINCT user_id) AS unique_users
    FROM {{ ref('int_sessions') }}
    GROUP BY DATE(session_start)
),

referrer_metrics AS (
    SELECT
        referrer,
        AVG(session_duration) AS avg_session_duration,
        COUNT(DISTINCT session_id) AS total_sessions_by_referrer,
        SUM(CASE WHEN add_to_cart_count > 0 THEN 1 ELSE 0 END) AS sessions_with_add_to_cart,
        SUM(CASE WHEN purchase_count > 0 THEN 1 ELSE 0 END) AS sessions_with_purchase
    FROM {{ ref('int_sessions') }}
    GROUP BY referrer
),

funnel_rates AS (
    SELECT
        referrer,
        total_sessions_by_referrer,
        SAFE_DIVIDE(sessions_with_add_to_cart, total_sessions_by_referrer) AS add_to_cart_rate,
        SAFE_DIVIDE(sessions_with_purchase, sessions_with_add_to_cart) AS purchase_rate
    FROM referrer_metrics
)

SELECT
    d.date,
    d.total_sessions,
    d.unique_users,
    f.referrer,
    r.avg_session_duration,
    f.add_to_cart_rate,
    f.purchase_rate
FROM daily_sessions d
CROSS JOIN (
    SELECT DISTINCT referrer FROM referrer_metrics
) f_ref
LEFT JOIN referrer_metrics r ON r.referrer = f_ref.referrer
LEFT JOIN funnel_rates f ON f.referrer = f_ref.referrer

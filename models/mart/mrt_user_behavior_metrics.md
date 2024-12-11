{% docs mrt_user_behavior_metrics %}

## Overview
This mart model aggregates key user behavior metrics into a single, analysis-ready dataset. It combines session counts, unique users, average session duration by referrer, and funnel conversion rates from session start to add-to-cart and purchase.

## Business Questions Addressed
- **Which referrers drive the most engaged traffic?**
- **Are total sessions and unique users growing over time?**
- **Where are users dropping off in the conversion funnel (session → add-to-cart → purchase)?**

## Key Metrics
- **avg_session_duration**: Engagement quality by referrer.
- **add_to_cart_rate**: Identifies how many sessions lead to cart activity.
- **purchase_rate**: The ultimate measure of conversion health, showing how effectively add-to-cart sessions turn into purchases.

## Dependencies
- **int_sessions**: Provides session-level metrics and event counts.
- **int_aggregated_events**: (If needed) For detailed event-level breakdowns.

{% enddocs %}
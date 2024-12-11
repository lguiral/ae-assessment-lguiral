{% docs mrt_customer_journey_metrics %}

## Overview
The `mart_customer_journey_metrics` model provides insights into the user conversion journey. Specifically, it calculates median sessions before a user's first purchase and the median session duration before that purchase, segmented by user cohort (first session date).

## Business Questions Addressed
- **How many sessions does it typically take for a new user to purchase for the first time?**
- **How engaged are users in terms of session duration before making that purchase?**

These insights help in understanding user warming-up periods and can guide retention and CRM strategies.

## Key Metrics
- **median_sessions_before_purchase**: Median number of sessions before conversion.
- **median_session_duration_before_purchase**: Median duration of sessions before conversion.

## Dependencies
- **int_customer_journey_data**: Supplies pre-sorted session arrays, simplifying median calculations.
- **int_sessions**: Underpins session-level data used upstream.

{% enddocs %}
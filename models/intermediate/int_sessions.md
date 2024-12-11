{% docs int_sessions %}

## Overview
`int_sessions` provides a session-level view of user activity. This model takes session-level data from `stg_events_flat_partitioned_clustered` and group them into sessions based on a 30-minute inactivity threshold. Each session includes metrics like the number of page views, adds-to-cart, purchases, searches, and the count of unique products viewed.

## Why This Model?
`int_sessions` serves as a foundation for understanding user behavior within discrete time-bound intervals (sessions). It helps downstream models and analysis answer questions like:
- How long do sessions typically last?
- How many actions do users take per session?
- What is the likelihood of a session resulting in a purchase?

By aggregating events at the session level, you can easily roll up or slice performance metrics by referrer, device type, user cohort, etc.

## Key Metrics Provided
- **Session Duration**: Understand how engaged users are within a single visit.
- **Page/View/Add-to-Cart/Purchase Counts**: Evaluate funnel performance on a per-session basis.
- **Unique Products Viewed**: Identify whether users explore multiple products in a single session.

{% enddocs %}
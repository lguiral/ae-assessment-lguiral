{% docs int_customer_journey_data %}

## Overview
`int_customer_journey_data` serves as an intermediate model that simplifies median calculations for the customer journey metrics. It identifies all sessions that occur before a user's first purchase, groups them by the user's cohort (the date of their first session), and produces pre-sorted arrays of session counts and durations.

By handling data preparation and sorting here, the mart model (`mart_customer_journey_metrics`) can focus solely on extracting median values with minimal complexity.

## Why This Model?
Calculating medians in SQL can be cumbersome. By preparing arrays of sorted values in this intermediate model, we avoid complex window functions or approximate methods in the final mart layer. This makes the mart model simpler, more maintainable, and easier to understand.

## Key Outputs
- **user_cohort_date**: Allows segmentation of users by their first session date.
- **sessions_array & durations_array**: Pre-sorted arrays that make median extraction straightforward.
- **total_count**: The number of sessions contributing to these arrays, enabling easy determination of even/odd counts for median calculation.

## Related Models
- **int_sessions**: Provides the foundational session-level metrics.
- **mart_customer_journey_metrics**: Uses `int_customer_journey_data` to compute median sessions before purchase and median session duration before purchase.

{% enddocs %}
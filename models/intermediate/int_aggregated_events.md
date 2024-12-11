{% docs int_aggregated_events %}

## Overview
`int_aggregated_events` is an event-level model that enriches raw events from `stg_events_flat` with session context from `int_sessions`. Each row represents a single event, now accompanied by session-level details (session_id, session_start, session_end, session_duration) and user-level fields.

By linking each event to its parent session, this model enables more granular analyses, such as understanding the event mix within a session, the timing of events throughout the day or week, and how certain events correlate with session outcomes.

## Why This Model?
While `stg_events_flat` provides raw event data, it lacks an understanding of session boundaries. Conversely, `int_sessions` focuses on session-level aggregation. `int_aggregated_events` bridges the gap, allowing you to:

- Drill down into events within a session.
- Analyze event patterns by session duration, referrer, or other session attributes.
- Identify how event timing (hour of day, day of week) influences user behavior or conversion likelihood.

This sets the stage for complex, event-level analytics and helps ensure that downstream mart models can address questions spanning both event granularity and session structure.

## Key Use Cases
- **Event Sequencing and Paths:** Understand the order of events within a session, identifying common navigation paths or funnels.
- **Temporal Analysis:** Use `event_hour_of_day` and `event_day_of_week` to uncover time-based behavior patterns (e.g., users more likely to purchase on weekends or evenings).
- **Session Attribution:** Quickly filter or group events by session_id, linking actions to specific user sessions for deeper insight into engagement and conversion rates.

## Related Models
- **int_sessions:** Provides the session-level aggregates that `int_aggregated_events` references.
- **stg_events_flat:** The raw event-level staging model from which events and timestamps are sourced.

{% enddocs %}
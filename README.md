# Analytics Engineering Project

## Overview
This repository showcases an end-to-end analytics engineering project using dbt, BigQuery, and a well-structured SQL-based transformation pipeline. The goal is to provide insightful metrics on user sessions, customer journeys, and product performance for a fictional e-commerce platform.

## Data Flow
1. **Staging Layer (stg_...)**:  
   - **stg_events_flat_partitioned_clustered**: Raw event-level data sourced from the database is cleaned, standardized, and flattened into a single table.

2. **Intermediate Models (int_...)**:  
   - **int_sessions**: Aggregates events into user sessions, computing session-level metrics like session duration, product views, adds-to-cart, and purchases.
   - **int_aggregated_events**: Enriches event-level data with session context, making it easy to analyze events in their session context.
   - **int_customer_journey_data**: Prepares data for median calculations by creating sorted arrays of sessions before a user's first purchase, simplifying downstream computations.

3. **Mart Models (mrt_...)**:  
   These are the final, analysis-ready tables tailored for stakeholder questions:
   - **mart_user_behavior_metrics**: Provides user behavior analytics such as daily sessions, unique users, average session duration by referrer, and conversion funnel metrics.
   - **mart_customer_journey_metrics**: Answers questions about how many sessions and how much time it takes before users make their first purchase, by cohort.
   - **mart_product_insights**: Focuses on product-level performance, identifying most-viewed products, most-purchased products, and view-to-purchase conversion rates.

## Documentation and Testing
- **YML Files**: Each model has a corresponding `.yml` file specifying columns, descriptions, and data tests (e.g., not_null, unique).
- **Markdown Files**: Accompanying `.md` files provide narrative documentation—explaining each model’s purpose, key metrics, and how it helps answer business questions.

## Business Questions Answered
- **User Behavior**: Which referrers drive quality traffic? Are we seeing growth in sessions and unique users? Where do we lose users in the conversion funnel?
- **Customer Journey**: How many sessions and what session duration lead up to a first purchase? How does this vary by user cohort?
- **Product Insights**: Which products are popular, and do popular products convert views into purchases effectively?

## Conclusion
By structuring the pipeline into staging, intermediate, and mart models and documenting them thoroughly, we've created a maintainable, scalable, and comprehensible analytics ecosystem. Stakeholders can now trust the data, quickly access relevant metrics, and make data-driven decisions to improve user engagement, conversions, and product strategies.

{% docs mart_product_insights %}

## Overview
`mart_product_insights` aggregates product-level metrics to identify top-performing products and conversion rates. It shows most-viewed, most-purchased products and their view-to-purchase conversion rates, helping stakeholders understand product popularity and profitability.

## Business Questions Addressed
- **Which products attract the most views and purchases?**
- **Are highly viewed products converting into purchases effectively, or is there a gap?**

## Key Metrics
- **total_views**: Indicates product interest and visibility.
- **total_purchases**: Measures product demand.
- **view_to_purchase_rate**: Evaluates conversion efficiency per product.

## Dependencies
- **int_aggregated_events**: Event-level data provides the foundation for counting views and purchases per product.

{% enddocs %}
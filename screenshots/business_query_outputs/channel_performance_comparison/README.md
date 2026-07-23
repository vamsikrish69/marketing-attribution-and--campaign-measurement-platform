# Channel Performance Comparison

## Business Question

Which marketing channels generate the strongest performance across spend, revenue, conversions, and attribution-based ROAS?

## Objective

This analysis compares channel-level marketing performance across all major marketing channels in the attribution platform.

Marketing teams need to understand which channels are generating the highest attributed revenue, strongest ROAS, and most efficient conversion outcomes. This query provides a channel-level view using first-touch, last-touch, and linear attribution revenue metrics.

## SQL Query Used

```sql
SELECT
    CHANNEL,
    TOTAL_CAMPAIGNS,

    TOTAL_SPEND,
    TOTAL_IMPRESSIONS,
    TOTAL_CLICKS,

    CHANNEL_CTR,

    FIRST_TOUCH_REVENUE,
    LAST_TOUCH_REVENUE,
    LINEAR_ATTRIBUTED_REVENUE,

    FIRST_TOUCH_ROAS,
    LAST_TOUCH_ROAS,
    LINEAR_ROAS,

    COST_PER_LINEAR_ATTRIBUTED_CONVERSION

FROM ANALYTICS.FCT_CHANNEL_ATTRIBUTION

ORDER BY
    LINEAR_ROAS DESC;

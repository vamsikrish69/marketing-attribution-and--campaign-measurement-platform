# Attribution Model Comparison

## Business Question

How does channel performance change across different attribution models?

## Objective

This analysis compares marketing channel performance under first-touch, last-touch, and linear attribution models.

Marketing teams often need to understand whether a channel is more effective at starting customer journeys, closing conversions, or contributing across the full customer journey. This query helps compare those attribution outcomes side by side.

## SQL Query Used

```sql
SELECT
    ATTRIBUTION_MODEL,
    CHANNEL,

    ROUND(SUM(ATTRIBUTED_REVENUE), 2) AS TOTAL_ATTRIBUTED_REVENUE,

    SUM(ATTRIBUTED_CONVERSIONS) AS TOTAL_ATTRIBUTED_CONVERSIONS,

    ROUND(
        SUM(ATTRIBUTED_REVENUE) / NULLIF(SUM(TOTAL_SPEND), 0),
        2
    ) AS ATTRIBUTED_ROAS,

    ROUND(
        SUM(TOTAL_SPEND) / NULLIF(SUM(ATTRIBUTED_CONVERSIONS), 0),
        2
    ) AS COST_PER_ATTRIBUTED_CONVERSION

FROM ANALYTICS.FCT_ATTRIBUTION_PERFORMANCE

GROUP BY
    ATTRIBUTION_MODEL,
    CHANNEL

ORDER BY
    ATTRIBUTION_MODEL,
    TOTAL_ATTRIBUTED_REVENUE DESC;

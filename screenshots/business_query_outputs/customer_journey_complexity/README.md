# Customer Journey Complexity

## Business Question

How many marketing touchpoints do customers typically interact with before converting?

## Objective

This analysis measures customer journey complexity by calculating how many touchpoints occur before a conversion event.

Marketing teams need to understand whether customers usually convert after one interaction or after several campaign interactions across multiple channels. This helps evaluate how complex the buying journey is and whether multi-touch attribution is required.

## SQL Query Used

```sql
SELECT
    TOTAL_TOUCHPOINTS,

    COUNT(DISTINCT CONVERSION_ID) AS TOTAL_CONVERSIONS,

    ROUND(
        COUNT(DISTINCT CONVERSION_ID) * 100.0
        / SUM(COUNT(DISTINCT CONVERSION_ID)) OVER (),
        2
    ) AS CONVERSION_PERCENTAGE,

    ROUND(
        AVG(REVENUE),
        2
    ) AS AVG_REVENUE_PER_CONVERSION,

    ROUND(
        SUM(REVENUE),
        2
    ) AS TOTAL_REVENUE

FROM INTERMEDIATE.INT_USER_JOURNEY

GROUP BY
    TOTAL_TOUCHPOINTS

ORDER BY
    TOTAL_TOUCHPOINTS;

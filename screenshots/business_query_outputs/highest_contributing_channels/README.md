# Highest Contributing Channels

## Business Question

Which marketing channels contribute the most attributed revenue and conversions under the linear attribution model?

## Objective

This analysis ranks marketing channels by their total linear attributed revenue and attributed conversions.

Marketing teams need to understand which channels contribute the most across the full customer journey, not only at the first or final interaction. Linear attribution helps measure full-journey contribution by distributing conversion credit across all touchpoints.

## SQL Query Used

```sql
SELECT
    CHANNEL,

    COUNT(DISTINCT CAMPAIGN_ID) AS TOTAL_CAMPAIGNS,

    ROUND(SUM(TOTAL_SPEND), 2) AS TOTAL_SPEND,

    SUM(LINEAR_ATTRIBUTED_CONVERSIONS) AS TOTAL_LINEAR_ATTRIBUTED_CONVERSIONS,

    ROUND(
        SUM(LINEAR_ATTRIBUTED_REVENUE),
        2
    ) AS TOTAL_LINEAR_ATTRIBUTED_REVENUE,

    ROUND(
        SUM(LINEAR_ATTRIBUTED_REVENUE) / NULLIF(SUM(TOTAL_SPEND), 0),
        2
    ) AS LINEAR_ROAS,

    ROUND(
        SUM(TOTAL_SPEND) / NULLIF(SUM(LINEAR_ATTRIBUTED_CONVERSIONS), 0),
        2
    ) AS COST_PER_LINEAR_ATTRIBUTED_CONVERSION

FROM ANALYTICS.FCT_CHANNEL_ATTRIBUTION

GROUP BY
    CHANNEL

ORDER BY
    TOTAL_LINEAR_ATTRIBUTED_REVENUE DESC;

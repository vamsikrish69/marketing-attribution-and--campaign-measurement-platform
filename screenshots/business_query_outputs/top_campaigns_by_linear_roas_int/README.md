# Top Campaigns by Linear ROAS

## Business Question

Which campaigns generate the highest return on advertising spend under the linear attribution model?

## Objective

This analysis identifies the best-performing campaigns based on Linear ROAS.

Linear attribution distributes conversion credit across all customer journey touchpoints, which makes this analysis useful for understanding campaign contribution across the full journey rather than only the first or final interaction.

## SQL Query Used

```sql
SELECT
    CAMPAIGN_ID,
    CAMPAIGN_NAME,
    CHANNEL,

    ROUND(TOTAL_SPEND, 2) AS TOTAL_SPEND,

    LINEAR_ATTRIBUTED_CONVERSIONS,

    ROUND(
        LINEAR_ATTRIBUTED_REVENUE,
        2
    ) AS LINEAR_ATTRIBUTED_REVENUE,

    LINEAR_ROAS,

    COST_PER_LINEAR_ATTRIBUTED_CONVERSION

FROM ANALYTICS.FCT_CAMPAIGN_MEASUREMENT

ORDER BY
    LINEAR_ROAS DESC

LIMIT 10;

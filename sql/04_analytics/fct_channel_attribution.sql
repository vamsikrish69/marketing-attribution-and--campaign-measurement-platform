CREATE OR REPLACE TABLE ANALYTICS.FCT_CHANNEL_ATTRIBUTION AS

SELECT
    channel,

    COUNT(DISTINCT campaign_id) AS total_campaigns,

    SUM(total_spend) AS total_spend,
    SUM(total_impressions) AS total_impressions,
    SUM(total_clicks) AS total_clicks,

    ROUND(
        SUM(total_clicks) / NULLIF(SUM(total_impressions), 0),
        4
    ) AS channel_ctr,

    SUM(first_touch_conversions) AS first_touch_conversions,
    SUM(first_touch_revenue) AS first_touch_revenue,

    SUM(last_touch_conversions) AS last_touch_conversions,
    SUM(last_touch_revenue) AS last_touch_revenue,

    SUM(linear_attributed_conversions) AS linear_attributed_conversions,
    SUM(linear_attributed_revenue) AS linear_attributed_revenue,
    SUM(total_linear_credit) AS total_linear_credit,

    ROUND(
        SUM(first_touch_revenue) / NULLIF(SUM(total_spend), 0),
        2
    ) AS first_touch_roas,

    ROUND(
        SUM(last_touch_revenue) / NULLIF(SUM(total_spend), 0),
        2
    ) AS last_touch_roas,

    ROUND(
        SUM(linear_attributed_revenue) / NULLIF(SUM(total_spend), 0),
        2
    ) AS linear_roas,

    ROUND(
        SUM(total_spend) / NULLIF(SUM(linear_attributed_conversions), 0),
        2
    ) AS cost_per_linear_attributed_conversion

FROM ANALYTICS.FCT_CAMPAIGN_MEASUREMENT

GROUP BY channel;

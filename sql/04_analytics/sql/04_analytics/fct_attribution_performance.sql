CREATE OR REPLACE TABLE ANALYTICS.FCT_ATTRIBUTION_PERFORMANCE AS

WITH first_touch AS (
    SELECT
        campaign_id,
        channel,
        attribution_model,
        COUNT(DISTINCT conversion_id) AS attributed_conversions,
        SUM(attributed_revenue) AS attributed_revenue,
        SUM(attribution_credit) AS total_attribution_credit
    FROM INTERMEDIATE.INT_FIRST_TOUCH_ATTRIBUTION
    GROUP BY
        campaign_id,
        channel,
        attribution_model
),

last_touch AS (
    SELECT
        campaign_id,
        channel,
        attribution_model,
        COUNT(DISTINCT conversion_id) AS attributed_conversions,
        SUM(attributed_revenue) AS attributed_revenue,
        SUM(attribution_credit) AS total_attribution_credit
    FROM INTERMEDIATE.INT_LAST_TOUCH_ATTRIBUTION
    GROUP BY
        campaign_id,
        channel,
        attribution_model
),

linear_touch AS (
    SELECT
        campaign_id,
        channel,
        attribution_model,
        COUNT(DISTINCT conversion_id) AS attributed_conversions,
        SUM(attributed_revenue) AS attributed_revenue,
        SUM(attribution_credit) AS total_attribution_credit
    FROM INTERMEDIATE.INT_LINEAR_ATTRIBUTION
    GROUP BY
        campaign_id,
        channel,
        attribution_model
),

all_attribution AS (
    SELECT * FROM first_touch

    UNION ALL

    SELECT * FROM last_touch

    UNION ALL

    SELECT * FROM linear_touch
),

spend_summary AS (
    SELECT
        campaign_id,
        channel,
        SUM(spend) AS total_spend,
        SUM(impressions) AS total_impressions,
        SUM(clicks) AS total_clicks
    FROM STAGING.STG_AD_SPEND
    GROUP BY
        campaign_id,
        channel
)

SELECT
    a.campaign_id,
    c.campaign_name,
    a.channel,
    c.campaign_objective,
    a.attribution_model,

    COALESCE(s.total_spend, 0) AS total_spend,
    COALESCE(s.total_impressions, 0) AS total_impressions,
    COALESCE(s.total_clicks, 0) AS total_clicks,

    ROUND(
        COALESCE(s.total_clicks, 0) / NULLIF(COALESCE(s.total_impressions, 0), 0),
        4
    ) AS ctr,

    a.attributed_conversions,
    ROUND(a.attributed_revenue, 2) AS attributed_revenue,
    ROUND(a.total_attribution_credit, 2) AS total_attribution_credit,

    ROUND(
        a.attributed_revenue / NULLIF(COALESCE(s.total_spend, 0), 0),
        2
    ) AS attributed_roas,

    ROUND(
        COALESCE(s.total_spend, 0) / NULLIF(a.attributed_conversions, 0),
        2
    ) AS cost_per_attributed_conversion

FROM all_attribution a

LEFT JOIN STAGING.STG_CAMPAIGNS c
    ON a.campaign_id = c.campaign_id
    AND a.channel = c.channel

LEFT JOIN spend_summary s
    ON a.campaign_id = s.campaign_id
    AND a.channel = s.channel;

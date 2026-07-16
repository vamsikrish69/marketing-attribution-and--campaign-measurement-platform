CREATE OR REPLACE TABLE ANALYTICS.FCT_CAMPAIGN_MEASUREMENT AS

WITH ad_spend_summary AS (
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
),

first_touch_summary AS (
    SELECT
        campaign_id,
        channel,
        COUNT(DISTINCT conversion_id) AS first_touch_conversions,
        SUM(attributed_revenue) AS first_touch_revenue
    FROM INTERMEDIATE.INT_FIRST_TOUCH_ATTRIBUTION
    GROUP BY
        campaign_id,
        channel
),

last_touch_summary AS (
    SELECT
        campaign_id,
        channel,
        COUNT(DISTINCT conversion_id) AS last_touch_conversions,
        SUM(attributed_revenue) AS last_touch_revenue
    FROM INTERMEDIATE.INT_LAST_TOUCH_ATTRIBUTION
    GROUP BY
        campaign_id,
        channel
),

linear_touch_summary AS (
    SELECT
        campaign_id,
        channel,
        COUNT(DISTINCT conversion_id) AS linear_attributed_conversions,
        SUM(attributed_revenue) AS linear_attributed_revenue,
        SUM(attribution_credit) AS total_linear_credit
    FROM INTERMEDIATE.INT_LINEAR_ATTRIBUTION
    GROUP BY
        campaign_id,
        channel
)

SELECT
    c.campaign_id,
    c.campaign_name,
    c.channel,
    c.campaign_objective,
    c.budget,

    COALESCE(a.total_spend, 0) AS total_spend,
    COALESCE(a.total_impressions, 0) AS total_impressions,
    COALESCE(a.total_clicks, 0) AS total_clicks,

    ROUND(
        COALESCE(a.total_clicks, 0) / NULLIF(COALESCE(a.total_impressions, 0), 0),
        4
    ) AS ctr,

    COALESCE(f.first_touch_conversions, 0) AS first_touch_conversions,
    COALESCE(f.first_touch_revenue, 0) AS first_touch_revenue,

    COALESCE(l.last_touch_conversions, 0) AS last_touch_conversions,
    COALESCE(l.last_touch_revenue, 0) AS last_touch_revenue,

    COALESCE(ln.linear_attributed_conversions, 0) AS linear_attributed_conversions,
    COALESCE(ln.linear_attributed_revenue, 0) AS linear_attributed_revenue,
    COALESCE(ln.total_linear_credit, 0) AS total_linear_credit,

    ROUND(
        COALESCE(f.first_touch_revenue, 0) / NULLIF(COALESCE(a.total_spend, 0), 0),
        2
    ) AS first_touch_roas,

    ROUND(
        COALESCE(l.last_touch_revenue, 0) / NULLIF(COALESCE(a.total_spend, 0), 0),
        2
    ) AS last_touch_roas,

    ROUND(
        COALESCE(ln.linear_attributed_revenue, 0) / NULLIF(COALESCE(a.total_spend, 0), 0),
        2
    ) AS linear_roas,

    ROUND(
        COALESCE(a.total_spend, 0) / NULLIF(COALESCE(ln.linear_attributed_conversions, 0), 0),
        2
    ) AS cost_per_linear_attributed_conversion

FROM STAGING.STG_CAMPAIGNS c

LEFT JOIN ad_spend_summary a
    ON c.campaign_id = a.campaign_id
    AND c.channel = a.channel

LEFT JOIN first_touch_summary f
    ON c.campaign_id = f.campaign_id
    AND c.channel = f.channel

LEFT JOIN last_touch_summary l
    ON c.campaign_id = l.campaign_id
    AND c.channel = l.channel

LEFT JOIN linear_touch_summary ln
    ON c.campaign_id = ln.campaign_id
    AND c.channel = ln.channel;
``

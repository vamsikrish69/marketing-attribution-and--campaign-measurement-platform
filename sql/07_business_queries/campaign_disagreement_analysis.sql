SELECT
    CAMPAIGN_ID,
    CAMPAIGN_NAME,
    CHANNEL,

    ROUND(
        SUM(
            CASE
                WHEN ATTRIBUTION_MODEL = 'first_touch'
                THEN ATTRIBUTED_REVENUE
                ELSE 0
            END
        ),
        2
    ) AS FIRST_TOUCH_REVENUE,

    ROUND(
        SUM(
            CASE
                WHEN ATTRIBUTION_MODEL = 'last_touch'
                THEN ATTRIBUTED_REVENUE
                ELSE 0
            END
        ),
        2
    ) AS LAST_TOUCH_REVENUE,

    ROUND(
        SUM(
            CASE
                WHEN ATTRIBUTION_MODEL = 'linear'
                THEN ATTRIBUTED_REVENUE
                ELSE 0
            END
        ),
        2
    ) AS LINEAR_REVENUE

FROM ANALYTICS.FCT_ATTRIBUTION_PERFORMANCE

GROUP BY
    CAMPAIGN_ID,
    CAMPAIGN_NAME,
    CHANNEL

ORDER BY
    ABS(
        SUM(
            CASE
                WHEN ATTRIBUTION_MODEL = 'first_touch'
                THEN ATTRIBUTED_REVENUE
                ELSE 0
            END
        )
        -
        SUM(
            CASE
                WHEN ATTRIBUTION_MODEL = 'last_touch'
                THEN ATTRIBUTED_REVENUE
                ELSE 0
            END
        )
    ) DESC

LIMIT 20;

----- Identify campaigns where attribution models tell different stories.Show more lines---

# Attribution Models

## Overview

This section contains screenshots demonstrating the attribution methodologies implemented within the Marketing Attribution & Campaign Measurement Platform.

The platform supports multiple attribution models that assign conversion credit differently across customer journeys.

The screenshots provide visual proof of the attribution logic implemented in the INTERMEDIATE and ANALYTICS layers.

---

## Attribution Models Included

### First-Touch Attribution

Folder:

```text
first_touch_attribution/
```

This model assigns 100% conversion credit to the first marketing touchpoint that occurred before conversion.

Query Used:

```sql
SELECT
    CONVERSION_ID,
    USER_ID,
    TOUCHPOINT_ID,
    CAMPAIGN_ID,
    CHANNEL,
    TOUCHPOINT_TIME,
    CONVERSION_TIME,
    CONVERSION_TYPE,
    REVENUE AS ATTRIBUTED_REVENUE
FROM INTERMEDIATE.INT_FIRST_TOUCH_ATTRIBUTION
ORDER BY
    CONVERSION_ID
LIMIT 20;
```

Business Purpose:

Understand which campaigns and marketing channels are responsible for introducing customers into the funnel.

---

### Last-Touch Attribution

Folder:

```text
last_touch_attribution/
```

This model assigns 100% conversion credit to the final marketing touchpoint before conversion.

Query Used:

```sql
SELECT
    CONVERSION_ID,
    USER_ID,
    TOUCHPOINT_ID,
    CAMPAIGN_ID,
    CHANNEL,
    TOUCHPOINT_TIME,
    CONVERSION_TIME,
    REVENUE AS ATTRIBUTED_REVENUE
FROM INTERMEDIATE.INT_LAST_TOUCH_ATTRIBUTION
ORDER BY
    CONVERSION_ID
LIMIT 20;
```

Business Purpose:

Identify the campaigns and channels responsible for closing conversions and driving revenue-generating actions.

---

### Linear Attribution

Folder:

```text
linear_attribution/
```

This model distributes conversion credit equally across all customer journey touchpoints.

Query Used:

```sql
SELECT
    CONVERSION_ID,
    USER_ID,
    TOUCHPOINT_ID,
    CAMPAIGN_ID,
    CHANNEL,
    TOUCHPOINT_TIME,
    ATTRIBUTED_REVENUE
FROM INTERMEDIATE.INT_LINEAR_ATTRIBUTION
ORDER BY
    CONVERSION_ID
LIMIT 20;
```

Business Purpose:

Measure how campaigns and channels contribute throughout the entire customer journey.

---

### Attribution Model Comparison

Folder:

```text
attribution_model_comparison/
```

This analysis compares attribution performance across First-Touch, Last-Touch, and Linear attribution methodologies.

Query Used:

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
```

Business Purpose:

Compare how marketing performance changes under different attribution methodologies.

---

## Attribution Logic Comparison

Customer Journey Example:

```text
Meta Impression
      ↓
Google Click
      ↓
Email Click
      ↓
Conversion
```

Revenue:

```text
90
```

### First-Touch Attribution

```text
Meta receives 90
```

### Last-Touch Attribution

```text
Email receives 90
```

### Linear Attribution

```text
Meta receives 30
Google receives 30
Email receives 30
```

---

## Business Questions Answered

The attribution models help answer:

- Which campaigns introduce customers?
- Which campaigns close conversions?
- Which channels contribute throughout the customer journey?
- How does campaign performance change across attribution models?
- Which channels generate the highest attributed revenue?
- Which campaigns generate the highest attributed ROAS?
- Which attribution methodology is most appropriate for business decision-making?

---

## Business Value

These attribution models help marketing teams:

- Measure customer journey influence
- Compare attribution methodologies
- Evaluate campaign effectiveness
- Understand channel contribution
- Improve budget allocation
- Optimize campaign investments
- Support data-driven marketing decisions

---

## Expected Outputs

The screenshots within this folder demonstrate:

- First-touch conversion attribution
- Last-touch conversion attribution
- Linear attribution revenue allocation
- Attribution model comparison
- Channel contribution analysis
- Attributed revenue measurement
- Attributed ROAS calculation

---

## Screenshot Recommendation

The screenshots should focus on Snowflake query output results rather than SQL code.

Important fields to display include:

```text
CONVERSION_ID
USER_ID
TOUCHPOINT_ID
CAMPAIGN_ID
CHANNEL
ATTRIBUTED_REVENUE
ATTRIBUTION_MODEL
ATTRIBUTED_ROAS
```

The screenshots serve as visual proof that the platform successfully implements and compares multiple attribution methodologies across customer journeys.

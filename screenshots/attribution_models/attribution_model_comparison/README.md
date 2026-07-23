# Attribution Model Comparison

## Business Question

How does campaign and channel performance change under different attribution models?

## Objective

This analysis compares campaign performance across the three attribution methodologies implemented within the platform:

- First-Touch Attribution
- Last-Touch Attribution
- Linear Attribution

Different attribution models can produce significantly different campaign performance outcomes. This comparison helps marketers understand how conversion credit allocation impacts campaign evaluation and budget allocation decisions.

## Attribution Logic

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

The purpose of this comparison is to understand how campaign performance changes depending on the attribution methodology used.

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
```

## Metrics Displayed

- Attribution Model
- Channel
- Total Attributed Revenue
- Total Attributed Conversions
- Attributed ROAS
- Cost per Attributed Conversion

## Attribution Models Compared

### First-Touch Attribution

Assigns 100% conversion credit to the first marketing interaction before conversion.

### Last-Touch Attribution

Assigns 100% conversion credit to the final marketing touchpoint before conversion.

### Linear Attribution

Distributes conversion credit equally across every touchpoint in the customer journey.

## Business Value

This analysis helps marketing teams:

- Compare attribution methodologies
- Understand channel contribution differences
- Evaluate campaign performance from multiple perspectives
- Improve marketing budget allocation
- Identify acquisition-focused channels
- Identify conversion-driving channels
- Measure full customer journey contribution

## Expected Output

The screenshot should display attribution performance by:

```text
ATTRIBUTION_MODEL
CHANNEL
TOTAL_ATTRIBUTED_REVENUE
TOTAL_ATTRIBUTED_CONVERSIONS
ATTRIBUTED_ROAS
COST_PER_ATTRIBUTED_CONVERSION
```

The output allows stakeholders to compare how revenue, conversions, and ROAS vary between attribution methodologies.

## Interpretation

A channel performing strongly under First-Touch Attribution is typically effective at introducing customers into the funnel.

A channel performing strongly under Last-Touch Attribution is typically effective at closing conversions.

A channel performing strongly under Linear Attribution contributes throughout the customer journey.

Comparing all three models provides a more complete view of campaign effectiveness and helps avoid bias introduced by relying on a single attribution methodology.

## Screenshot Recommendation

The screenshot should focus on the query output results.

The most important columns to display are:

- Attribution Model
- Channel
- Total Attributed Revenue
- Total Attributed Conversions
- Attributed ROAS

The screenshot serves as visual proof that the platform successfully compares campaign performance across multiple attribution methodologies.

# Linear Attribution

## Business Question

Which campaigns and channels contribute throughout the entire customer journey leading to conversion?

## Objective

This analysis applies the Linear Attribution model to distribute conversion credit equally across all marketing touchpoints that occur before conversion.

Unlike First-Touch and Last-Touch Attribution, Linear Attribution does not assign all credit to a single interaction. Instead, it recognizes the contribution of every touchpoint in the customer journey.

This model helps marketing teams understand the combined impact of all campaigns and channels involved in driving conversions.

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

Under Linear Attribution:

```text
Meta receives 30
Google receives 30
Email receives 30
```

Each touchpoint receives an equal share of conversion credit.

This approach measures full-funnel contribution across the customer journey.

## SQL Query Used

```sql
SELECT
    CONVERSION_ID,
    USER_ID,
    CAMPAIGN_ID,
    CAMPAIGN_NAME,
    CHANNEL,
    TOUCHPOINT_TIME,
    ATTRIBUTED_REVENUE
FROM INTERMEDIATE.INT_LINEAR_ATTRIBUTION
ORDER BY
    CONVERSION_ID
LIMIT 20;
```

## Metrics Displayed

- Conversion ID
- User ID
- Campaign ID
- Campaign Name
- Channel
- Touchpoint Time
- Attributed Revenue

## Business Value

This analysis helps marketing teams:

- Measure multi-touch campaign contribution
- Understand full customer journeys
- Identify assisting campaigns
- Reduce attribution bias
- Improve budget allocation decisions
- Evaluate marketing performance across the entire funnel
- Recognize channels that influence conversions without necessarily closing them

## Expected Output

The screenshot should display records from:

```text
INTERMEDIATE.INT_LINEAR_ATTRIBUTION
```

Example output:

```text
CONVERSION_ID
USER_ID
CAMPAIGN_ID
CAMPAIGN_NAME
CHANNEL
ATTRIBUTED_REVENUE
```

A single conversion may appear multiple times because attribution credit is distributed across several touchpoints.

## Interpretation

Channels with higher Linear Attributed Revenue contribute consistently throughout customer journeys.

A campaign that performs well under Linear Attribution may not always perform well under First-Touch or Last-Touch Attribution.

Linear Attribution provides a more balanced view of marketing performance because it recognizes every interaction that influenced a conversion.

This analysis is particularly useful when evaluating:

- Multi-channel marketing strategies
- Full-funnel campaign effectiveness
- Customer journey contribution
- Cross-channel marketing influence
- Attribution fairness

## Comparison with Other Attribution Models

### First-Touch Attribution

```text
100% credit assigned to the first touchpoint
```

Answers:

```text
Who introduced the customer?
```

### Last-Touch Attribution

```text
100% credit assigned to the final touchpoint
```

Answers:

```text
Who closed the conversion?
```

### Linear Attribution

```text
Credit distributed equally across all touchpoints
```

Answers:

```text
Who contributed throughout the entire journey?
```


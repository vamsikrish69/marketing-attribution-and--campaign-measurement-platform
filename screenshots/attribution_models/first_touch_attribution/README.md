# First-Touch Attribution

## Business Question

Which campaigns and channels are responsible for introducing customers into the marketing funnel?

## Objective

This analysis applies the First-Touch Attribution model to identify the initial marketing interaction that influenced a customer before conversion.

First-touch attribution assigns 100% of the conversion credit to the first recorded marketing touchpoint within the customer journey.

This model helps marketing teams understand which campaigns are most effective at customer acquisition and awareness generation.

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

Under First-Touch Attribution:

```text
Meta receives 100% conversion credit
```

This approach measures which campaigns and channels are responsible for introducing customers into the journey.

## SQL Query Used

```sql
SELECT
    CONVERSION_ID,
    USER_ID,
    CAMPAIGN_ID,
    CAMPAIGN_NAME,
    CHANNEL,
    TOUCHPOINT_TIME,
    REVENUE AS ATTRIBUTED_REVENUE
FROM INTERMEDIATE.INT_FIRST_TOUCH_ATTRIBUTION
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

- Identify customer acquisition channels
- Understand campaign introduction effectiveness
- Measure awareness campaign contribution
- Allocate budget toward channels that generate new customer journeys
- Optimize top-of-funnel marketing investments

## Expected Output

The screenshot should display records from:

```text
INTERMEDIATE.INT_FIRST_TOUCH_ATTRIBUTION
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

Each conversion receives full attribution credit from the first recorded marketing touchpoint.

## Interpretation

Channels with higher First-Touch revenue are effective at introducing customers into the conversion funnel.

If a channel consistently appears in First-Touch Attribution results, it is likely contributing strongly to customer acquisition and brand discovery.

This analysis is particularly useful when evaluating:

- Awareness campaigns
- Prospecting campaigns
- Customer acquisition initiatives
- Upper-funnel marketing performance

## Screenshot Recommendation

The screenshot should focus on the Snowflake query result output.

Important fields to display:

- Campaign Name
- Channel
- Conversion ID
- Attributed Revenue

The screenshot serves as visual proof that the First-Touch Attribution model is successfully assigning conversion credit to the first marketing touchpoint in each customer journey.

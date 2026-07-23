# Last-Touch Attribution

## Business Question

Which campaigns and channels are responsible for driving the final interaction before conversion?

## Objective

This analysis applies the Last-Touch Attribution model to identify the final marketing interaction that occurred before a customer converted.

Last-touch attribution assigns 100% of the conversion credit to the last recorded marketing touchpoint in the customer journey.

This model helps marketing teams understand which campaigns and channels are most effective at converting customers and closing revenue-generating actions.

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

Under Last-Touch Attribution:

```text
Email receives 100% conversion credit
```

This approach focuses on the final campaign interaction before conversion.

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
FROM INTERMEDIATE.INT_LAST_TOUCH_ATTRIBUTION
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

- Identify conversion-driving campaigns
- Measure closing-channel effectiveness
- Understand final-touch customer behavior
- Optimize lower-funnel marketing activities
- Allocate budget toward high-converting channels
- Improve campaign conversion efficiency

## Expected Output

The screenshot should display records from:

```text
INTERMEDIATE.INT_LAST_TOUCH_ATTRIBUTION
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

Each conversion receives full attribution credit from the final recorded marketing touchpoint before conversion.

## Interpretation

Channels with higher Last-Touch revenue are effective at closing conversions.

If a channel consistently appears in Last-Touch Attribution results, it is likely influencing customer decisions immediately before conversion.

This analysis is particularly useful when evaluating:

- Conversion campaigns
- Retargeting campaigns
- Remarketing campaigns
- Lower-funnel marketing performance
- Revenue-driving activities

## Comparison with First-Touch Attribution

First-Touch Attribution answers:

```text
Which campaigns introduced the customer?
```

Last-Touch Attribution answers:

```text
Which campaigns closed the conversion?
```

Together, these models provide a more complete view of customer acquisition and conversion behavior.

## Screenshot Recommendation

The screenshot should focus on the Snowflake query result output.

Important fields to display:

- Campaign Name
- Channel
- Conversion ID
- Attributed Revenue

The screenshot serves as visual proof that the Last-Touch Attribution model is successfully assigning conversion credit to the final marketing touchpoint in each customer journey.

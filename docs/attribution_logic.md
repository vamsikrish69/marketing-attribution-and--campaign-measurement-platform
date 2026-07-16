
# Attribution Logic

## Overview

Marketing attribution helps determine which campaigns and channels should receive credit for customer conversions.

Customers often interact with multiple campaigns before completing a conversion event. Because of this, different attribution models are required to measure campaign contribution from different perspectives.

This project implements:

- First-Touch Attribution
- Last-Touch Attribution
- Linear Attribution

These models help marketing teams understand how campaigns influence customer acquisition and conversion behavior.

---

## Customer Journey Logic

The foundation of the attribution framework is the customer journey model.

The customer journey model is built using:

```text
INTERMEDIATE.INT_USER_JOURNEY
````

This model links customer touchpoints with conversions.

Touchpoints are matched to conversions using:

```text
USER_ID
```

Only touchpoints that occurred before the conversion are included.

Example:

```text
User U001

Meta Impression
2026-01-05

Google Click
2026-01-08

Email Click
2026-01-10

Conversion
2026-01-12
```

The model calculates:

```text
TOUCHPOINT_SEQUENCE
TOTAL_TOUCHPOINTS
```

These fields are used to generate attribution models.

***

## Attribution Models

### First-Touch Attribution

First-touch attribution assigns 100% of the conversion credit to the first touchpoint in the customer journey.

Example:

```text
Meta Impression
↓
Google Click
↓
Email Click
↓
Conversion
```

Credit Assignment:

```text
Meta = 100%
Google = 0%
Email = 0%
```

Implementation:

```text
TOUCHPOINT_SEQUENCE = 1
```

Snowflake Object:

```text
INTERMEDIATE.INT_FIRST_TOUCH_ATTRIBUTION
```

Business Use Case:

* Customer acquisition analysis
* Awareness campaign measurement
* Top-of-funnel marketing evaluation

Business Question Answered:

```text
Which campaign originally introduced the customer?
```

***

### Last-Touch Attribution

Last-touch attribution assigns 100% of the conversion credit to the final touchpoint before conversion.

Example:

```text
Meta Impression
↓
Google Click
↓
Email Click
↓
Conversion
```

Credit Assignment:

```text
Meta = 0%
Google = 0%
Email = 100%
```

Implementation:

```text
TOUCHPOINT_SEQUENCE = TOTAL_TOUCHPOINTS
```

Snowflake Object:

```text
INTERMEDIATE.INT_LAST_TOUCH_ATTRIBUTION
```

Business Use Case:

* Conversion optimization
* Bottom-of-funnel analysis
* Conversion-driving campaign measurement

Business Question Answered:

```text
Which campaign closed the conversion?
```

***

### Linear Attribution

Linear attribution distributes conversion credit equally across all touchpoints.

Example:

```text
Meta Impression
↓
Google Click
↓
Email Click
↓
Conversion Revenue = 90
```

Credit Assignment:

```text
Meta = 30
Google = 30
Email = 30
```

Formula:

```text
Attributed Revenue =
Revenue / Total Touchpoints
```

```text
Attribution Credit =
1 / Total Touchpoints
```

Snowflake Object:

```text
INTERMEDIATE.INT_LINEAR_ATTRIBUTION
```

Business Use Case:

* Full customer journey analysis
* Multi-touch attribution
* Channel contribution analysis

Business Question Answered:

```text
Which channels contributed across the entire journey?
```

***

## Revenue Attribution Logic

### First-Touch Revenue

Formula:

```text
Attributed Revenue = Full Conversion Revenue
```

Example:

```text
Conversion Revenue = 100

First Touch Campaign Revenue = 100
```

***

### Last-Touch Revenue

Formula:

```text
Attributed Revenue = Full Conversion Revenue
```

Example:

```text
Conversion Revenue = 100

Last Touch Campaign Revenue = 100
```

***

### Linear Revenue

Formula:

```text
Attributed Revenue =
Revenue / Total Touchpoints
```

Example:

```text
Revenue = 120

Touchpoints = 4

Attributed Revenue Per Touchpoint = 30
```

***

## Attribution Model Comparison

### First-Touch Strengths

Advantages:

* Highlights acquisition campaigns
* Measures awareness effectiveness
* Useful for top-of-funnel analysis

Limitations:

* Ignores later interactions
* May underestimate conversion-driving campaigns

***

### Last-Touch Strengths

Advantages:

* Highlights conversion-driving campaigns
* Easy to understand
* Commonly used in marketing reporting

Limitations:

* Ignores acquisition influence
* May over-credit final touchpoints

***

### Linear Attribution Strengths

Advantages:

* Considers the entire customer journey
* Measures supporting campaigns
* More balanced attribution approach

Limitations:

* Assumes equal contribution from all touchpoints
* May not reflect actual customer behavior

***

## Why Multiple Attribution Models Are Needed

No single attribution model fully explains customer behavior.

Different attribution models answer different business questions.

```text
First Touch
↓
Who acquired the customer?

Last Touch
↓
Who converted the customer?

Linear
↓
Who contributed throughout the customer journey?
```

Comparing attribution models allows marketing teams to make more informed budget allocation and campaign optimization decisions.

***

## Final Attribution Reporting

The results of all attribution models are combined into:

```text
ANALYTICS.FCT_ATTRIBUTION_PERFORMANCE
```

This table supports:

* Attribution model comparison
* Campaign performance analysis
* Channel contribution analysis
* Attributed revenue measurement
* Attributed ROAS analysis
* Cost per attributed conversion analysis

***

## Business Questions Answered

The attribution framework helps answer:

* Which campaigns initiate customer journeys?
* Which campaigns drive conversions?
* Which channels assist conversions?
* Which attribution model gives different campaign rankings?
* Which campaigns generate the highest attributed revenue?
* Which channels deliver the strongest attributed ROAS?
* How do customer journeys influence marketing performance?

```


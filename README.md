
# Marketing Attribution & Campaign Measurement Platform

## Overview

This project is a Snowflake-based Marketing Attribution and Campaign Measurement Platform designed to analyze customer journeys, campaign performance, channel contribution, and attributed revenue across multiple marketing channels.

The platform models how customers interact with campaigns before converting and applies attribution logic such as first-touch, last-touch, and linear attribution to measure campaign effectiveness.

This project is built using Snowflake SQL with a layered data architecture across RAW, STAGING, INTERMEDIATE, ANALYTICS, and QUALITY schemas.

---

## Business Problem

Marketing teams spend across multiple paid and owned channels such as Meta, Google, Affiliate, Email, and App campaigns.

A customer may interact with several campaigns before converting. For example:

```text
Meta impression
↓
Google click
↓
Email campaign
↓
Conversion / Deposit / Purchase
````

The main business challenge is:

```text
Which campaign or channel should receive credit for the conversion?
```

This project solves that problem by building attribution models and campaign measurement tables that help answer:

* Which campaign started the customer journey?
* Which campaign closed the conversion?
* Which channels contributed most across the journey?
* Which campaigns generated the best attributed ROAS?
* How do first-touch, last-touch, and linear attribution results differ?
* Which campaigns look strong under one attribution model but weak under another?

***

## Tech Stack

* Snowflake
* SQL
* GitHub
* CSV source datasets
* Future dbt migration planned

***

## Project Architecture

The platform follows a layered warehouse architecture:

```text
RAW
↓
STAGING
↓
INTERMEDIATE
↓
ANALYTICS
↓
QUALITY
```

### RAW Layer

Stores source data loaded from CSV files without transformation.

### STAGING Layer

Standardizes raw data by cleaning channel names, event types, conversion types, and customer attributes.

### INTERMEDIATE Layer

Builds the customer journey and attribution logic.

### ANALYTICS Layer

Creates final business-facing marts for campaign measurement and attribution reporting.

### QUALITY Layer

Validates row counts, null values, accepted values, duplicate keys, and attribution revenue reconciliation.

***

## Data Sources

The project uses five source datasets.

### Campaigns

Contains campaign master data.

```text
campaign_id
campaign_name
channel
campaign_start_date
campaign_end_date
campaign_objective
budget
```

### Customers

Contains customer profile information.

```text
user_id
signup_date
country
device_type
```

### Marketing Touchpoints

Tracks customer interactions with marketing campaigns.

```text
touchpoint_id
user_id
campaign_id
channel
touchpoint_time
event_type
device_type
```

### Conversions

Stores customer conversion events and revenue.

```text
conversion_id
user_id
conversion_time
conversion_type
revenue
```

### Ad Spend

Tracks daily campaign spend, impressions, and clicks.

```text
campaign_id
date
channel
spend
impressions
clicks
```

***

## Dataset Size

```text
Campaigns:              25 rows
Customers:              500 rows
Marketing Touchpoints:  5,500 rows
Conversions:            800 rows
Ad Spend:               2,250 rows
```

***

## Snowflake Schema Design

```text
MARKETING_ATTRIBUTION_DB
│
├── RAW
│   ├── CAMPAIGNS
│   ├── CUSTOMERS
│   ├── MARKETING_TOUCHPOINTS
│   ├── CONVERSIONS
│   └── AD_SPEND
│
├── STAGING
│   ├── STG_CAMPAIGNS
│   ├── STG_CUSTOMERS
│   ├── STG_MARKETING_TOUCHPOINTS
│   ├── STG_CONVERSIONS
│   └── STG_AD_SPEND
│
├── INTERMEDIATE
│   ├── INT_USER_JOURNEY
│   ├── INT_FIRST_TOUCH_ATTRIBUTION
│   ├── INT_LAST_TOUCH_ATTRIBUTION
│   └── INT_LINEAR_ATTRIBUTION
│
├── ANALYTICS
│   ├── FCT_CAMPAIGN_MEASUREMENT
│   ├── FCT_CHANNEL_ATTRIBUTION
│   └── FCT_ATTRIBUTION_PERFORMANCE
│
└── QUALITY
    ├── TEST_ROW_COUNTS
    ├── TEST_NULL_CHECKS
    ├── TEST_ACCEPTED_VALUES
    ├── TEST_DUPLICATE_KEYS
    ├── TEST_ATTRIBUTION_REVENUE_RECON
    └── DATA_QUALITY_SUMMARY
```

***

## Attribution Models

### First-Touch Attribution

First-touch attribution gives full conversion credit to the first campaign touchpoint that occurred before conversion.

Example:

```text
Meta impression → Google click → Email click → Conversion
```

In first-touch attribution:

```text
Meta receives 100% credit
```

This helps identify campaigns and channels that introduce customers into the journey.

***

### Last-Touch Attribution

Last-touch attribution gives full conversion credit to the final campaign touchpoint that occurred before conversion.

Example:

```text
Meta impression → Google click → Email click → Conversion
```

In last-touch attribution:

```text
Email receives 100% credit
```

This helps identify campaigns and channels that close conversions.

***

### Linear Attribution

Linear attribution splits conversion credit equally across all touchpoints before conversion.

Example:

```text
Meta impression → Google click → Email click → Conversion
Revenue = 90
```

In linear attribution:

```text
Meta receives 30
Google receives 30
Email receives 30
```

This helps identify assisting campaigns and channels across the full customer journey.

***

## Key SQL Concepts Used

* CTEs
* Joins
* Window functions
* ROW\_NUMBER()
* COUNT() OVER()
* Aggregations
* CASE logic
* Attribution revenue allocation
* Revenue reconciliation
* Duplicate checks
* Data validation queries

***

## Final Analytics Tables

### FCT\_CAMPAIGN\_MEASUREMENT

Campaign-level reporting table.

This table combines campaign metadata, ad spend, first-touch attribution, last-touch attribution, and linear attribution metrics.

Key columns include:

```text
campaign_id
campaign_name
channel
total_spend
total_impressions
total_clicks
ctr
first_touch_conversions
first_touch_revenue
last_touch_conversions
last_touch_revenue
linear_attributed_conversions
linear_attributed_revenue
first_touch_roas
last_touch_roas
linear_roas
cost_per_linear_attributed_conversion
```

***

### FCT\_CHANNEL\_ATTRIBUTION

Channel-level attribution summary.

This table compares Meta, Google, Affiliate, Email, and App channels using spend, clicks, revenue, conversions, and ROAS.

Key metrics include:

```text
total_spend
channel_ctr
first_touch_revenue
last_touch_revenue
linear_attributed_revenue
first_touch_roas
last_touch_roas
linear_roas
cost_per_linear_attributed_conversion
```

***

### FCT\_ATTRIBUTION\_PERFORMANCE

Attribution model comparison table.

This table combines first-touch, last-touch, and linear attribution outputs into one reporting layer.

It helps compare performance across attribution models.

Key columns include:

```text
campaign_id
campaign_name
channel
attribution_model
total_spend
ctr
attributed_conversions
attributed_revenue
attributed_roas
cost_per_attributed_conversion
```

***

## Key Metrics

* Attributed Revenue
* Attributed Conversions
* First-Touch Revenue
* Last-Touch Revenue
* Linear Attributed Revenue
* CTR
* Attributed ROAS
* Cost per Attributed Conversion
* Channel Contribution
* Campaign Contribution

***

## Data Quality Framework

This project includes a SQL-based data quality layer in Snowflake.

### Quality checks implemented:

* Row count validation
* Null checks
* Accepted values validation
* Duplicate key detection
* Attribution revenue reconciliation

### Final quality summary table:

```text
QUALITY.DATA_QUALITY_SUMMARY
```

Expected output:

```text
ROW_COUNT_CHECKS              PASS
NULL_CHECKS                   PASS
ACCEPTED_VALUES               PASS
DUPLICATE_KEYS                PASS
ATTRIBUTION_REVENUE_RECON     PASS
```

***

## Business Queries Included

The project includes business-facing SQL queries under:

```text
sql/07_business_queries/
```

### Example business queries:

* Top campaigns by linear ROAS
* Channel performance comparison
* Attribution model comparison
* Channel attribution analysis
* Campaign disagreement analysis
* Highest contributing channels
* Customer journey complexity

***

## Example Analysis Questions

This project can answer:

* Which campaigns generate the best attributed ROAS?
* Which channels start the most valuable customer journeys?
* Which channels close the most conversions?
* Which campaigns perform differently under first-touch and last-touch attribution?
* Which marketing channels contribute the most revenue under linear attribution?
* How many touchpoints do customers typically have before converting?
* Which campaigns should receive more budget based on attribution performance?

***

## Repository Structure

```text
marketing-attribution-and-campaign-measurement-platform/
│
├── README.md
│
├── data/
│   └── datasets/
│       ├── ad_spend.csv
│       ├── campaigns.csv
│       ├── conversions.csv
│       ├── customers.csv
│       └── marketing_touchpoints.csv
│
├── docs/
│   ├── architecture.md
│   └── attribution_logic.md
│
└── sql/
    ├── 01_setup/
    ├── 02_staging/
    ├── 03_intermediate/
    ├── 04_analytics/
    ├── 05_quality/
    └── 07_business_queries/
```

***

## How to Run This Project

### Step 1: Create Snowflake objects

Run scripts from:

```text
sql/01_setup/
```

### Step 2: Upload source CSV files

Upload files from:

```text
data/datasets/
```

into the Snowflake RAW schema.

### Step 3: Create staging views

Run scripts from:

```text
sql/02_staging/
```

### Step 4: Create intermediate attribution models

Run scripts from:

```text
sql/03_intermediate/
```

### Step 5: Create final analytics tables

Run scripts from:

```text
sql/04_analytics/
```

### Step 6: Run data quality checks

Run scripts from:

```text
sql/05_quality/
```

### Step 7: Run business queries

Use the queries from:

```text
sql/07_business_queries/
```

***

## Project Outcome

This project demonstrates the ability to build a Snowflake-based marketing attribution platform that supports customer journey analytics, campaign measurement, attribution model comparison, and marketing performance reporting.

The final platform provides trusted analytical tables that can support:

* Marketing performance reporting
* Attribution analysis
* Channel investment optimization
* Campaign measurement
* Customer journey analysis
* Data quality monitoring

***

## Future Enhancements

* Migrate Snowflake SQL logic into dbt models
* Add dbt tests and documentation
* Add source freshness checks
* Add incremental models
* Add Snowflake Tasks for scheduled refresh
* Add dashboard integration
* Add Snowflake Cortex or LLM-assisted analytics for campaign insights

````

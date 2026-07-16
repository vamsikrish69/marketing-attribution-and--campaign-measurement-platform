## Marketing Attribution & Campaign Measurement Platform

This project builds a Snowflake-based Marketing Attribution and Campaign Measurement Platform designed to analyze customer journeys, campaign effectiveness, channel contribution, and attributed revenue across multiple marketing channels.

The platform helps marketing teams understand how customers interact with campaigns before converting and applies multiple attribution models to measure campaign performance and marketing investment effectiveness.

---

## Business Problem

Marketing organizations invest across multiple channels such as:

- Meta Ads
- Google Ads
- Affiliate Marketing
- Email Campaigns
- App-Based Campaigns

Customers frequently interact with several campaigns before completing a conversion event.

Example customer journey:

```text
Meta Impression
↓
Google Click
↓
Email Campaign
↓
Conversion
````

In such scenarios, marketing teams need answers to the following questions:

* Which campaign introduced the customer?
* Which campaign influenced the final conversion?
* Which channels contributed throughout the customer journey?
* Which campaigns generated the most revenue?
* Which marketing investments delivered the highest return?

This project addresses these challenges using customer journey modeling and attribution analysis.

***

## Project Objectives

The primary objectives of this project are:

* Build an end-to-end marketing attribution platform using Snowflake.
* Model customer journeys across multiple marketing touchpoints.
* Measure campaign contribution using multiple attribution methodologies.
* Create business-ready reporting datasets for campaign measurement.
* Calculate marketing performance KPIs and attributed revenue metrics.
* Implement SQL-based data quality validation checks.
* Deliver analytical data products that support marketing decision-making.

***

## Data Sources

The platform integrates five marketing datasets:

### Campaigns

Stores campaign master data including campaign details, objectives, budgets, and marketing channels.

### Customers

Stores customer profile information including signup details, country, and device type.

### Marketing Touchpoints

Stores all customer interactions with marketing campaigns including impressions, clicks, app installs, and landing page visits.

### Conversions

Stores conversion events including signups, deposits, purchases, subscriptions, and associated revenue.

### Ad Spend

Stores campaign-level advertising spend, impressions, and click performance data.

***

## Dataset Volumes

```text
Campaigns:                25
Customers:               500
Marketing Touchpoints:  5,500
Conversions:             800
Ad Spend:              2,250
```

***

## Attribution Models Implemented

### First-Touch Attribution

Assigns 100% conversion credit to the first marketing interaction before conversion.

Business Purpose:

* Measure customer acquisition effectiveness.
* Identify campaigns that initiate customer journeys.

### Last-Touch Attribution

Assigns 100% conversion credit to the final marketing interaction before conversion.

Business Purpose:

* Measure conversion-driving effectiveness.
* Identify campaigns responsible for closing conversions.

### Linear Attribution

Distributes conversion credit equally across all touchpoints before conversion.

Business Purpose:

* Measure full customer journey contribution.
* Identify supporting campaigns and channels.

***

## Final Deliverables

The project produces three business-facing analytical marts:

### Campaign Measurement Mart

```text
ANALYTICS.FCT_CAMPAIGN_MEASUREMENT
```

Provides campaign-level reporting including spend, attributed revenue, conversions, CTR, ROAS, and cost metrics.

### Channel Attribution Mart

```text
ANALYTICS.FCT_CHANNEL_ATTRIBUTION
```

Provides channel-level reporting across Meta, Google, Affiliate, Email, and App channels.

### Attribution Performance Mart

```text
ANALYTICS.FCT_ATTRIBUTION_PERFORMANCE
```

Provides side-by-side comparison of first-touch, last-touch, and linear attribution models.

***

## Key Metrics

The platform calculates the following KPIs:

* Attributed Revenue
* Attributed Conversions
* First-Touch Revenue
* Last-Touch Revenue
* Linear Attributed Revenue
* CTR (Click Through Rate)
* Attributed ROAS
* Cost per Attributed Conversion
* Campaign Contribution
* Channel Contribution

***

## Data Quality Framework

The project includes a dedicated SQL-based quality validation layer.

Quality checks include:

* Row Count Validation
* Null Value Checks
* Accepted Value Validation
* Duplicate Key Detection
* Attribution Revenue Reconciliation

These validations ensure data accuracy, consistency, and trustworthiness across the platform.

***

## Business Questions Answered

This platform helps answer:

* Which campaigns generate the highest attributed revenue?
* Which channels are most effective at acquiring customers?
* Which channels are most effective at converting customers?
* Which campaigns deliver the best attributed ROAS?
* How do attribution models impact campaign performance interpretation?
* Which channels contribute throughout the entire customer journey?
* How complex are customer conversion journeys?

***

## Project Outcome

This project demonstrates the implementation of a complete marketing attribution and campaign measurement platform using Snowflake SQL.

The solution combines customer journey analysis, attribution modeling, business KPI measurement, campaign performance evaluation, and data quality validation to provide trusted analytical datasets for marketing decision-making and investment optimization.

```
```

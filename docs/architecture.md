
# Architecture

## Overview

This project uses a layered Snowflake architecture to transform raw marketing data into trusted analytical datasets for campaign measurement and attribution reporting.

The architecture separates data ingestion, transformation, business logic, analytics, and quality validation into dedicated layers.

---

## High-Level Architecture

```text
CSV Datasets
      │
      ▼

RAW Layer
      │
      ▼

STAGING Layer
      │
      ▼

INTERMEDIATE Layer
      │
      ▼

ANALYTICS Layer
      │
      ▼

QUALITY Layer
```

---

## Snowflake Database Structure

```text
MARKETING_ATTRIBUTION_DB
│
├── RAW
├── STAGING
├── INTERMEDIATE
├── ANALYTICS
└── QUALITY
```

Each schema has a defined responsibility and supports a specific stage of the analytical workflow.

---

## RAW Layer

Purpose:

Store source datasets exactly as loaded from CSV files without applying business transformations.

Tables:

```text
RAW.CAMPAIGNS
RAW.CUSTOMERS
RAW.MARKETING_TOUCHPOINTS
RAW.CONVERSIONS
RAW.AD_SPEND
```

Responsibilities:

- Source data storage
- Initial data ingestion
- Historical source preservation
- Foundation for downstream transformations

No business logic is applied in this layer.

---

## STAGING Layer

Purpose:

Standardize and clean raw source data before it is used in analytical transformations.

Views:

```text
STAGING.STG_CAMPAIGNS
STAGING.STG_CUSTOMERS
STAGING.STG_MARKETING_TOUCHPOINTS
STAGING.STG_CONVERSIONS
STAGING.STG_AD_SPEND
```

Transformations:

- Standardize channel names
- Standardize conversion types
- Standardize event types
- Normalize text fields
- Prepare data for joins and analytical processing

The staging layer is implemented as views to avoid data duplication and keep storage costs low.

---

## INTERMEDIATE Layer

Purpose:

Implement business logic and attribution calculations.

Views:

```text
INTERMEDIATE.INT_USER_JOURNEY

INTERMEDIATE.INT_FIRST_TOUCH_ATTRIBUTION

INTERMEDIATE.INT_LAST_TOUCH_ATTRIBUTION

INTERMEDIATE.INT_LINEAR_ATTRIBUTION
```

Responsibilities:

- Customer journey construction
- Touchpoint sequencing
- Attribution calculations
- Revenue allocation logic
- Marketing influence modeling

This layer contains the core analytical logic of the platform.

---

## Customer Journey Flow

```text
Customer
      │
      ▼

Marketing Touchpoints
      │
      ▼

Conversion Event
      │
      ▼

Attribution Model
```

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

The customer journey model links touchpoints to conversions and prepares data for attribution analysis.

---

## ANALYTICS Layer

Purpose:

Provide business-ready reporting tables.

Tables:

```text
ANALYTICS.FCT_CAMPAIGN_MEASUREMENT

ANALYTICS.FCT_CHANNEL_ATTRIBUTION

ANALYTICS.FCT_ATTRIBUTION_PERFORMANCE
```

Responsibilities:

- Campaign reporting
- Channel reporting
- Attribution reporting
- KPI measurement
- Marketing performance analysis

This is the primary layer used by analysts and stakeholders.

---

## Campaign Measurement Mart

Object:

```text
FCT_CAMPAIGN_MEASUREMENT
```

Provides:

- Spend
- Impressions
- Clicks
- CTR
- First-touch revenue
- Last-touch revenue
- Linear revenue
- ROAS
- Cost per attributed conversion

Granularity:

```text
Campaign Level
```

---

## Channel Attribution Mart

Object:

```text
FCT_CHANNEL_ATTRIBUTION
```

Provides:

- Channel contribution
- Channel spend
- Channel revenue
- Channel conversions
- Channel ROAS

Granularity:

```text
Channel Level
```

---

## Attribution Performance Mart

Object:

```text
FCT_ATTRIBUTION_PERFORMANCE
```

Provides side-by-side comparison of:

```text
First-Touch Attribution

Last-Touch Attribution

Linear Attribution
```

Granularity:

```text
Campaign + Attribution Model
```

---

## QUALITY Layer

Purpose:

Validate data reliability and analytical correctness.

Objects:

```text
QUALITY.TEST_ROW_COUNTS

QUALITY.TEST_NULL_CHECKS

QUALITY.TEST_ACCEPTED_VALUES

QUALITY.TEST_DUPLICATE_KEYS

QUALITY.TEST_ATTRIBUTION_REVENUE_RECON

QUALITY.DATA_QUALITY_SUMMARY
```

Validation Areas:

- Data completeness
- Data accuracy
- Data consistency
- Revenue reconciliation
- Attribution validation

The quality layer ensures trust in downstream reporting.

---

## End-to-End Data Flow

```text
Source CSV Files
       │
       ▼

RAW Tables
       │
       ▼

STAGING Views
       │
       ▼

Customer Journey Model
       │
       ▼

Attribution Models
       │
       ├── First-Touch
       ├── Last-Touch
       └── Linear
       │
       ▼

Analytics Marts
       │
       ▼

Quality Validation
```

---

## Benefits of this Architecture

The layered architecture provides:

- Clear separation of responsibilities
- Improved maintainability
- Easier troubleshooting
- Reusable transformations
- Better data governance
- Business-friendly reporting structures
- Scalable analytics development

This design follows modern analytics engineering and Snowflake data platform best practices for building trusted analytical data products.

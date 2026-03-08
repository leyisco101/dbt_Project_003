
Data Flow Explanation

1. Sources

Raw operational tables are ingested into BigQuery:

trips_raw

drivers_raw

riders_raw

payments_raw

cities_raw

These are treated as immutable source-of-truth datasets.


2. Staging Layer (stg_*)

Purpose: Clean and standardize raw data.

Transformations:

Data type casting

Null handling

Column renaming

Status normalization

Timestamp formatting

This layer ensures consistent schemas across all downstream models.

3. Intermediate Layer (int_*)

Purpose: Business logic and enrichment.

Transformations:

Trip enrichment

Payment enrichment

Revenue calculations

Fraud flags

Rider & driver metrics

Duplicate payment detection

This layer prepares reusable logic for marts.


4. Snapshots (SCD Type 2)

Tracks historical changes in driver attributes:

Driver status changes

Vehicle reassignment

Rating updates

This enables historical analysis and time‑travel reporting.

5. Marts Layer

Final analytics-ready tables.

Dimension Tables

dim_drivers

dim_riders

dim_cities

dim_date

Fact Table

fct_trips

Optimized for BI tools and analytical queries.


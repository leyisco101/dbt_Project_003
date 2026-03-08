{{ config(materialized='table') }}

with trips as (
    select
        trip_id,
        rider_id,
        driver_id,
        city_id,
        requested_at,
        start_time,                     -- was: pickup_at
        dropoff_at,
        trip_status,                    -- was: status
        actual_fare,
        surge_multiplier,
        trip_duration_minutes,
        corporate_trip_flag,
        extreme_surge_flag,
        updated_at
    from {{ ref('int_trips_enriched') }}
),

payments as (
    select
        trip_id,
        payment_status,
        payment_provider,
        net_revenue,
        payment_count,
        failed_payment_completed_trip_flag
    from {{ ref('int_payments_enriched') }}
)

select
    t.trip_id,
    t.rider_id,
    t.driver_id,
    t.city_id,
    t.requested_at,
    t.start_time,
    t.dropoff_at,
    t.trip_status,
    t.actual_fare,
    t.surge_multiplier,
    t.trip_duration_minutes,
    t.corporate_trip_flag,
    t.extreme_surge_flag,
    p.payment_status,
    p.payment_provider,
    p.net_revenue,
    p.payment_count,
    p.failed_payment_completed_trip_flag,
    t.updated_at

from trips t
left join payments p
    on t.trip_id = p.trip_id
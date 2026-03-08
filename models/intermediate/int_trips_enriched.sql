{{ config(
    materialized='table',
    unique_key='trip_id'
) }}

with trips as (

    select *
    from {{ ref('stg_trips') }}

),

final as (

    select
        trip_id,
        rider_id,
        driver_id,
        vehicle_id,
        city_id,

        requested_at,
        start_time,
        dropoff_at,

        trip_status,
        estimated_fare,
        actual_fare,
        surge_multiplier,
        payment_method,
        is_corporate,

        -- ✅ trip_duration_minutes
        timestamp_diff(dropoff_at, start_time, minute) as trip_duration_minutes,

        -- ✅ corporate_trip_flag
        case when is_corporate then 1 else 0 end as corporate_trip_flag,

        -- ✅ extreme surge fraud flag
        case when surge_multiplier > 10 then 1 else 0 end as extreme_surge_flag,

        created_at,
        updated_at

    from trips
)

select * from final
{{ config(materialized='view') }}

select
    cast(trip_id as int64) as trip_id,
    cast(rider_id as int64) as rider_id,
    cast(driver_id as int64) as driver_id,
    cast(vehicle_id as string) as vehicle_id,
    cast(city_id as int64) as city_id,
    cast(requested_at as timestamp) as requested_at,
    cast(pickup_at as timestamp) as start_time,
    cast(dropoff_at as timestamp) as dropoff_at,
    lower(status) as trip_status,
    cast(estimated_fare as float64) as estimated_fare,
    cast(actual_fare as float64) as actual_fare,
    cast(surge_multiplier as float64) as surge_multiplier,
    lower(payment_method) as payment_method,
    is_corporate,
    cast(created_at as timestamp) as created_at,
    cast(updated_at as timestamp) as updated_at

from {{ source('my_dbt_project', 'trips_raw') }}
where trip_id is not null

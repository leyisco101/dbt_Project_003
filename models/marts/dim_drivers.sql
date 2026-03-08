{{ config(materialized='table') }}

select
    d.driver_id,
    d.city_id,
    d.vehicle_id,
    d.driver_status,
    d.rating,
    d.onboarding_date,

    -- metrics from int_driver_metrics
    m.driver_lifetime_trips

from {{ ref('stg_drivers') }} d
left join {{ ref('int_driver_metrics') }} m
    on d.driver_id = m.driver_id
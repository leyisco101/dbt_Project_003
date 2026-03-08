{{ config(materialized='view') }}

with cleaned as (
    select
        cast(driver_id as int64) as driver_id,
        cast(onboarding_date as date) as onboarding_date,
        lower(driver_status) as driver_status,
        cast(city_id as int64) as city_id,
        cast(vehicle_id as string) as vehicle_id,
        cast(rating as float64) as rating,
        created_at,
        updated_at
    from {{ source('my_dbt_project', 'drivers_raw') }}
    where driver_id is not null
),

deduped as (
    select *
    from cleaned
    qualify row_number() over (
        partition by driver_id
        order by updated_at desc
    ) = 1
)

select * from deduped

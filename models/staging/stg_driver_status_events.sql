{{ config(materialized='view') }}


select
    cast(event_id as bigint) as event_id,
    cast(driver_id as bigint) as driver_id,
    lower(status) as driver_status,
    cast(event_timestamp as timestamp) as event_timestamp


from {{ source('my_dbt_project', 'driver_status_events_raw') }}

where event_id is not null
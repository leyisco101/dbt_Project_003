{{ config(materialized='view') }}

with cleaned as (
    select
        cast(payment_id as int64) as payment_id,
        cast(trip_id as int64) as trip_id,
        lower(payment_status) as payment_status,
        lower(payment_provider) as payment_provider,
        cast(amount as float64) as amount,
        cast(fee as float64) as fee,
        lower(currency) as currency,
        created_at
    from {{ source('my_dbt_project', 'payments_raw') }}
    where payment_id is not null
)

select * from cleaned

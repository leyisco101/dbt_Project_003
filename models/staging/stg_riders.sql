{{ config(materialized='view') }}


select
    cast(rider_id as bigint) as rider_id,
    cast(signup_date as date) as signup_date,
    lower(country) as country,
    referral_code,
    created_at



from {{ source('my_dbt_project', 'riders_raw') }}

where rider_id is not null
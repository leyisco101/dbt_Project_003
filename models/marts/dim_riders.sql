{{ config(materialized='table') }}

select
    r.rider_id,
    r.country,
    r.referral_code,
    r.signup_date,
    r.created_at,

    m.rider_total_trips,
    m.rider_lifetime_value

from {{ ref('stg_riders') }} r
left join {{ ref('int_rider_metrics') }} m
    on r.rider_id = m.rider_id
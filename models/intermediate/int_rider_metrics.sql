{{ config(materialized='table') }}

with trips as (
    select *
    from {{ ref('int_trips_enriched') }}
),

payments as (
    select trip_id, net_revenue
    from {{ ref('int_payments_enriched') }}
),

rider_metrics as (
    select
        t.rider_id,
        count(t.trip_id)        as rider_total_trips,
        sum(p.net_revenue)      as rider_lifetime_value

    from trips t
    left join payments p
        on t.trip_id = p.trip_id

    group by t.rider_id
)

select * from rider_metrics
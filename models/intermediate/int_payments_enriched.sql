{{ config(
    materialized='table',
    unique_key='payment_id'
) }}

with payments as (

    select *
    from {{ ref('stg_payments') }}

),

trips as (
    select trip_id, trip_status
    from {{ ref('stg_trips') }}
),

joined as (

    select
        p.payment_id,
        p.trip_id,
        p.payment_status,
        p.payment_provider,
        p.amount,
        p.fee,
        p.currency,
        p.created_at,

        t.trip_status,

        -- ✅ net revenue
        (p.amount - p.fee) as net_revenue,

        -- ✅ duplicate payment fraud
        count(*) over (partition by p.trip_id) as payment_count,

        -- ✅ failed payment on completed trip
        case 
            when t.trip_status = 'completed'
             and p.payment_status != 'success'
            then 1 else 0
        end as failed_payment_completed_trip_flag

    from payments p
    left join trips t
        on p.trip_id = t.trip_id
)

select * from joined
{{ config(materialized='table') }}

WITH payments AS (

    SELECT *
    FROM {{ ref('int_payments_enriched') }}

),

duplicate_trip_payments AS (

    SELECT
        trip_id,
        COUNT(payment_id) AS payment_count

    FROM payments
    GROUP BY trip_id

)

SELECT

    p.trip_id,
    p.payment_id,
    p.net_revenue,

    CASE
        WHEN d.payment_count > 1
        THEN TRUE
        ELSE FALSE
    END AS duplicate_trip_payment_flag

FROM payments p
LEFT JOIN duplicate_trip_payments d
ON p.trip_id = d.trip_id

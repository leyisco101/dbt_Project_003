{{ config(materialized='table') }}

WITH trips AS (

    SELECT *
    FROM {{ ref('stg_trips') }}

)

SELECT

    driver_id,

    COUNT(trip_id) AS driver_lifetime_trips

FROM trips

GROUP BY driver_id

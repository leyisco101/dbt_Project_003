{{ config(materialized='table') }}

select
    city_id,
    city_name,
    country,
    launch_date

from {{ ref('stg_cities') }}
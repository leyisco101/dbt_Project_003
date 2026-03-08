{{ config(materialized='view') }}

select
    cast(city_id as int64) as city_id,
    city_name,
    country,
    cast(launch_date as date) as launch_date

from {{ source('my_dbt_project', 'cities_raw') }}
where city_id is not null

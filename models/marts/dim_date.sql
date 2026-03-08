{{ config(materialized='table') }}

with date_spine as (
    select date_day
    from unnest(
        generate_date_array('2023-01-01', '2030-12-31', interval 1 day)
    ) as date_day
)

select
    date_day                                        as date_id,
    extract(year from date_day)                     as year,
    extract(month from date_day)                    as month,
    extract(day from date_day)                      as day,
    extract(dayofweek from date_day)                as day_of_week,
    extract(week from date_day)                     as week_of_year,
    extract(quarter from date_day)                  as quarter,
    format_date('%B', date_day)                     as month_name,
    format_date('%A', date_day)                     as day_name,
    format_date('%Y-%m', date_day)                  as year_month,
    case when extract(dayofweek from date_day)
         in (1, 7) then true else false end         as is_weekend
from date_spine
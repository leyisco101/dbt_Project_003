{% snapshot drivers_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='driver_id',
        strategy='timestamp',
        updated_at='updated_at',
        invalidate_hard_deletes=True
    )
}}

select
    driver_id,
    city_id,
    vehicle_id,
    driver_status,
    rating,
    updated_at
from {{ ref('stg_drivers') }}

{% endsnapshot %}

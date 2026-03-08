select t.trip_id
from {{ ref('int_trips_enriched') }} t
left join {{ ref('int_payments_enriched') }} p
on t.trip_id = p.trip_id
where t.status = 'completed' and p.payment_id is null

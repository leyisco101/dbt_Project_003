select *
from {{ ref('int_payments_enriched') }}
where net_revenue < 0

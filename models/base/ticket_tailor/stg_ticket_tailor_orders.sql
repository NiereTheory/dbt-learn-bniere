select
    event_id
    , tickets_purchased
    , order_cancelled
from {{source('ticket_tailor','orders')}}

/*
o.event_id as order_event_id
      , o.tickets_purchased
      , o.order_cancelled
*/
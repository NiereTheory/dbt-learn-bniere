with cte as (
  select
      o.event_id as order_event_id
      , o.tickets_purchased
      , o.order_cancelled
      , c.status as charge_status
      , r.status as refund_status
  from {{ ref('stg_ticket_tailor_orders') }}
  left join {{ ref('stripe_charges') }} c
      ON o.transaction_id = c.id
  left join {{ ref('stripe_refunds') }} r
      ON r.charge_id = o.transaction_id
)
SELECT 
    order_event_id::number as event_id
    , sum(tickets_purchased) as tickets_ordered
    , sum(case when charge_status in ('paid', 'succeeded') and order_cancelled::number = 0 then tickets_purchased else 0 end) as tickets_charged
    , sum(case when refund_status = 'succeeded' then tickets_purchased else 0 end) as refunds_placed
    , sum(order_cancelled::number) as order_cancelled
FROM cte
group by 1
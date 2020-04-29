{{ config(materialized='table') }}
select 
    o.order_id
    , o.customer_id
    , p.amount
from stg_orders o
inner join raw.stripe.payment p
    on o.order_id = p."orderID"
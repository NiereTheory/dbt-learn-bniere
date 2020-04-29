with customers as (
    select * from {{ ref('stg_customers') }}
),
orders as (
    select * from {{ ref('stg_orders') }}
),
ltv as (
    select customer_id, SUM(amount) as lifetime_value
    from {{ ref('orders') }}
    group by 1
),
customer_orders as (
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders
    from orders
    group by 1
),
final as (
    select
        c.customer_id,
        c.first_name,
        c.last_name,
        co.first_order_date,
        co.most_recent_order_date,
        coalesce(co.number_of_orders, 0) as number_of_orders,
        coalesce(ltv.lifetime_value, 0) as lifetime_value
    from customers c
    left join customer_orders co
        ON co.customer_id = c.customer_id
    left join ltv
        ON ltv.customer_id = c.customer_id
)
select * from final
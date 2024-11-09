{{
  config(
    materialized='table'
  )
}}

with cte_orders as (
  select * from {{ ref('orders') }}
)
,cte_order_details as (
  select * from {{ ref('order_details') }}
)
,cte_join as (
  select
    cte_orders.order_id
    ,cte_orders.customer_id
    ,cte_orders.employee_id
    ,cte_orders.order_date
    ,cte_orders.required_date
    ,cte_orders.shipped_date
    ,cte_orders.ship_via
    ,cte_orders.freight
    ,cte_orders.ship_name
    ,cte_orders.ship_address
    ,cte_orders.ship_city
    ,cte_orders.ship_region
    ,cte_orders.ship_postal_code
    ,cte_orders.ship_country
    ,cte_order_details.product_id
    ,cte_order_details.unit_price
    ,cte_order_details.quantity
    ,cte_order_details.discount
  from cte_orders
  left join cte_order_details
    on cte_orders.order_id = cte_order_details.order_id
)
select * from cte_join
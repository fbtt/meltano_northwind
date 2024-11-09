{{
  config(
    materialized='view'
  )
}}

with base as (
    select *
    from {{ source('default', 'order_details') }}
)
select
  order_id
  ,product_id
  ,unit_price
  ,quantity
  ,discount
from base

{{
  config(
    materialized='view'
  )
}}

with base as (
    select *
    from {{ source('default', 'shippers') }}
)
select
  shipper_id
  ,company_name
  ,phone
from base

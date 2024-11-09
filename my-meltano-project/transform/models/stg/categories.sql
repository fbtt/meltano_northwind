{{
  config(
    materialized='view'
  )
}}

with base as (
    select *
    from {{ source('default', 'categories') }}
)
select
  category_id
  ,category_name
  ,description
  ,picture
from base

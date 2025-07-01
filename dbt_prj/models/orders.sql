{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}
{{
    config(
        materialized='incremental',
        unique_key='order_id'
    )
}}


with final as (

    select * from {{ ref('stg_orders') }}

)
select * from final

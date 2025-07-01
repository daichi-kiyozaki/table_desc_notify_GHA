{{
    config(
        materialized='incremental',
        unique_key='customer_id'
    )
}}

with final as (

    select * from {{ ref('stg_customers') }}å

)

select * from final

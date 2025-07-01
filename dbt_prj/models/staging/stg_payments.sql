{{
    config(
        materialized='incremental',
        unique_key='payment_id'
    )
}}

with source as (
    
    {#-
    Normally we would select from the table here, but we are using seeds to load
    our data in this project
    #}
    select * from {{ ref('raw_payments') }}

{% if is_incremental() %}

    where updated_at > (select max( updated_at ) from {{ this }})

{% endif %}

),

renamed as (

    select
        id as payment_id,
        order_id,
        payment_method,
        -- `amount` is currently stored in cents, so we convert it to dollars
        amount / 100 as amount,
        created_at,
        updated_at,
        current_timestamp as loaded_at
    from source

)

select * from renamed

{{
    config(
        materialized='incremental',
        unique_key='order_id'
    )
}}

with source as (

    {#-
    Normally we would select from the table here, but we are using seeds to load
    our data in this project
    #}
    select * from {{ ref('raw_orders') }}

    where order_date = cast( '2018-01-01' as date )

{% if is_incremental() %}

    and updated_at > (select max( updated_at ) from {{ this }})

{% endif %}

),

renamed as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status,
        created_at,
        updated_at,
        current_timestamp as loaded_at
    from source

)

select * from renamed

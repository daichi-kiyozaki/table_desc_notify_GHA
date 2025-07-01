{{
    config(
        materialized='incremental',
        unique_key='customer_id'
    )
}}

with source as (

    {#-
    Normally we would select from the table here, but we are using seeds to load
    our data in this project
    #}
    select * from {{ ref('raw_customers') }}


{% if is_incremental() %}

    where updated_at > (select max( updated_at) from {{ this }})

{% endif %}

),

renamed as (

    select
        id as customer_id,
        first_name,
        last_name,
        created_at,
        updated_at,
        current_timestamp as loaded_at
    from source

)

select * from renamed

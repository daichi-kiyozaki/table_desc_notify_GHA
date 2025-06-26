{{ config(materialized='view') }}

WITH src AS (

    SELECT *
    FROM {{ source('raw', 'customers') }}

)

SELECT
    id  AS customer_id,
    first_name,
    last_name,
    created_at
FROM src

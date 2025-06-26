{{ config(materialized='view') }}

WITH orders AS (

    SELECT *
    FROM {{ source('raw', 'orders') }}

)

SELECT
    order_id,
    customer_id,
    order_date,
    order_total
FROM orders

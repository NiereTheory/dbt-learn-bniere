{{ 
    config(
        materialized='incremental',
        incremental_strategy='delete+insert',
        unique_key='id'
    )
}}
SELECT
    m.id
    , m.val
    , md5(m.id || m.val) as hash_key
FROM analytics.dbt_bniere.main_data m
WHERE id = 2
-- {% if is_incremental() %}
--     WHERE id NOT IN ( select ID from this )
-- {% endif %}
/*
    Incremental
*/

{{ config(
    materialized='table' if flags.FULL_REFRESH else 'incremental',
    incremental_strategy='microbatch',
    event_time='ad_date',
    begin='2025-01-01' if target.name == 'production' else modules.datetime.datetime.now().isoformat(),
    batch_size='month',
    lookback=1,
    on_schema_change= 'fail'
) }}


SELECT *
FROM {{ ref('int_marketing_ads_stats') }}

{% if is_incremental() %}
    WHERE ad_date >= (SELECT MAX(ad_date) FROM {{ this }})
{% endif %}

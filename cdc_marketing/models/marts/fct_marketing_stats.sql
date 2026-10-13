/*
    Incremental
*/
 {{ config(
    unique_key='ads_stats_key'
) }}

SELECT *
FROM {{ ref('int_marketing_ads_stats') }}

{% if is_incremental() %}
    WHERE ad_date >= (SELECT MAX(ad_date) FROM {{ this }})
{% endif %}

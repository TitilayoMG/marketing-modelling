/*
    Incremental
*/
 {{ config(
    unique_key='ad_id'
) }}

SELECT *
FROM {{ ref('int_marketing_ads') }}

{% if is_incremental() %}
    WHERE ad_updated_at >= (SELECT MAX(ad_updated_at) FROM {{ this }})
{% endif %}

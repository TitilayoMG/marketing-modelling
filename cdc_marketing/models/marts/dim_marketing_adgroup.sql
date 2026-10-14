/*
    Incremental
*/
 {{ config(
    unique_key=['ad_group_id', 'ad_group_updated_at', 'data_src'] 
) }}

SELECT *
FROM {{ ref('int_marketing_adgroup') }}

{% if is_incremental() %}
    WHERE ad_group_updated_at >= (SELECT MAX(ad_group_updated_at) FROM {{ this }})
{% endif %}

SELECT *
FROM {{ ref('stg_facebook_ads_stats') }}
WHERE ad_spend < 0
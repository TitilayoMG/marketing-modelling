SELECT *
FROM {{ ref('stg_facebook_ads_stats') }}
WHERE ads_stats_key IS NULL
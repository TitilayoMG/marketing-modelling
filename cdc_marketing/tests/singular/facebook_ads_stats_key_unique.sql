SELECT ads_stats_key
FROM {{ ref('stg_facebook_ads_stats') }}
GROUP BY ads_stats_key
HAVING COUNT(*) > 1
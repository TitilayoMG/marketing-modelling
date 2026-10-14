{{
    config(
        event_time='ad_date',
    )
}}

WITH facebook_ads AS (
    SELECT DISTINCT
        ads_stats.ads_stats_key,
        ads_stats.ad_id,
        ads_stats.account_id,
        ads_stats.ad_spend,
        ads_stats.ad_impressions,
        ads_stats.ad_clicks,
        ads_stats.ad_date,
        CAST(NULL AS STRING) AS ad_country,
        fb_account.ad_currency_code,
        'facebook_ads' AS data_src,
        ads.campaign_id,
        ads.ad_group_id
    FROM {{ ref('stg_facebook_ads_stats') }} AS ads_stats
    LEFT JOIN {{ ref('stg_facebook_account') }} AS fb_account
        ON ads_stats.account_id = fb_account.account_id
    LEFT JOIN {{ ref('stg_facebook_ads') }} AS ads
        ON ads_stats.ad_id = ads.ad_id

),

snapchat_ads AS (
    SELECT DISTINCT
        ads_stats.ads_stats_key,
        ads_stats.ad_id,
        camp.account_id,
        ads_stats.ad_spend,
        ads_stats.ad_impressions,
        ads_stats.ad_clicks,
        ads_stats.ad_date,
        ads_stats.ad_country,
        ads_stats.ad_currency_code,
        ads_stats.data_src,
        camp.campaign_id,
        adgroup.ad_group_id
    FROM {{ ref('stg_snapchat_ads_stats') }} AS ads_stats
    LEFT JOIN {{ ref('stg_snapchat_ads') }} AS ads
        ON ads_stats.ad_id = ads.ad_id
    LEFT JOIN {{ ref('stg_snapchat_adgroup') }} AS adgroup
        ON ads.ad_group_id = adgroup.ad_group_id
    LEFT JOIN {{ ref('stg_snapchat_campaign') }} AS camp
        ON adgroup.campaign_id = camp.campaign_id

),

combined_ads_stats AS (
    SELECT * FROM facebook_ads

    UNION ALL

    SELECT * FROM snapchat_ads
)

SELECT * FROM combined_ads_stats

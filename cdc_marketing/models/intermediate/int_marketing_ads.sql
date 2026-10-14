WITH facebook_ads AS (
    SELECT DISTINCT
        ad_id,
        ad_name,
        ad_status,
        ad_updated_at,
        'facebook_ads' AS data_src
    FROM {{ ref('stg_facebook_ads') }}
),

snapchat_ads AS (
    SELECT DISTINCT
        ad_id,
        ad_name,
        CAST(NULL AS STRING) AS ad_status,
        ad_updated_at,
        'snapchat_ads' AS data_src
    FROM {{ ref('stg_snapchat_ads') }}
),

combined AS (
    SELECT * FROM facebook_ads
    UNION ALL
    SELECT * FROM snapchat_ads
)

SELECT * FROM combined

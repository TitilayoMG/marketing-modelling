WITH facebook_adgroup AS (
    SELECT
        ad_group_id,
        ad_group_name,
        ad_group_updated_at,
        'facebook_ads' AS data_src
    FROM {{ ref('stg_facebook_adgroup') }}
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY ad_group_id
        ORDER BY ad_group_updated_at DESC
    ) = 1
),

snapchat_adgroup AS (
    SELECT
        ad_group_id,
        ad_group_name,
        ad_group_updated_at,
        'snapchat_ads' AS data_src
    FROM {{ ref('stg_snapchat_adgroup') }}
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY ad_group_id
        ORDER BY ad_group_updated_at DESC
    ) = 1
),

combined AS (
    SELECT * FROM facebook_adgroup
    UNION ALL
    SELECT * FROM snapchat_adgroup
)

SELECT * FROM combined

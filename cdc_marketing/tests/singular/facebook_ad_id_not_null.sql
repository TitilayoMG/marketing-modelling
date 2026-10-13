
SELECT *
FROM {{ ref('stg_facebook_ads') }}
WHERE ad_id IS NULL
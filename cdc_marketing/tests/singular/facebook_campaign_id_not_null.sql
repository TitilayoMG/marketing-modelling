
SELECT *
FROM {{ ref('stg_facebook_campaign') }}
WHERE campaign_id IS NULL
SELECT *
FROM {{ ref('stg_facebook_adgroup') }}
WHERE ad_group_id IS NULL
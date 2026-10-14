/*
    Tables
*/
WITH source_data AS (
    SELECT * FROM {{ source('snapchat', 'snapchat_ads') }}
),

/*
    Transformations
*/
formatted AS (
    SELECT DISTINCT
        -- FK
        CAST(ad_id AS STRING) AS ad_id,
        CAST(ad_group_id AS STRING) AS ad_group_id,

        -- Details
        CAST(ad_name AS STRING) AS ad_name,
        -- Metadata
        CAST(ad_detail_updated_at AS TIMESTAMP) AS ad_updated_at
    FROM
        source_data
)

SELECT * FROM formatted

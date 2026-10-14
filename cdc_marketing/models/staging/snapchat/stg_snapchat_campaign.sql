/*
    Tables
*/
WITH source_data AS (
    SELECT * FROM {{ source('snapchat', 'snapchat_campaign') }}
),

/*
    Transformations
*/
formatted AS (
    SELECT DISTINCT
        -- FK
        CAST(campaign_id AS STRING) AS campaign_id,
        -- Details
        CAST(campaign_name AS STRING) AS campaign_name,
        -- Metadata
        CAST(account_id AS STRING) AS account_id
    FROM
        source_data
)

SELECT * FROM formatted

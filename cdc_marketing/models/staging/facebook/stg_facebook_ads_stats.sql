{{
    config(
        event_time='ad_date',
    )
}}

/*
    Tables
*/

WITH source_data AS (

    SELECT * FROM {{ source('facebook', 'facebook_ads_stats') }}

),

/*
    Transformations
*/

formatted AS (

    SELECT DISTINCT
        -- PK
        {{ dbt_utils.generate_surrogate_key(['ad_id', 'ad_date']) }} AS ads_stats_key,

        -- FK
        CAST(ad_id AS STRING) AS ad_id,
        CAST(account_id AS STRING) AS account_id,

        -- Measures
        CAST(ad_spend AS DOUBLE) AS ad_spend,
        TRY_CAST(ad_impressions AS INTEGER) AS ad_impressions,
        TRY_CAST(ad_clicks AS INTEGER) AS ad_clicks,

        -- Metadata
        CAST(ad_date AS DATE) AS ad_date
    FROM
        source_data
)

SELECT * FROM formatted

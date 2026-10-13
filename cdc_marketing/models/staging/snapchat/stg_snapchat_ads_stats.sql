{{
    config(
        event_time='ad_date',
    )
}}

/*
    Tables
*/

WITH source_data AS (

    SELECT * FROM {{ source('snapchat', 'snapchat_ads_stats') }}

),

/*
    Transformations
    ad_currency_code and data_src are redundant (EUR and snapchat_ads)
*/

formatted AS (

    SELECT
        -- PK
        {{ dbt_utils.generate_surrogate_key(['ad_detail_id', 'ad_date', 'ad_country']) }} AS ads_stats_key,

        -- FK
        CAST(ad_detail_id AS STRING) AS ad_id,

        -- Measures
        CAST(ad_spend AS DOUBLE) AS ad_spend,
        TRY_CAST(ad_impressions AS INTEGER) AS ad_impressions,
        TRY_CAST(ad_clicks AS INTEGER) AS ad_clicks,
        CAST(ad_country AS STRING) AS ad_country,
        CAST(ad_currency_code AS STRING) AS ad_currency_code,

        -- Metadata
        CAST(ad_date AS DATE) AS ad_date,
        CAST(data_src AS STRING) AS data_src
    FROM
        source_data
)

SELECT * FROM formatted

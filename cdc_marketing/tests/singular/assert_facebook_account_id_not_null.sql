
SELECT *
FROM {{ ref('stg_facebook_account') }}
WHERE account_id IS NULL
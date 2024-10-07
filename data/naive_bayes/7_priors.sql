CREATE TABLE IF NOT EXISTS priors AS

WITH

transaction_outcome_counts AS (
    SELECT
        substitution_group_id,
        product_id_outcome,
        COUNT(*) AS count,
        SUM(COUNT(*)) OVER (PARTITION BY substitution_group_id) AS total
    FROM transaction_outcome
    GROUP BY
      substitution_group_id,
      product_id_outcome
)

SELECT
    substitution_group_id,
    product_id_outcome,
    count,
    total,
    CAST(count AS REAL) / CAST(total AS REAL) AS prior
FROM transaction_outcome_counts
ORDER BY substitution_group_id, product_id_outcome;


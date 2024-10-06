/*

# Calculation example

    For example:  We are interested in p(lemon was bought | lemon available & lime not available).
    We use the following formula:

    p(lemon was bought | lemon available & lime not available)
    =
    prior
    *
    p(lemon available | lemon bought) * p(lime not available | lemon bought)
    /
    sum(prior(lemon) * p(lime not available | lemon bought), prior(lime) * p(lime not available | lime bought))

    The denominator can be understood as the sum of all un-normalized posteriors of each outcome given the
    availability as seen at the time of the transaction.

*/

CREATE TABLE IF NOT EXISTS posteriors AS

WITH

groups AS (
    SELECT
        substitution_group_id,
        product_id as product_id_outcome
    FROM substitution_groups
),

unnormalized AS (
    SELECT
        substitution_group_id,
        transaction_id,
        product_id_outcome,
        -- Ensure the value is 0 if any likelihood is 0, otherwise compute the product of likelihoods and prior
        CASE
            WHEN MIN(likelihood) = 0 THEN 0
            ELSE EXP(SUM(LOG(likelihood))) * prior
        END AS unnorm_post
    FROM groups
    INNER JOIN likelihoods USING (substitution_group_id, product_id_outcome)
    INNER JOIN transaction_availability USING (substitution_group_id, product_id_available, is_available)
    INNER JOIN priors USING (substitution_group_id, product_id_outcome)
    GROUP BY
        substitution_group_id,
        transaction_id,
        product_id_outcome,
        prior
),

-- Step 3: Normalize the posterior probabilities to sum to 1 for each transaction
-- Here we divide the un-normalized posterior by the normalization constant,
-- which is the sum of all un-normalized posteriors (see the above example for more details)
normalized AS (
    SELECT
        substitution_group_id,
        transaction_id,
        product_id_outcome,
        -- For readability purposes, but in practice there is no need to do this.
        ROUND(unnorm_post / SUM(unnorm_post) OVER (PARTITION BY substitution_group_id, transaction_id), 3) AS posterior
    FROM unnormalized
),

-- Step 4: Compute unnormalized posterior probabilities where availability is always true
unnormalized_available_true AS (
  SELECT
    substitution_group_id,
    product_id_outcome,
    EXP(SUM(LOG(likelihood))) * prior AS unnorm_post
  FROM groups
    INNER JOIN likelihoods USING (substitution_group_id, product_id_outcome)
    INNER JOIN priors USING (substitution_group_id, product_id_outcome)
  WHERE
    is_available
  GROUP BY
    substitution_group_id,
    product_id_outcome,
    prior
),

normalized_available_true AS (
  SELECT
    substitution_group_id,
    product_id_outcome,
    ROUND(unnorm_post / SUM(unnorm_post) OVER (PARTITION BY substitution_group_id), 3) AS posterior_base
  FROM
    unnormalized_available_true
),

-- Final selection of normalized transaction-level posteriors with base probabilities
final AS (
    SELECT
        normalized.*,
        normalized_available_true.posterior_base,
        (normalized_available_true.posterior_base /
        CASE
            WHEN normalized_available_true.posterior_base > normalized.posterior THEN normalized_available_true.posterior_base
            ELSE normalized.posterior
        END) AS substitution_correction_ratio
    FROM normalized
    LEFT JOIN normalized_available_true USING (substitution_group_id, product_id_outcome)
    INNER JOIN transaction_outcome USING (substitution_group_id, transaction_id, product_id_outcome)
)

SELECT * FROM final;

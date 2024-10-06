/*
In this table we calculate the likelihood of a product being available given a specific transaction outcome.

This is defined as: P(item was available | outcome)
We do this for each possible scenario of outcome and availability.

Example on constructing the scenarios:

A transaction outcome can either be lemons or limes, which is our only substitution group.
For outcome lemon, we need to look at the availability of limes as well as lemons.
We cross-join the possible availability values, which are true and false, leaving us with:

outcome,    product,    available
lemon,      lemon,      true
lemon,      lemon,      false
lemon,      lime,       true
lemon,      lime,       false

Note that you do this for every possible transaction outcome.

The likelihood is then calculated for each of these scenarios, where we count how often we observed the
availability of a product (e.g., limes was available) given a specific transaction outcome (e.g., lemon was bought).
*/

CREATE TABLE IF NOT EXISTS likelihoods AS

WITH

-- The availability of an item can be either true or false
availability_values AS (
    SELECT TRUE AS is_available
    UNION ALL
    SELECT FALSE AS is_available
),

-- Create a set of all possible availability scenarios
availability_scenarios AS (
    SELECT DISTINCT
        outcome.substitution_group_id,
        outcome.product_id AS product_id_outcome,
        available.product_id as product_id_available,
        bool.is_available
    FROM substitution_groups AS outcome
    -- For each outcome, add an item for which we look at the availability
    INNER JOIN substitution_groups AS available USING (substitution_group_id)
    CROSS JOIN availability_values AS bool
    ORDER BY product_id_outcome, product_id_available
),

likelihoods AS (
    SELECT DISTINCT
        substitution_group_id,
        product_id_outcome,
        product_id_available,
        is_available,
        -- P(item was available | outcome)
        CAST(COUNT(*) AS REAL) / CAST(SUM(COUNT(*)) OVER (PARTITION BY substitution_group_id, product_id_outcome, product_id_available) AS REAL) AS likelihood
    FROM transaction_outcome
    LEFT JOIN transaction_availability
        USING (substitution_group_id, transaction_id)
    GROUP BY
        substitution_group_id,
        product_id_outcome,
        product_id_available,
        is_available
),

final AS (
    SELECT
        substitution_group_id,
        product_id_outcome,
        scenario.product_id_available,
        is_available,
        COALESCE(likelihoods.likelihood, 0) AS likelihood
    FROM availability_scenarios AS scenario
    LEFT JOIN likelihoods
        USING (substitution_group_id, product_id_outcome, product_id_available, is_available)
)

SELECT * FROM final;

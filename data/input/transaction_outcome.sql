-- The outcome of each transaction by identifying which product was purchased from the substitution group
CREATE TABLE IF NOT EXISTS transaction_outcome AS

SELECT
    substitution_group_id,
    transaction_id,
    product_id as product_id_outcome
FROM transactions
INNER JOIN substitution_groups USING (product_id)
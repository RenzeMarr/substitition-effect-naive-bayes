-- Creates a list of all possible combinations of transactions and items within the substitution groups.
-- It ensures that every transaction has an entry for each possible substitute product.
CREATE TABLE IF NOT EXISTS transactions_spine AS

WITH

groups AS (
    SELECT *
    FROM substitution_groups
)

SELECT
    substitution_group_id,
    transaction_id,
    groups.product_id as product_id,
    sales_date_time
FROM groups
CROSS JOIN transactions
ORDER BY transaction_id;

--In this table we check the availability of both lemons and limes items at the time of each transaction.
CREATE TABLE IF NOT EXISTS transaction_availability AS

SELECT
    transaction_id,
    substitution_group_id,
    transactions_spine.product_id as product_id_available,
    CASE
        WHEN product_stock_outs.product_id IS NULL THEN TRUE
        ELSE FALSE
    END AS is_available
FROM transactions_spine
LEFT JOIN product_stock_outs ON
    transactions_spine.product_id = product_stock_outs.product_id
    AND transactions_spine.sales_date_time >= product_stock_outs.start_date_time
    AND transactions_spine.sales_date_time <= product_stock_outs.end_date_time
ORDER BY transaction_id;




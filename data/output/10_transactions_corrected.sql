CREATE TABLE IF NOT EXISTS transactions_corrected AS

SELECT
    transaction_id,
    product_id,
    product_name,
    sales_date_time,
    posteriors.substitution_correction_ratio * quantity_sold AS quantity,
    -- For comparison purposes we keep the original quantity and adjusted quantity
    quantity_sold AS quantity_without_sosc, -- soc = Out Of Stock Substitution Correction
    posteriors.substitution_correction_ratio
FROM transactions
LEFT JOIN posteriors USING (transaction_id)

CREATE TABLE IF NOT EXISTS product_stock_outs (
    start_date_time TIMESTAMP,
    end_date_time TIMESTAMP,
    product_id INT
);

-- Insert the stock out times
INSERT INTO product_stock_outs (start_date_time, end_date_time, product_id)
VALUES
    ('2024-10-04 10:15:00', '2024-10-06 08:55:00', 11);
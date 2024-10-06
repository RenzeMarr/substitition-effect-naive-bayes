-- Create the base table containing transactions
CREATE TABLE IF NOT EXISTS transactions (
    transaction_id INT,
    sales_date_time TIMESTAMP,
    product_name VARCHAR(20),
    product_id INT,
    quantity_sold INT
);

INSERT INTO transactions (transaction_id, sales_date_time, product_name, product_id, quantity_sold)
VALUES
    -- Day 1 (transactions: 5, lemons sold: 5, limes sold: 5)
    (1, '2024-10-01 13:15:00', 'lime', 11, 2),
    (2, '2024-10-01 13:20:00', 'lemon', 12, 1),
    (3, '2024-10-01 14:50:00', 'lime', 11, 3),
    (4, '2024-10-01 14:55:00', 'lemon', 12, 1),
    (5, '2024-10-01 15:00:00', 'lemon', 12, 3),

    -- Day 2 (transactions: 6, lemons sold: 7, limes sold: 7)
    (6, '2024-10-02 09:30:00', 'lime', 11, 2),
    (7, '2024-10-02 09:45:00', 'lemon', 12, 4),
    (8, '2024-10-02 10:10:00', 'lime', 11, 3),
    (9, '2024-10-02 10:20:00', 'lemon', 12, 2),
    (10, '2024-10-02 11:00:00', 'lime', 11, 2),
    (11, '2024-10-02 12:30:00', 'lemon', 12, 1),

    -- Day 3 (transactions: 4, lemons sold: 5, limes sold: 5)
    (12, '2024-10-03 09:00:00', 'lime', 11, 1),
    (13, '2024-10-03 09:10:00', 'lemon', 12, 3),
    (14, '2024-10-03 11:25:00', 'lime', 11, 4),
    (15, '2024-10-03 12:50:00', 'lemon', 12, 2),

    -- Day 4 (transactions: 7, lemons sold: 14, limes sold: 8)
    (16, '2024-10-04 09:15:00', 'lemon', 12, 3),
    (17, '2024-10-04 09:20:00', 'lime', 11, 4),
    (18, '2024-10-04 10:10:00', 'lime', 11, 4),
    (19, '2024-10-04 13:00:00', 'lemon', 12, 3),
    (20, '2024-10-04 14:10:00', 'lemon', 12, 4),
    (21, '2024-10-04 14:30:00', 'lemon', 12, 2),
    (22, '2024-10-04 14:55:00', 'lemon', 12, 2),

    -- Day 5 (5 transactions, lemons sold: 7, limes sold: 0)
    (23, '2024-10-05 10:00:00', 'lemon', 12, 2),
    (24, '2024-10-05 10:15:00', 'lemon', 12, 1),
    (25, '2024-10-05 13:30:00', 'lemon', 12, 1),
    (26, '2024-10-05 14:50:00', 'lemon', 12, 3),

    -- Day 6 (6 transactions, lemons sold: 7, limes sold: 7)
    (27, '2024-10-06 09:00:00', 'lime', 11, 2),
    (28, '2024-10-06 09:45:00', 'lemon', 12, 4),
    (29, '2024-10-06 10:30:00', 'lime', 11, 1),
    (30, '2024-10-06 12:00:00', 'lime', 11, 2),
    (31, '2024-10-06 13:50:00', 'lemon', 12, 2),
    (32, '2024-10-06 14:20:00', 'lemon', 12, 1),

    -- Day 7 (5 transactions, lemons sold: 6, limes sold: 6)
    (33, '2024-10-07 09:10:00', 'lime', 11, 3),
    (34, '2024-10-07 09:15:00', 'lemon', 12, 1),
    (35, '2024-10-07 10:00:00', 'lime', 11, 3),
    (36, '2024-10-07 11:45:00', 'lemon', 12, 3),
    (37, '2024-10-07 13:30:00', 'lemon', 12, 2);


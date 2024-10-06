CREATE TABLE IF NOT EXISTS substitution_groups (
    substitution_group_id INT,
    product_name VARCHAR(20),
    product_id INT
);

-- Lemon and lime are in the same substitution group
INSERT INTO substitution_groups (substitution_group_id, product_name, product_id)
VALUES
    (1, 'lemon', 12),
    (1, 'lime', 11);
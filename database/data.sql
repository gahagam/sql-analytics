START TRANSACTION;

INSERT INTO customers (gender, age) VALUES
('Male', 25), ('Female', 32), ('Male', 45), ('Female', 19), ('Male', 38), 
('Female', 28), ('Male', 51), ('Female', 23), ('Male', 42), ('Female', 30);

INSERT INTO products (category, price) VALUES
('Clothing', 5000.00), ('Food', 899.99), ('Electronics', 19999.99), 
('Accessories', 2500.50), ('Cosmetics', 955.00), ('Books', 1499.99);

INSERT INTO malls (shopping_mall) VALUES
('Viva Land'), ('Park House'), ('Mega'), ('Aurora'), ('Cosmoport');

INSERT INTO payment_methods (payment_method) VALUES
('Credit Card'), ('Debit Card'), ('Cash'), ('Mobile Payment'), ('Gift Card');

DELIMITER $$

DROP PROCEDURE IF EXISTS generate_transactions$$

CREATE PROCEDURE generate_transactions()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE v_customer_id INT;
    DECLARE v_product_id INT;
    DECLARE v_mall_id INT;
    DECLARE v_payment_id INT;
    DECLARE v_quantity INT;
    DECLARE v_date DATE;
    DECLARE v_year INT;
    DECLARE v_month INT;
    DECLARE v_day INT;
    
    WHILE i <= 500 DO
        SET v_customer_id = 1 + FLOOR(RAND() * 10);
        SET v_product_id = 1 + FLOOR(RAND() * 6);
        SET v_mall_id = 1 + FLOOR(RAND() * 5);
        SET v_payment_id = 1 + FLOOR(RAND() * 5);
        SET v_quantity = 1 + FLOOR(RAND() * 5);
        SET v_year = 2024 + FLOOR(RAND() * 3);
        SET v_month = 1 + FLOOR(RAND() * 12);
        
        -- Корректируем дни в месяцах
        IF v_month = 2 THEN
            SET v_day = 1 + FLOOR(RAND() * 28);
        ELSEIF v_month IN (4, 6, 9, 11) THEN
            SET v_day = 1 + FLOOR(RAND() * 30);
        ELSE
            SET v_day = 1 + FLOOR(RAND() * 31);
        END IF;
        
        IF v_year = 2026 AND v_month > 3 THEN
            SET v_month = 3;
            SET v_day = 1 + FLOOR(RAND() * 28);
        END IF;
        
        SET v_date = DATE(CONCAT(v_year, '-', v_month, '-', v_day));
        
        INSERT INTO transactions (customer_id, product_id, mall_id, payment_id, quantity, transaction_date)
        VALUES (v_customer_id, v_product_id, v_mall_id, v_payment_id, v_quantity, v_date);
        
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

CALL generate_transactions();
DROP PROCEDURE generate_transactions;

COMMIT;
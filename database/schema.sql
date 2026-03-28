 -- клиенты
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    gender VARCHAR(10) NOT NULL,
    age INT NOT NULL,
    CHECK (age >= 0 AND age <= 120)
);
 
 -- товары
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- ТЦ
CREATE TABLE malls (
    mall_id INT PRIMARY KEY AUTO_INCREMENT,
    shopping_mall VARCHAR(100) UNIQUE NOT NULL
);

-- метод оплаты
CREATE TABLE payment_methods (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    payment_method VARCHAR(50) UNIQUE NOT NULL
);

-- транзакции
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    mall_id INT NOT NULL,
    payment_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    transaction_date DATE NOT NULL,
    
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (mall_id) REFERENCES malls(mall_id),
    FOREIGN KEY (payment_id) REFERENCES payment_methods(payment_id)
);
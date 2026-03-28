-- кто потратил больше всего?
SELECT 
    ROW_NUMBER() OVER (ORDER BY SUM(t.quantity * p.price) DESC) AS место,
    c.customer_id,
    c.gender AS пол,
    c.age AS возраст,
    COUNT(t.transaction_id) AS количество_покупок,
    ROUND(SUM(t.quantity * p.price), 2) AS сумма_покупок
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
JOIN products p ON t.product_id = p.product_id
GROUP BY c.customer_id, c.gender, c.age;

-- какой товар больше продается?
SELECT 
    ROW_NUMBER() OVER (ORDER BY SUM(t.quantity) DESC) AS место,
    p.category AS категория,
    SUM(t.quantity) AS количество_проданных_штук,
    COUNT(t.transaction_id) AS количество_чеков,
    ROUND(SUM(t.quantity * p.price), 2) AS выручка
FROM transactions t
JOIN products p ON t.product_id = p.product_id
GROUP BY p.category;

-- какой самый прибыльный ТЦ?
SELECT 
    m.shopping_mall AS торговый_центр,
    COUNT(t.transaction_id) AS количество_покупок,
    SUM(t.quantity) AS продано_товаров,
    ROUND(SUM(t.quantity * p.price), 2) AS выручка
FROM transactions t
JOIN malls m ON t.mall_id = m.mall_id
JOIN products p ON t.product_id = p.product_id
GROUP BY m.shopping_mall
ORDER BY выручка DESC;

-- какой способ оплаты популярнее?
SELECT 
    pm.payment_method AS способ_оплаты,
    COUNT(t.transaction_id) AS количество_транзакций,
    ROUND(SUM(t.quantity * p.price), 2) AS общая_сумма,
    ROUND(AVG(t.quantity * p.price), 2) AS средний_чек
FROM transactions t
JOIN payment_methods pm ON t.payment_id = pm.payment_id
JOIN products p ON t.product_id = p.product_id
GROUP BY pm.payment_method
ORDER BY количество_транзакций DESC;

-- возрастная группа
SELECT 
    CASE 
        WHEN c.age < 25 THEN '18-24'
        WHEN c.age BETWEEN 25 AND 34 THEN '25-34'
        WHEN c.age BETWEEN 35 AND 44 THEN '35-44'
        WHEN c.age >= 45 THEN '45+'
    END AS возрастная_группа,
    c.gender AS пол,
    COUNT(t.transaction_id) AS количество_покупок,
    ROUND(SUM(t.quantity * p.price), 2) AS сумма_покупок
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
JOIN products p ON t.product_id = p.product_id
GROUP BY возрастная_группа, c.gender
ORDER BY сумма_покупок DESC;

-- анализ активности клиентов 
SELECT 
    c.customer_id,
    c.gender AS пол,
    c.age AS возраст,
    COUNT(t.transaction_id) AS количество_покупок,
    ROUND(SUM(t.quantity * p.price), 2) AS сумма_покупок,
    CASE 
        WHEN COUNT(t.transaction_id) = 0 THEN 'Нет покупок'
        WHEN COUNT(t.transaction_id) <= 5 THEN 'Мало покупок'
        WHEN COUNT(t.transaction_id) <= 15 THEN 'Средняя активность'
        ELSE 'Высокая активность'
    END AS уровень_активности
FROM customers c
LEFT JOIN transactions t ON c.customer_id = t.customer_id
LEFT JOIN products p ON t.product_id = p.product_id
GROUP BY c.customer_id, c.gender, c.age
ORDER BY количество_покупок DESC;


-- (проверка для себя)
SELECT 
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT customer_id) AS unique_customers,
    MIN(transaction_date) AS first_transaction,
    MAX(transaction_date) AS last_transaction,
    SUM(quantity) AS total_items_sold
FROM transactions;
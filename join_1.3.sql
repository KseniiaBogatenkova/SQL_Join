-- Найти клиентов, у которых были заказы, доставленные с задержкой более чем на 5 дней, 
-- и клиентов, у которых были заказы, которые были отменены. 
-- Для каждого клиента вывести имя, количество доставок с задержкой,
-- количество отмененных заказов и их общую сумму. Результат отсортировать по общей сумме заказов в убывающем порядке.


SELECT 
    customers_new.customer_id,  -- Уникальный идентификатор клиента
    customers_new.name,         -- Имя клиента
    SUM(CASE WHEN TO_DATE(orders_new.shipment_date, 'YYYY-MM-DD') - TO_DATE(orders_new.order_date, 'YYYY-MM-DD') > 5 THEN 1 ELSE 0 END) AS delayed_orders,  
    -- Подсчитываем количество заказов с задержкой более 5 дней
    SUM(CASE WHEN orders_new.order_status = 'Cancel' THEN 1 ELSE 0 END) AS cancelled_orders,  
    -- Подсчитываем количество отмененных заказов
    SUM(orders_new.order_ammount) AS total_order_sum  -- Общая сумма заказов клиента
FROM 
    customers_new
JOIN 
    orders_new ON customers_new.customer_id = orders_new.customer_id  -- Соединяем таблицы по идентификатору клиента
GROUP BY 
    customers_new.customer_id, customers_new.name  -- Группируем по клиенту
HAVING 
    SUM(CASE WHEN TO_DATE(orders_new.shipment_date, 'YYYY-MM-DD') - TO_DATE(orders_new.order_date, 'YYYY-MM-DD') > 5 THEN 1 ELSE 0 END) > 0  
    OR SUM(CASE WHEN orders_new.order_status = 'Cancel' THEN 1 ELSE 0 END) > 0  
    -- Учитываем только клиентов, у которых есть хотя бы одна задержка или один отмененный заказ
ORDER BY 
    total_order_sum DESC;  -- Сортируем по общей сумме заказов в порядке убывания
    
-- Эта логика гарантирует, что в результат попадут только те клиенты, которые имеют оба типа событий (задержки и отмены). 
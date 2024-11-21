-- Найти клиентов, сделавших наибольшее количество заказов,
-- и для каждого из них найти среднее время между заказом и доставкой, 
-- а также общую сумму всех их заказов. Вывести клиентов в порядке убывания общей суммы заказов.

SELECT 
    customers_new.customer_id,  -- Уникальный идентификатор клиента
    customers_new.name,         -- Имя клиента
    COUNT(orders_new.order_id) AS total_orders,  -- Общее количество заказов клиента
    AVG(TO_DATE(orders_new.shipment_date, 'YYYY-MM-DD') - TO_DATE(orders_new.order_date, 'YYYY-MM-DD')) AS avg_waiting_time,  
    -- Среднее время между заказом и доставкой
    SUM(orders_new.order_ammount) AS total_order_sum  -- Общая сумма всех заказов клиента
FROM 
    customers_new
JOIN 
    orders_new ON customers_new.customer_id = orders_new.customer_id  -- Соединяем таблицы по идентификатору клиента
WHERE 
    orders_new.order_status = 'Approved'  -- Учитываем только заказы со статусом "Approved"
GROUP BY 
    customers_new.customer_id, customers_new.name  -- Группируем по клиенту
ORDER BY 
    total_order_sum DESC;  -- Сортируем по общей сумме заказов в порядке убывания

-- Найти клиента с самым долгим временем ожидания между заказом и доставкой. 


SELECT 
    customers_new.customer_id,  -- Уникальный идентификатор клиента
    customers_new.name,         -- Имя клиента
    MAX(TO_DATE(orders_new.shipment_date, 'YYYY-MM-DD') - TO_DATE(orders_new.order_date, 'YYYY-MM-DD')) AS max_waiting_time  
    -- Преобразуем строки в даты и вычисляем максимальное время ожидания
FROM 
    customers_new
JOIN 
    orders_new ON customers_new.customer_id = orders_new.customer_id  -- Соединяем таблицы по идентификатору клиента
WHERE 
    orders_new.order_status = 'Approved'  -- Учитываем только заказы со статусом "Approved"
GROUP BY 
    customers_new.customer_id, customers_new.name  -- Группируем по клиенту
ORDER BY 
    max_waiting_time DESC  -- Сортируем по убыванию времени ожидания
LIMIT 1;  -- Оставляем только клиента с максимальным временем ожидания

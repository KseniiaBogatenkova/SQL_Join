-- Вычислить общую сумму продаж для каждой категории продуктов.

SELECT 
    products3.product_category,  -- Категория продукта
    SUM(orders2.order_ammount) AS total_sales  -- Общая сумма продаж
FROM 
    orders2
JOIN 
    products3 ON orders2.product_id = products3.product_id  -- Соединяем таблицы по product_id
GROUP BY 
    products3.product_category  -- Группируем по категории продуктов
ORDER BY 
    total_sales DESC;  -- Сортируем по общей сумме продаж

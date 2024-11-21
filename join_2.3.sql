-- Для каждой категории продуктов, определить продукт с максимальной суммой продаж в этой категории.


WITH product_sales AS (
    SELECT 
        products3.product_category,  -- Категория продукта
        products3.product_name,      -- Наименование продукта
        SUM(orders2.order_ammount) AS total_product_sales  -- Общая сумма продаж продукта
    FROM 
        orders2
    JOIN 
        products3 ON orders2.product_id = products3.product_id  -- Соединяем таблицы по product_id
    GROUP BY 
        products3.product_category, products3.product_name  -- Группируем по категории и продукту
),
max_sales_per_category AS (
    SELECT 
        product_category,  -- Категория продукта
        MAX(total_product_sales) AS max_sales  -- Максимальная сумма продаж продукта в категории
    FROM 
        product_sales
    GROUP BY 
        product_category  -- Группируем по категории
)
SELECT 
    product_sales.product_category,  -- Категория продукта
    product_sales.product_name,      -- Наименование продукта
    product_sales.total_product_sales  -- Общая сумма продаж продукта
FROM 
    product_sales
JOIN 
    max_sales_per_category 
    ON product_sales.product_category = max_sales_per_category.product_category 
    AND product_sales.total_product_sales = max_sales_per_category.max_sales  -- Сопоставляем продукты с максимальной суммой продаж
ORDER BY 
    product_sales.product_category;  -- Сортируем по категории

WITH customer_age_sales AS (
    SELECT
        c.customer_id,
        CONCAT(c.last_name, ' ', c.first_name, ' ', c.second_name) AS full_name,
        -- Вычисляем возраст клиентов
  		
        EXTRACT(YEAR FROM (AGE(NOW(), CAST (c.date_of_birth AS DATE)))) AS age,
        c.gender,
        SUM(o.price * o.count) AS total_sales
    FROM
        pharma_orders o
    JOIN
        customers c ON o.customer_id = c.customer_id
    GROUP BY
        c.customer_id, full_name, age, c.gender
),
categorized_customers AS (
    SELECT
        *,
        -- Классифицируем клиентов по возрасту и полу
        CASE
            WHEN c.gender = 'муж' AND c.age < '30' THEN 'Мужчины младше 30'
            WHEN c.gender = 'муж' AND c.age BETWEEN 30 AND 45 THEN 'Мужчины от 30 до 45'
            WHEN c.gender = 'муж' AND c.age > 45 THEN 'Мужчины старше 45'
            WHEN c.gender = 'жен' AND c.age < 30 THEN 'Женщины младше 30'
            WHEN c.gender = 'жен' AND c.age BETWEEN 30 AND 45 THEN 'Женщины от 30 до 45'
            WHEN c.gender = 'жен' AND c.age > 45 THEN 'Женщины старше 45'
            ELSE 'Неопределено'
        END AS customer_category
    FROM
       		customer_age_sales c
),
total_sales AS (
    -- Считаем общие продажи по всем клиентам
    SELECT
        SUM(total_sales) AS overall_sales
    FROM
        customer_age_sales
 	
)
-- Подсчет доли продаж по каждой категории
SELECT
    customer_category,
    SUM(total_sales) AS category_sales,
    ROUND((SUM(total_sales) / overall_sales) * 100, 2) AS sales_percentage
FROM
    categorized_customers, total_sales
GROUP BY
    customer_category, overall_sales
ORDER BY
    sales_percentage DESC;
WITH gorzdrav_customers AS (
    SELECT
        o.customer_id,
        CONCAT(c.last_name, ' ', c.first_name, ' ', c.second_name) AS full_name,
        COUNT(o.order_id) AS order_count
    FROM
        pharma_orders o
    JOIN
        customers c ON o.customer_id = c.customer_id
    WHERE
        o.pharmacy_name = 'Горздрав'
    GROUP BY
        o.customer_id, full_name
    ORDER BY
        order_count DESC
    LIMIT 10
),
zdravsiti_customers AS (
    SELECT
        o.customer_id,
        CONCAT(c.last_name, ' ', c.first_name, ' ', c.second_name) AS full_name,
        COUNT(o.order_id) AS order_count
    FROM
        pharma_orders o
    JOIN
        customers c ON o.customer_id = c.customer_id
    WHERE
        o.pharmacy_name = 'Здравсити'
    GROUP BY
        o.customer_id, full_name
    ORDER BY
        order_count DESC
    LIMIT 10
)
-- Объединение данных двух аптек
SELECT * FROM gorzdrav_customers
UNION
SELECT * FROM zdravsiti_customers
ORDER BY 
 order_count DESC;
WITH customer_totals AS (
    SELECT 
        co.customer_id,
        co.first_name,
        co.last_name,
        SUM(po.price * po.count) AS total_orders
    FROM 
        pharma_orders po
    JOIN 
        customers co ON po.customer_id = co.customer_id
    GROUP BY 
        co.customer_id, co.first_name, co.last_name
)

SELECT 
    customer_id,
    first_name,
    last_name,
    total_orders,
    ROW_NUMBER() OVER (ORDER BY total_orders DESC) AS rank
FROM 
    customer_totals
ORDER BY 
    total_orders DESC
LIMIT 10;
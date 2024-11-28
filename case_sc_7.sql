WITH customer_orders AS (
    SELECT
        o.customer_id,
        CONCAT(c.last_name, ' ', c.first_name, ' ', c.second_name) AS full_name,
        SUM(o.price * o.count) AS total_sum
    FROM
        pharma_orders o
    JOIN
        customers c ON o.customer_id = c.customer_id
    GROUP BY
        o.customer_id, full_name
)
SELECT
    customer_id,
    full_name,
    total_sum
FROM
    customer_orders;
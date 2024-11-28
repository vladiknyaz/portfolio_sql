-- SELECT * FROM customers
-- SELECT * FROM pharma_orders
SELECT
	pharmacy_name,
    SUM (price * count) AS sales_volume
FROM
pharma_orders
GROUP BY
pharmacy_name
ORDER BY
sales_volume DESC
LIMIT 3

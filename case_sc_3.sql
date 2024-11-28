SELECT
	pharmacy_name,
    SUM (price * count) AS sales_volume
FROM
pharma_orders
GROUP BY
pharmacy_name
HAVING SUM (price * count) > 1800000
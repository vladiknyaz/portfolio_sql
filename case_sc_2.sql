SELECT
	drug,
    SUM (price * count) AS sales_volume_drug
FROM
pharma_orders
GROUP BY
drug
LIMIT 3
WITH total_sales AS (
    SELECT
        LOWER(drug) AS drug_name,
        SUM(price * count) AS total_sales
    FROM
        pharma_orders
    WHERE
        LOWER(drug) LIKE 'аква%' -- выбираем лекарства, начинающиеся на 'аква'
    GROUP BY
        LOWER(drug)
),
total_sales_sum AS (
    SELECT
        SUM(total_sales) AS grand_total
    FROM
        total_sales
)
SELECT
    ts.drug_name,
    ts.total_sales,
    ROUND((ts.total_sales / tss.grand_total) * 100, 2) AS sales_share -- подсчет доли в процентах
FROM
    total_sales ts,
    total_sales_sum tss
ORDER BY
    ts.total_sales DESC;
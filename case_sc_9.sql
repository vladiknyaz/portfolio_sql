WITH sales_moscow AS (
    -- Подсчет месячных продаж для Москвы
    SELECT
        EXTRACT(MONTH FROM (CAST (report_date AS DATE))) AS month,
  		--DATE_TRUNC('month', report_date)::DATE AS month, -- Приведение к формату даты только для года и месяца
        SUM(price * count) AS total_sales_moscow
    FROM
        pharma_orders
    WHERE
        LOWER(city) = 'москва'
    GROUP BY
        EXTRACT(MONTH FROM (CAST (report_date AS DATE)))
  		--DATE_TRUNC('month', report_date)::DATE
),
sales_spb AS (
    -- Подсчет месячных продаж для Санкт-Петербурга
    SELECT
  		EXTRACT(MONTH FROM (CAST (report_date AS DATE))) AS month,     
  -- DATE_TRUNC('month', report_date)::DATE AS month, -- Приведение к формату даты только для года и месяца
        SUM(price * count) AS total_sales_spb
    FROM
        pharma_orders
    WHERE
        LOWER(city) = 'санкт-петербург'
    GROUP BY
  		EXTRACT(MONTH FROM (CAST (report_date AS DATE)))
        --DATE_TRUNC('month', report_date)::DATE
)
-- Соединяем данные по месяцам и вычисляем разницу в процентах
SELECT
    COALESCE(m.month, s.month) AS month, -- Для случаев, если в одном из городов нет продаж в месяце
    COALESCE(m.total_sales_moscow, 0) AS total_sales_moscow,
    COALESCE(s.total_sales_spb, 0) AS total_sales_spb,
    CASE
        WHEN COALESCE(s.total_sales_spb, 0) = 0 THEN NULL -- Предотвращаем деление на ноль
        ELSE ROUND((100*(COALESCE(m.total_sales_moscow, 0) - COALESCE(s.total_sales_spb, 0)) / COALESCE(m.total_sales_moscow, 1)), 1)
    END AS sales_difference_percent
FROM
    sales_moscow m
FULL OUTER JOIN
    sales_spb s
ON
    m.month = s.month
ORDER BY
    month;
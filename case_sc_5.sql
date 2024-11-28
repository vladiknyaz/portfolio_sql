SELECT 
    po.pharmacy_name,
    COUNT(DISTINCT co.customer_id) AS unique_customer_count
FROM 
    pharma_orders po
JOIN 
    customers co ON po.customer_id = co.customer_id
GROUP BY 
    po.pharmacy_name
ORDER BY 
    unique_customer_count DESC;
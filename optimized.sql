WITH RecentOrders AS (
    SELECT 
        o.client_id,
        o.product_id,
        o.order_id
    FROM 
        opt_orders o
    WHERE 
        o.order_date >= CURDATE() - INTERVAL 30 DAY
)
SELECT 
    c.name AS client_name,
    c.surname AS client_surname,
    c.email AS client_email,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(o.product_id) AS total_products_ordered,
    GROUP_CONCAT(DISTINCT p.product_name ORDER BY p.product_name SEPARATOR ', ') AS ordered_products
FROM 
    opt_clients c
JOIN 
    RecentOrders o ON c.id = o.client_id
JOIN 
    opt_products p ON o.product_id = p.product_id
WHERE 
    c.status = 'active'
GROUP BY 
    c.id
ORDER BY 
    total_orders DESC;

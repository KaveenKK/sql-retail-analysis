SELECT
    c.region,
    COUNT(DISTINCT c.customer_id)            AS customers,
    COUNT(DISTINCT o.order_id)               AS orders,
    ROUND(SUM(oi.sales), 2)                  AS revenue,
    ROUND(SUM(oi.profit), 2)                 AS profit,
    ROUND(SUM(oi.sales) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value,
    CASE
        WHEN SUM(oi.profit)*100.0/SUM(oi.sales) >= 25 THEN 'High'
        WHEN SUM(oi.profit)*100.0/SUM(oi.sales) >= 15 THEN 'Medium'
        ELSE 'Low'
    END AS margin_band
FROM customers c
JOIN orders      o  ON c.customer_id  = o.customer_id
JOIN order_items oi ON o.order_id     = oi.order_id
GROUP BY c.region
ORDER BY revenue DESC

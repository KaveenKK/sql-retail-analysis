SELECT
    p.category,
    COUNT(DISTINCT o.order_id)              AS orders,
    ROUND(SUM(oi.sales), 2)                 AS revenue,
    ROUND(SUM(oi.profit), 2)                AS profit,
    ROUND(AVG(oi.discount) * 100, 1)        AS avg_discount_pct,
    ROUND(SUM(oi.profit)*100.0/SUM(oi.sales),1) AS margin_pct
FROM order_items oi
JOIN orders   o ON oi.order_id  = o.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC

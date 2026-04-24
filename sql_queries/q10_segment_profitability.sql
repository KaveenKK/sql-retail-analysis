SELECT
    c.segment,
    p.category,
    COUNT(DISTINCT o.order_id)                              AS orders,
    ROUND(SUM(oi.sales), 2)                                 AS revenue,
    ROUND(SUM(oi.profit), 2)                                AS profit,
    ROUND(AVG(oi.discount) * 100, 1)                        AS avg_discount_pct,
    ROUND(SUM(oi.profit) * 100.0 / SUM(oi.sales), 1)       AS margin_pct,
    ROUND(SUM(oi.sales) / COUNT(DISTINCT o.order_id), 2)    AS avg_order_value
FROM customers    c
JOIN orders       o  ON c.customer_id = o.customer_id
JOIN order_items  oi ON o.order_id    = oi.order_id
JOIN products     p  ON oi.product_id = p.product_id
GROUP BY c.segment, p.category
HAVING orders > 10
ORDER BY profit DESC

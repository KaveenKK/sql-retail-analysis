SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name  AS customer_name,
    c.region,
    c.segment,
    COUNT(DISTINCT o.order_id)           AS total_orders,
    ROUND(SUM(oi.sales), 2)              AS lifetime_value,
    ROUND(SUM(oi.profit), 2)             AS total_profit
FROM customers c
JOIN orders      o  ON c.customer_id  = o.customer_id
JOIN order_items oi ON o.order_id     = oi.order_id
GROUP BY c.customer_id
ORDER BY lifetime_value DESC
LIMIT 10

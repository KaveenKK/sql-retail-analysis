SELECT
    strftime('%Y', o.order_date)   AS year,
    COUNT(DISTINCT o.order_id)     AS total_orders,
    ROUND(SUM(oi.sales), 2)        AS total_revenue,
    ROUND(SUM(oi.profit), 2)       AS total_profit,
    ROUND(SUM(oi.profit) * 100.0
          / SUM(oi.sales), 1)      AS profit_margin_pct
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY year
ORDER BY year

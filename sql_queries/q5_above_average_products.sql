SELECT
    p.product_name,
    p.category,
    p.sub_category,
    ROUND(SUM(oi.sales), 2)   AS total_sales,
    SUM(oi.quantity)          AS units_sold,
    ROUND(SUM(oi.profit), 2)  AS total_profit
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id
HAVING total_sales > (
    SELECT AVG(product_sales)
    FROM (
        SELECT SUM(sales) AS product_sales
        FROM order_items
        GROUP BY product_id
    )
)
ORDER BY total_sales DESC

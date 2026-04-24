SELECT
    p.category,
    p.product_name,
    ROUND(SUM(oi.sales), 2)  AS total_sales,
    SUM(oi.quantity)         AS units_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id
HAVING total_sales = (
    SELECT MAX(sub_sales)
    FROM (
        SELECT SUM(oi2.sales) AS sub_sales
        FROM products p2
        JOIN order_items oi2 ON p2.product_id = oi2.product_id
        WHERE p2.category = p.category
        GROUP BY p2.product_id
    )
)
ORDER BY total_sales DESC

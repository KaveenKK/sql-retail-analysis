WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name  AS customer_name,
        c.region,
        ROUND(SUM(oi.sales), 2)              AS revenue
    FROM customers c
    JOIN orders      o  ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id    = oi.order_id
    GROUP BY c.customer_id
)
SELECT
    region,
    customer_name,
    revenue,
    RANK() OVER (PARTITION BY region ORDER BY revenue DESC) AS rank_in_region
FROM customer_revenue
ORDER BY region, rank_in_region

WITH monthly AS (
    SELECT
        strftime('%Y-%m', o.order_date)  AS month,
        ROUND(SUM(oi.sales), 2)          AS monthly_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY month
)
SELECT
    month,
    monthly_revenue,
    ROUND(
        SUM(monthly_revenue) OVER (ORDER BY month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
        2
    ) AS running_total
FROM monthly
ORDER BY month

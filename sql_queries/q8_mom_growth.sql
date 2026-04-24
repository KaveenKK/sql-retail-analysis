WITH monthly_rev AS (
    SELECT
        strftime('%Y-%m', o.order_date)  AS month,
        ROUND(SUM(oi.sales), 2)          AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY month
),
with_lag AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue
    FROM monthly_rev
)
SELECT
    month,
    revenue,
    prev_month_revenue,
    ROUND(
        (revenue - prev_month_revenue) * 100.0 / prev_month_revenue,
        1
    ) AS mom_growth_pct
FROM with_lag
WHERE prev_month_revenue IS NOT NULL
ORDER BY month

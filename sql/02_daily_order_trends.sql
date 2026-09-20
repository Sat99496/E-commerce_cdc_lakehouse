WITH daily_comparison AS (
    SELECT
        order_date,
        total_orders,
        total_revenue,
        LAG(order_date) OVER (
            ORDER BY order_date
        ) AS previous_date,
        LAG(total_revenue) OVER (
            ORDER BY order_date
        ) AS previous_revenue
    FROM fintech_lakehouse.gold.daily_order_kpis
)
SELECT
    order_date,
    total_orders,
    ROUND(total_revenue, 2) AS total_revenue,
    previous_date,
    ROUND(previous_revenue, 2) AS previous_revenue,
    CASE
        WHEN DATEDIFF(order_date, previous_date) = 1
        THEN ROUND(total_revenue - previous_revenue, 2)
    END AS daily_change,
    CASE
        WHEN DATEDIFF(order_date, previous_date) = 1
             AND previous_revenue <> 0
        THEN ROUND(
            100.0 * (total_revenue - previous_revenue)
            / previous_revenue,
            2
        )
    END AS daily_change_percent
FROM daily_comparison
ORDER BY order_date;

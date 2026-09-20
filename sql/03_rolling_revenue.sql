
SELECT
    order_date,
    total_revenue,
    ROUND(
        SUM(total_revenue) OVER (
            ORDER BY order_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ), 2
    ) AS rolling_7_row_revenue
FROM fintech_lakehouse.gold.daily_order_kpis
ORDER BY order_date;

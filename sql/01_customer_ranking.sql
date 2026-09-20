WITH ranked_customers AS (
    SELECT
        customer_id,
        total_orders,
        customer_lifetime_value AS total_order_value,
        average_order_value,
        DENSE_RANK() OVER (
            ORDER BY customer_lifetime_value DESC
        ) AS customer_rank
    FROM fintech_lakehouse.gold.customer_kpis
)
SELECT *
FROM ranked_customers
WHERE customer_rank <= 10
ORDER BY customer_rank, customer_id;

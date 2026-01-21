WITH monthly_metrics AS (SELECT
	DATE_TRUNC('month', ca.orderdate)::date AS year_month,
	SUM (total_net_revenue) AS total_revenue,
	COUNT (DISTINCT ca.customerkey) AS total_customers,
	SUM (total_net_revenue) / COUNT(ca.customerkey) AS customer_revenue
FROM cohort_analysis ca
GROUP BY year_month 
ORDER BY year_month 
)
SELECT 
	year_month,
	total_revenue,
	AVG (total_revenue) OVER(
	ORDER BY year_month 
	ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) AS rolling_3mo_total_revenue,

	AVG (total_customers) OVER(
	ORDER BY year_month 
	ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) AS rolling_3mo_total_customers,

	AVG (customer_revenue) OVER(
	ORDER BY year_month 
	ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) AS rolling_3mo_customer_revenue

FROM monthly_metrics
ORDER BY year_month


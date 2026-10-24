/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- Calculate the total sales per month
-- and the running total that restarts every year

SELECT 
order_month,
total_sales,
SUM(total_sales) OVER(ORDER BY order_month) AS running_total_sales,
ROUND(avg_price,1) AS avg_price,
ROUND(AVG(avg_price) OVER(ORDER BY order_month),1) AS moving_avg_price
FROM
	(SELECT 
		DATETRUNC(MONTH,order_date) AS order_month,
		SUM(sales_amount) AS total_sales,
		AVG(price) AS avg_price
	
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(MONTH,order_date)
	)t

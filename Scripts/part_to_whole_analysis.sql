/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To find the proportion of each part relative to the whole.
    - To see which categories contribute the most to overall sales.

SQL Functions Used:
    - SUM(): Aggregates values per category.
    - Window Functions: SUM() OVER() for the overall total.
===============================================================================
*/
-- Which categories contribute the most to overall sales?
SELECT 
	t.category,
	t.total_sales,
	SUM(t.total_sales) OVER() AS overall_sales,
	CONCAT(CAST(ROUND(t.total_sales /SUM(t.total_sales) OVER(),4)*100  AS varchar),'%')AS percentage_of_total
FROM 
	(SELECT
	P.category,
	SUM(F.sales_amount) AS total_sales

	FROM gold.fact_sales F
	LEFT JOIN gold.dim_products P
	ON F.product_key = P.product_key
	GROUP BY P.category) t
ORDER BY t.total_sales DESC

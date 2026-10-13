/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/
-- Which 5 products Generating the Highest Revenue?
-- Simple Ranking
SELECT TOP 5
	P.product_name,
	SUM(F.sales_amount) AS total_revenue 

FROM gold.fact_sales F LEFT JOIN gold.dim_products P
ON F.product_key = P.product_key
GROUP BY P.product_name
ORDER BY total_revenue DESC

-- Complex but Flexibly Ranking Using Window Functions
SELECT *
FROM
	(SELECT 
		P.product_name,
		SUM(F.sales_amount) AS total_revenue ,
		ROW_NUMBER() OVER(ORDER BY SUM(F.sales_amount) DESC ) AS ranking

	FROM gold.fact_sales F LEFT JOIN gold.dim_products P
	ON F.product_key = P.product_key
	GROUP BY P.product_name) t 
WHERE t.ranking <=5

-- What are the 5 worst-performing products in terms of sales?
SELECT TOP 5
	P.product_name,
	SUM(F.sales_amount) AS total_revenue 

FROM gold.fact_sales F LEFT JOIN gold.dim_products P
ON F.product_key = P.product_key
GROUP BY P.product_name
ORDER BY total_revenue

-- Find the top 10 customers who have generated the highest revenue
SELECT *
FROM
	(SELECT 
		C.customer_key,
		first_name,
		last_name,
		SUM(F.sales_amount) total_revenue,
		ROW_NUMBER() OVER(ORDER BY SUM(F.sales_amount) DESC) ranking
	FROM gold.fact_sales F LEFT JOIN gold.dim_customers C
	ON F.customer_key = C.customer_key
	GROUP BY C.customer_key,
		first_name,
		last_name) t
WHERE t.ranking<=10

-- The 3 customers with the fewest orders placed
SELECT *
FROM 
	(SELECT 
		C.customer_key,
		C.first_name,
		C.last_name,
		COUNT(DISTINCT F.order_number) AS total_order,
		ROW_NUMBER() OVER(ORDER BY COUNT(DISTINCT F.order_number)) AS ranking

	FROM gold.fact_sales F LEFT JOIN gold.dim_customers C
	ON F.customer_key = C.customer_key
	GROUP BY C.customer_key,
			 C.first_name,
			 C.last_name
	)t
WHERE t.ranking <=3


	

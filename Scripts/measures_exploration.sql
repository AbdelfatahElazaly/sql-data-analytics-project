/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

-- Find the Total Sales
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales

-- Find how many items are sold
SELECT SUM(quantity) AS total_amount FROM gold.fact_sales
-- Find the average selling price
SELECT ROUND(AVG(price),2) AS avg_price FROM gold.fact_sales

-- Find the Total number of Orders
SELECT COUNT(order_number) AS totaL_order FROM gold.fact_sales 
SELECT COUNT(DISTINCT(order_number)) AS totaL_order FROM gold.fact_sales 

-- Find the total number of products
SELECT COUNT(product_key) AS total_product FROM gold.dim_products
-- Find the total number of customers
SELECT COUNT(customer_key) AS total_customer FROM gold.dim_customers

-- Find the total number of customers that has placed an order
SELECT COUNT(DISTINCT(customer_key)) AS total_customer FROM gold.fact_sales

-- Generate a Report that shows all key metrics of the business
SELECT 'total_sales : ' AS Measure_name ,  SUM(sales_amount) AS Measure_value FROM gold.fact_sales
UNION ALL
SELECT 'total_amount : ' , SUM(quantity) FROM gold.fact_sales 
UNION ALL
SELECT 'avg_price : ',ROUND(AVG(price),1)FROM gold.fact_sales
UNION ALL
SELECT 'totaL_order : ', COUNT(DISTINCT(order_number))  FROM gold.fact_sales 
UNION ALL
SELECT 'total_product : ', COUNT(product_key)  FROM gold.dim_products
UNION ALL 
SELECT 'total_customer : ', COUNT(customer_key)  FROM gold.dim_customers
UNION ALL
SELECT 'total_customer : ' ,COUNT(DISTINCT(customer_key)) FROM gold.fact_sales


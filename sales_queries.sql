-- ============================================================
-- DATA ANALYST WEEK 2: SQL FOR DATA ANALYSIS
-- Project: Sales Performance SQL Analysis
-- Author: Mahima Chaudhari
-- ============================================================

-- ------------------------------------------------------------
-- 1. TABLE SCHEMA DEFINITION
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS sales_data (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity INT,
    unit_price DECIMAL(10, 2),
    total_price DECIMAL(10, 2),
    region VARCHAR(50)
);

-- ------------------------------------------------------------
-- 2. QUERY 1: TOP 5 CUSTOMERS BY TOTAL SPENDING
-- Description: Identifies the top 5 highest-spending customers.
-- ------------------------------------------------------------
SELECT 
    customer_name, 
    COUNT(order_id) AS total_orders,
    SUM(total_price) AS total_spending
FROM sales_data
GROUP BY customer_name
ORDER BY total_spending DESC
LIMIT 5;

-- ------------------------------------------------------------
-- 3. QUERY 2: AVERAGE ORDER VALUE (AOV) & TOTAL REVENUE
-- Description: Computes overall revenue metrics and average order value.
-- ------------------------------------------------------------
SELECT 
    COUNT(order_id) AS total_orders,
    SUM(total_price) AS total_revenue,
    ROUND(AVG(total_price), 2) AS average_order_value
FROM sales_data;

-- ------------------------------------------------------------
-- 4. QUERY 3: CATEGORY-WISE SALES & AGGREGATIONS
-- Description: Groups sales by product category with aggregations.
-- ------------------------------------------------------------
SELECT 
    category,
    COUNT(order_id) AS total_orders,
    SUM(total_price) AS category_revenue,
    ROUND(AVG(unit_price), 2) AS avg_unit_price
FROM sales_data
GROUP BY category
ORDER BY category_revenue DESC;

-- ------------------------------------------------------------
-- 5. QUERY 4: ORDER CLASSIFICATION (CASE STATEMENT)
-- Description: Categorizes orders into High, Medium, and Low value tiers.
-- ------------------------------------------------------------
SELECT 
    order_id,
    customer_name,
    total_price,
    CASE 
        WHEN total_price >= 15000 THEN 'High Value'
        WHEN total_price >= 5000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS order_tier
FROM sales_data
ORDER BY total_price DESC;

-- ------------------------------------------------------------
-- 6. QUERY 5: REGIONAL SALES PERFORMANCE
-- Description: Evaluates total revenue generated across each region.
-- ------------------------------------------------------------
SELECT 
    region,
    COUNT(order_id) AS total_orders,
    SUM(total_price) AS regional_sales
FROM sales_data
GROUP BY region
ORDER BY regional_sales DESC;
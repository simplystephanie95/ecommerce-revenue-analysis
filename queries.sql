/* =========================================================
   E-COMMERCE REVENUE ANALYSIS
   Author: Stephanie Korad

   This SQL script performs data validation, cleaning,
   KPI analysis, revenue trend analysis, product analysis,
   geographic analysis, and customer behavior analysis.

   Dataset: UK Online Retail (2010–2011)
========================================================= */


/* =========================================================
   1. DATA VALIDATION
   Business Question:
   What is the overall structure and quality of the dataset?
========================================================= */

-- Total rows in dataset
SELECT COUNT(*) AS total_rows
FROM ecommerce_data;


-- Cancelled invoices
SELECT COUNT(*) AS cancelled_orders
FROM ecommerce_data
WHERE InvoiceNo LIKE 'C%';


-- Negative quantities (returns)
SELECT COUNT(*) AS negative_quantities
FROM ecommerce_data
WHERE Quantity < 0;


-- Missing Customer IDs
SELECT COUNT(*) AS missing_customer_ids
FROM ecommerce_data
WHERE CustomerID IS NULL;



/* =========================================================
   2. REMOVE DUPLICATES
   Business Question:
   Does the dataset contain duplicate transaction rows?
========================================================= */

SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT InvoiceNo + StockCode + Description 
+ CAST(Quantity AS VARCHAR) + CAST(UnitPrice AS VARCHAR)
+ CAST(InvoiceDate AS VARCHAR)) AS distinct_rows
FROM ecommerce_data;


/* =========================================================
   CLEAN DATASET BASE
   This CTE applies the cleaning rules used throughout
   the analysis.
========================================================= */

WITH clean_data AS (

SELECT DISTINCT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    Quantity * UnitPrice AS revenue

FROM ecommerce_data

WHERE InvoiceNo NOT LIKE 'C%'
AND Quantity > 0
AND UnitPrice > 0

)



/* =========================================================
   3. CORE BUSINESS KPIs
   Business Question:
   What is the overall performance of the business?
========================================================= */

SELECT
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    COUNT(DISTINCT CustomerID) AS total_customers,
    SUM(revenue) / COUNT(DISTINCT InvoiceNo) AS avg_order_value
FROM clean_data;



/* =========================================================
   4. MONTHLY REVENUE TREND
   Business Question:
   How does revenue change over time?
========================================================= */

SELECT
    DATEFROMPARTS(YEAR(InvoiceDate), MONTH(InvoiceDate), 1) AS month,
    SUM(revenue) AS monthly_revenue
FROM clean_data
GROUP BY DATEFROMPARTS(YEAR(InvoiceDate), MONTH(InvoiceDate), 1)
ORDER BY month;



/* =========================================================
   5. MONTH-OVER-MONTH (MoM) REVENUE GROWTH
   Business Question:
   Is revenue increasing or decreasing month to month?
========================================================= */

WITH monthly_revenue AS (

SELECT
    DATEFROMPARTS(YEAR(InvoiceDate), MONTH(InvoiceDate), 1) AS month,
    SUM(revenue) AS revenue
FROM clean_data
GROUP BY DATEFROMPARTS(YEAR(InvoiceDate), MONTH(InvoiceDate), 1)

)

SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue,
    revenue - LAG(revenue) OVER (ORDER BY month) AS revenue_change,
    ((revenue - LAG(revenue) OVER (ORDER BY month)) 
        / LAG(revenue) OVER (ORDER BY month)) * 100 AS mom_growth_percent
FROM monthly_revenue
ORDER BY month;



/* =========================================================
   6. TOP REVENUE GENERATING PRODUCTS
   Business Question:
   Which products generate the most revenue?
========================================================= */

SELECT TOP 10
    Description,
    SUM(revenue) AS product_revenue,
    SUM(Quantity) AS units_sold
FROM clean_data

-- Remove non-product entries
WHERE Description NOT IN ('DOTCOM POSTAGE','POSTAGE','Manual')

GROUP BY Description
ORDER BY product_revenue DESC;



/* =========================================================
   7. REVENUE BY COUNTRY
   Business Question:
   Which markets generate the most revenue?
========================================================= */

SELECT
    Country,
    SUM(revenue) AS revenue,
    COUNT(DISTINCT InvoiceNo) AS orders
FROM clean_data
GROUP BY Country
ORDER BY revenue DESC;



/* =========================================================
   8. CUSTOMER SEGMENTATION
   Business Question:
   Do customers make repeat purchases?
========================================================= */

WITH customer_orders AS (

SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS order_count
FROM clean_data
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID

)

SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time customers'
        ELSE 'Repeat customers'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM customer_orders
GROUP BY
    CASE
        WHEN order_count = 1 THEN 'One-time customers'
        ELSE 'Repeat customers'
    END;
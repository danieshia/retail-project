
-- Q1: Is revenue growing, flat, or declining over time?
SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS Date, ROUND(SUM(Quantity * Price), 2) AS Monthly_Revenue
FROM retail
GROUP BY DATE_FORMAT(InvoiceDate, '%Y-%m')
ORDER BY Date ASC;

-- Creating table for monthly revenue
-- Final month (2011-12) excluded - dataset only covers through Dec 9, so it's a partial month
-- and made the chart look like a big drop when it wasn't
CREATE TABLE monthly_revenue_trend AS
SELECT 
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS Date,
    ROUND(SUM(Quantity * Price), 2) AS Monthly_Revenue
FROM retail
WHERE InvoiceDate < '2011-12-01'
GROUP BY DATE_FORMAT(InvoiceDate, '%Y-%m')
ORDER BY Date ASC;


-- Q2: Top 10 best-selling products by quantity vs. by revenue

-- remember to use description as well instead of only using quantity, so its more clear when viewing

-- this is for quantity
CREATE TABLE top_products_by_quantity AS
SELECT Description, SUM(Quantity) AS Total_Quantity
FROM retail
GROUP BY Description
ORDER BY Total_Quantity DESC
LIMIT 10;

-- this is for rev
CREATE TABLE top_products_by_revenue AS
SELECT 
    Description,
    ROUND(SUM(Quantity * Price), 2) AS Total_Revenue
FROM retail
GROUP BY Description
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Q3: Can wholesale vs. individual buyers be distinguished by order size?

-- Average quantity purchased per order line, per customer
SELECT
    CustomerID,
    AVG(Quantity) AS avg_qty_per_line
FROM retail
GROUP BY CustomerID
ORDER BY avg_qty_per_line DESC;

-- Total quantity purchased per customer overall
SELECT
    CustomerID,
    SUM(Quantity) AS total_quantity_purchased
FROM retail
GROUP BY CustomerID
ORDER BY total_quantity_purchased DESC;


-- answer was no, couldnt be distinguished bc of outliers


-- Q4: What % of revenue comes from UK vs. international customers?
CREATE TABLE uk_vs_international_revenue AS
SELECT
    CASE WHEN Country = 'United Kingdom' THEN 'UK' ELSE 'International' END AS region,
    SUM(Quantity * Price) AS total_revenue
FROM retail
GROUP BY region;

-- Q5: What does monthly active customer activity look like over time?

CREATE TABLE monthly_active_customers AS
SELECT
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS month,
    COUNT(DISTINCT CustomerID) AS active_customers
FROM retail
WHERE InvoiceDate < '2011-12-01'
GROUP BY DATE_FORMAT(InvoiceDate, '%Y-%m')
ORDER BY month;

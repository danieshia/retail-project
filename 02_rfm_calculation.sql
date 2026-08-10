-- Common mistake for me, grouping by invoice and NOT customerid.

-- Recency (How long since last order until 2010)
SELECT CustomerID, DATEDIFF('2010-12-31', MAX(InvoiceDate)) AS DaysDifference FROM retail
GROUP BY CustomerID;

-- Frequency of orders (between each customer)
SELECT Customerid, COUNT(DISTINCT Invoice) as frequency_per_customer from retail
GROUP BY Customerid;

-- Monetary ($ per customer)
SELECT ROUND(SUM(quantity * price), 2) as cost_per_customer, customerid  from retail
GROUP BY Customerid;

-- All together
SELECT
    CustomerID,
    DATEDIFF('2010-12-31', MAX(InvoiceDate)) AS Recency,
    COUNT(DISTINCT Invoice) AS Frequency,
    ROUND(SUM(Quantity * Price), 2) AS Monetary
FROM retail
GROUP BY CustomerID;

-- make new table
CREATE TABLE rfm_base AS
SELECT
    CustomerID,
    DATEDIFF('2010-12-31', MAX(InvoiceDate)) AS Recency,
    COUNT(DISTINCT Invoice) AS Frequency,
    ROUND(SUM(Quantity * Price), 2) AS Monetary
FROM retail
GROUP BY CustomerID;

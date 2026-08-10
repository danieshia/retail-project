-- another new table
CREATE TABLE rfm_scored AS
SELECT CustomerID, Recency, Frequency, Monetary,
    NTILE(5) OVER (ORDER BY Recency DESC) AS R_score, -- This one is different from the other 2 bc we want the most recent customers to have a higher score vs older ones
    NTILE(5) OVER (ORDER BY Frequency ASC) AS F_score,
    NTILE(5) OVER (ORDER BY Monetary ASC) AS M_score
FROM rfm_base;
-- 5 = best, 1 = worst
-- WINDOW functions are OVER and NTILE - separates ordered data into diff groups to rank them

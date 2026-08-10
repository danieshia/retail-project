-- This is the query to segment customers based on RFM scores, and see the count per segment
SELECT segment, COUNT(*) AS customer_count
FROM (
    SELECT
        CASE
            WHEN R_score >= 4 AND F_score >= 4 AND M_score >= 4 THEN 'Champions'
            WHEN F_score >= 4 AND M_score >= 4 AND R_score < 4 THEN 'Loyal Customers'
            WHEN R_score >= 4 AND F_score < 3 THEN 'recent first-time buyers'
            WHEN R_score <= 2 AND (F_score >= 3 OR M_score >= 3) THEN 'At Risk'
            WHEN R_score < 3 AND F_score < 3 AND M_score < 3 THEN 'Lost'
            ELSE 'Other' 
        END AS segment
    FROM rfm_scored
) AS segmented
GROUP BY segment;

-- saving it as its own table as well
CREATE TABLE rfm_segments AS
SELECT CustomerID, Recency, Frequency, Monetary, R_score, F_score, M_score,
    CASE
        WHEN R_score >= 4 AND F_score >= 4 AND M_score >= 4 THEN 'Champions'
        WHEN F_score >= 4 AND M_score >= 4 AND R_score < 4 THEN 'Loyal Customers'
        WHEN R_score >= 4 AND F_score < 3 THEN 'recent first-time buyers'
        WHEN R_score <= 2 AND (F_score >= 3 OR M_score >= 3) THEN 'At Risk'
        WHEN R_score < 3 AND F_score < 3 AND M_score < 3 THEN 'Lost'
        ELSE 'Other'
    END AS segment
FROM rfm_scored;

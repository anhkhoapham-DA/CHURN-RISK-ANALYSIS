/*
PROJECT: BANK CUSTOMER CHURN RISK ANALYSIS
Tools Used: SQL (CTE, Window Functions, Aggregation)
Description: 
    This script analyzes customer churn drivers and implements 
    an automated risk scoring system to identify high-risk segments.
*/

-- =============================================
-- STEP 1: GENERAL EXPLORATION & BASELINE
-- =============================================

-- 1. Check Overall Churn Rate
-- Objective: Establish the baseline churn rate to compare against specific segments.
SELECT 
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    CAST(SUM(Exited) AS FLOAT) / COUNT(*) * 100 AS churn_rate_percent
FROM churn_table


-- =============================================
-- STEP 2: KEY CHURN INDICATORS (DEEP DIVE)
-- =============================================

-- 2.1 Impact of Product Depth (NumOfProducts)
-- Hypothesis: Customers with too many products (bad bundle) are more likely to churn.
SELECT 
    NumOfProducts,
    COUNT(*) AS total_customers,
    AVG(Exited) * 100 AS churn_rate
FROM churn_table
GROUP BY NumOfProducts
ORDER BY churn_rate DESC
-- Result: NumOfProducts >= 3 shows very high churn (80% and 100%).

-- 2.2 Impact of Engagement (IsActiveMember)
-- Hypothesis: Inactive members are more likely to leave.
SELECT 
    IsActiveMember, -- 1 = Active, 0 = Inactive
    COUNT(*) AS total_customers,
    AVG(Exited) * 100 AS churn_rate
FROM churn_table
GROUP BY IsActiveMember
ORDER BY churn_rate DESC

-- 2.3 Interaction: Geography & Age Group
-- Objective: Pinpoint the specific demographic causing high churn.
SELECT 
    Geography,
    age_group,
    COUNT(*) as customer_count,
    ROUND(CAST(SUM(Exited) AS FLOAT) / COUNT(*) * 100, 2) AS churn_rate
FROM churn_table
GROUP BY 
    Geography, 
    age_group
ORDER BY churn_rate DESC

-- =============================================
-- STEP 3: RISK SCORING MODEL
-- =============================================

/* Risk Scoring Logic:
1. Demographics: Customer is in Germany AND > 50 years old -> +30 points
2. Product Strategy: Customer has >= 3 products -> +50 points (Critical driver)
3. Engagement: Customer is Inactive -> +20 points
*/


With Risk_Scoring AS (
    -- Apply the Scoring Rules
    SELECT *, 
        (
            CASE WHEN Geography = 'Germany' AND Age_Group = 'Senior' THEN 30 ELSE 0 END +
            CASE WHEN NumOfProducts >= 3 THEN 50 ELSE 0 END +
            CASE WHEN IsActiveMember = 0 THEN 20 ELSE 0 END
        ) AS Risk_Score
    FROM churn_table
)

-- =============================================
-- STEP 4: FINAL REPORT & VALUE AT RISK (VaR)
-- =============================================

-- Objective: Segment customers by risk level and calculate potential financial loss.
SELECT 
    CASE 
        WHEN Risk_Score >= 50 THEN 'Critical Risk'
        WHEN Risk_Score BETWEEN 30 AND 49 THEN 'High Risk'
        WHEN Risk_Score BETWEEN 10 AND 29 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS Risk_Segment,
    COUNT(CustomerId) AS Total_Customers,
    ROUND(AVG(Exited) * 100, 2) AS Actual_Churn_Rate, -- Validate if the model works
    SUM(Balance) AS Total_Value_At_Risk -- The total money at risk of being lost
FROM Risk_Scoring
GROUP BY 
    CASE 
        WHEN Risk_Score >= 50 THEN 'Critical Risk'
        WHEN Risk_Score BETWEEN 30 AND 49 THEN 'High Risk'
        WHEN Risk_Score BETWEEN 10 AND 29 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END
ORDER BY Actual_Churn_Rate DESC
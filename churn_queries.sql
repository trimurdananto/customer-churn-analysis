-- ==========================================================
-- CUSTOMER CHURN & RETENTION INSIGHTS - SQL SCRIPTS
-- Database Dialect: PostgreSQL / MySQL Compatible
-- ==========================================================

-- 1. Calculate Overall Churn Rate
-- Objective: Find the percentage of customers who have churned vs total customers.
SELECT 
    COUNT(customer_id) AS total_customers,
    SUM(CASE WHEN churn_status = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        (SUM(CASE WHEN churn_status = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(customer_id), 
        2
    ) AS churn_rate_percentage
FROM 
    customer_data;


-- 2. Churn Rate by Subscription Plan / Category
-- Objective: Identify which plans suffer from the highest customer loss.
SELECT 
    subscription_plan,
    COUNT(customer_id) AS total_subscribers,
    SUM(CASE WHEN churn_status = 'Yes' THEN 1 ELSE 0 END) AS total_churned,
    ROUND(
        (SUM(CASE WHEN churn_status = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(customer_id), 
        2
    ) AS plan_churn_rate
FROM 
    customer_data
GROUP BY 
    subscription_plan
ORDER BY 
    plan_churn_rate DESC;


-- 3. Average Tenure of Churned vs Active Customers
-- Objective: Understand how long customers stay before leaving.
SELECT 
    churn_status,
    ROUND(AVG(tenure_months), 1) AS avg_tenure_months,
    ROUND(AVG(total_spend), 2) AS avg_total_spend
FROM 
    customer_data
GROUP BY 
    churn_status;

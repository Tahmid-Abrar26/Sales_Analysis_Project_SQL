CREATE VIEW customer_age_groups AS
SELECT 
    customerkey,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, birthday)) * 12 + EXTRACT(MONTH FROM AGE(CURRENT_DATE, birthday)) AS age_in_months,
    AGE(CURRENT_DATE, birthday) AS age,
    CASE 
        WHEN birthday >= CURRENT_DATE - INTERVAL '25 years' THEN 'Under 25'
        WHEN birthday >= CURRENT_DATE - INTERVAL '49 years' THEN '25-50'
        ELSE '50+'
    END AS age_group
FROM customer;
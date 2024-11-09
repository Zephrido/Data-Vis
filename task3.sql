WITH AgeGroups AS (
    SELECT
        CASE
            WHEN age BETWEEN 0 AND 9 THEN '0-9'
            WHEN age BETWEEN 10 AND 19 THEN '10-19'
            WHEN age BETWEEN 20 AND 29 THEN '20-29'
            ELSE 'Unknown'  
        END AS age_group,
        ID_client
    FROM clients  
)
SELECT
    ag.age_group,
    SUM(t.Sum_payment) AS total_amount,
    COUNT(t.Id_check) AS total_transactions,
    AVG(t.Sum_payment) as avg_amount, 
    COUNT(t.Id_check) * 100.0 / SUM(COUNT(t.Id_check)) OVER () as percentage 

FROM AgeGroups ag
JOIN transactions t ON ag.ID_client = t.ID_client
GROUP BY ag.age_group;

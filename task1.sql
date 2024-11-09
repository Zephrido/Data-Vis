WITH Monthly_Transactions AS (
    SELECT
        t.ID_client,
        EXTRACT(MONTH FROM t.date_new) AS month,
        COUNT(*) AS transactions_count,
        SUM(t.Sum_payment) AS total_payment
    FROM
        transactions t
    WHERE
        t.date_new >= '2015-06-01' AND t.date_new <= '2016-06-01'
    GROUP BY
        t.ID_client, EXTRACT(MONTH FROM t.date_new)
),
Client_Continuous_History AS (
    SELECT
        ID_client,
        COUNT(DISTINCT month) AS months_active
    FROM
        Monthly_Transactions
    GROUP BY
        ID_client
    HAVING
        COUNT(DISTINCT month) = 12  
)
SELECT
    c.ID_client,
    AVG(m.total_payment) AS average_receipt, 
    AVG(m.transactions_count) AS avg_monthly_transactions,  
    SUM(m.transactions_count) AS total_transactions_count  
FROM
    Client_Continuous_History c
JOIN
    Monthly_Transactions m ON c.ID_client = m.ID_client
GROUP BY
    c.ID_client;

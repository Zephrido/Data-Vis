WITH Monthly_Stats AS (
    SELECT
        EXTRACT(MONTH FROM t.date_new) AS month,
        AVG(t.Sum_payment) AS avg_check,
        COUNT(*) AS total_operations,
        COUNT(DISTINCT t.ID_client) AS num_clients,
        SUM(t.Sum_payment) AS total_sum
    FROM
        transactions t
    WHERE
        t.date_new >= '2015-06-01' AND t.date_new <= '2016-06-01'
    GROUP BY
        EXTRACT(MONTH FROM t.date_new)
),
Yearly_Stats AS (
    SELECT
        SUM(t.Sum_payment) AS yearly_total,
        COUNT(*) AS yearly_operations
    FROM
        transactions t
    WHERE
        t.date_new >= '2015-06-01' AND t.date_new <= '2016-06-01'
)
SELECT
    m.month,
    m.avg_check,
    m.total_operations,
    m.num_clients,
    (m.total_operations * 100.0 / y.yearly_operations) AS share_operations,
    (m.total_sum * 100.0 / y.yearly_total) AS share_sum
FROM
    Monthly_Stats m,
    Yearly_Stats y
ORDER BY
    m.month;

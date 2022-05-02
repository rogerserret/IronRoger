# Customer behavior with SQL and Python
# good customer churn - month to month how many transactions can we see which belong to good and bad customers?
use bank;

CREATE VIEW trans_status_date AS
SELECT l.status, CONVERT(t.date, date) as date, d.client_id, t.trans_id , t.amount 
FROM trans t
JOIN loan l USING (account_id)
JOIN disp d USING(account_id)
WHERE d.type = 'OWNER';

SELECT status, (CASE WHEN status IN('A','C') THEN 'good' ELSE 'bad' END) AS status_group, date, SUM(amount), COUNT(distinct trans_id), count(client_id)
FROM trans_status_date
GROUP BY status, status_group, date;
```sql
CREATE VIEW v_supplier_health AS

SELECT

    s.supplier_id,
    s.farm_name,
    s.region,
    s.status,

    CASE
        WHEN c.cert_expiry_date IS NULL THEN 'Unknown'
        WHEN c.cert_expiry_date < DATE('now') THEN 'Expired'
        WHEN c.cert_expiry_date <= DATE('now', '+30 days')
            THEN 'Expiring Soon'
        ELSE 'Valid'
    END AS cert_status,

    COUNT(o.order_id) AS orders_90d,

    h.yield_kg AS latest_yield,

    AVG(h.yield_kg) OVER (
        PARTITION BY h.supplier_id
        ORDER BY h.harvest_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_avg_yield

FROM Suppliers s

LEFT JOIN Certifications c
ON s.supplier_id = c.supplier_id

LEFT JOIN Orders o
ON s.supplier_id = o.supplier_id
AND o.order_date >= DATE('now', '-90 days')

LEFT JOIN Harvest_Log h
ON s.supplier_id = h.supplier_id

GROUP BY
    s.supplier_id,
    s.farm_name,
    s.region,
    s.status,
    c.cert_expiry_date,
    h.harvest_id;



-- RISK QUERY

SELECT *

FROM v_supplier_health

WHERE
    cert_status IN ('Expired', 'Expiring Soon')

    OR orders_90d = 0

    OR latest_yield < (
        rolling_avg_yield * 0.8
    );
```


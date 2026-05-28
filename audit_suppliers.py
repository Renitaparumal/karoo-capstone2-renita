```python
import sqlite3

try:

    conn = sqlite3.connect("karoo_auditor.db")

    cursor = conn.cursor()

    print("Database connected")


    # LOAD TEST DATA
    with open("test_data.sql", "r") as file:
        test_data = file.read()

    cursor.executescript(test_data)


    # LOAD VIEW
    with open("auditor_views.sql", "r") as file:
        views = file.read()

    cursor.executescript(views)


    # FIND RISK SUPPLIERS
    risk_query = """

    SELECT DISTINCT supplier_id

    FROM v_supplier_health

    WHERE
        cert_status IN ('Expired', 'Expiring Soon')

        OR orders_90d = 0

        OR latest_yield < (
            rolling_avg_yield * 0.8
        );

    """

    cursor.execute(risk_query)

    at_risk = cursor.fetchall()


    # UPDATE STATUS
    update_query = """

    UPDATE Suppliers

    SET
        status = ?,
        last_audit = DATE('now')

    WHERE supplier_id = ?

    """


    for supplier in at_risk:

        cursor.execute(
            update_query,
            ('Review', supplier[0])
        )


    conn.commit()

    print(f"{len(at_risk)} suppliers require review")


except Exception as e:

    conn.rollback()

    print("Error:", e)


finally:

    conn.close()

    print("Database connection closed")
```


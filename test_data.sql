```sql
CREATE TABLE Suppliers (
    supplier_id INTEGER PRIMARY KEY AUTOINCREMENT,
    farm_name TEXT NOT NULL,
    region TEXT NOT NULL,
    status TEXT DEFAULT 'Active',
    last_audit TEXT
);

CREATE TABLE Certifications (
    certification_id INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier_id INTEGER NOT NULL,
    cert_expiry_date TEXT,

    FOREIGN KEY (supplier_id)
    REFERENCES Suppliers(supplier_id)
);

CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier_id INTEGER NOT NULL,
    total_price REAL,
    order_date TEXT,

    FOREIGN KEY (supplier_id)
    REFERENCES Suppliers(supplier_id)
);

CREATE TABLE Harvest_Log (
    harvest_id INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier_id INTEGER NOT NULL,
    yield_kg REAL,
    harvest_date TEXT,

    FOREIGN KEY (supplier_id)
    REFERENCES Suppliers(supplier_id)
);



INSERT INTO Suppliers
(farm_name, region)
VALUES
('Karoo Fresh Farms', 'Western Cape'),
('Eastern Harvest', 'Eastern Cape'),
('Northern Organics', 'Northern Cape');



INSERT INTO Certifications
(supplier_id, cert_expiry_date)
VALUES
(1, '2026-06-10'),
(2, '2025-01-01'),
(3, '2026-12-31');



INSERT INTO Orders
(supplier_id, total_price, order_date)
VALUES
(1, 12000, '2026-05-01'),
(1, 8000, '2026-05-10'),
(3, 9500, '2026-04-15');



INSERT INTO Harvest_Log
(supplier_id, yield_kg, harvest_date)
VALUES
(1, 500, '2026-03-01'),
(1, 450, '2026-04-01'),
(1, 300, '2026-05-01'),

(2, 600, '2026-03-01'),
(2, 580, '2026-04-01'),
(2, 200, '2026-05-01'),

(3, 700, '2026-03-01'),
(3, 710, '2026-04-01'),
(3, 705, '2026-05-01');
```


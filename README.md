# Karoo Organics Supplier Risk & Compliance Auditor

## Overview

This project automates supplier risk monitoring for Karoo Organics.

The system identifies suppliers requiring review based on:

* Expired certifications
* Certifications expiring within 30 days
* No orders within 90 days
* Yield decline below 80% of rolling average

## Features

* Automated supplier health monitoring
* Rolling average yield analysis
* Compliance auditing
* Automatic supplier status updates
* Audit trail using last_audit field

## Compliance Considerations

This solution supports POPIA-aligned data governance by:

* Maintaining audit records
* Tracking supplier review activity
* Avoiding unnecessary personal data exposure

## Technologies Used

* Python
* SQLite
* SQL
* VS Code

## Files Included

* auditor_views.sql
* audit_suppliers.py
* test_data.sql
* README.md

## How To Run

Run:

python audit_suppliers.py


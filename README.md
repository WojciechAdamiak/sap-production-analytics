# SAP Production Analytics Platform (PostgreSQL)

## 📌 Project Overview
This project delivers a relational database system modeled after **SAP ERP** structures (`MARA`, `AUFK`, `MSEG`) for an aviation manufacturing facility. It focuses on analyzing production fulfillment, quality tracking (scrap rates), and financial losses due to manufacturing defects.

The dataset includes **25 operational production orders** enabling deep-dive performance analysis and KPI tracking.

---

## 🏢 Database Architecture & Schema

The project consists of 4 core tables located in the `public` schema:
1. **`sap_mara`** (Master Data): Contains aircraft part numbers, descriptions, unit costs, and safety stock levels.
2. **`sap_work_centers`** (Master Data): Defines manufacturing cells (CNC, Laser, Assembly) and their weekly capacities.
3. **`sap_aufk`** (Fact Data): Production orders containing planned vs. actual quantities, scrap tracking, timestamps, and setup times.
4. **`sap_mseg`** (Transactional Data): Current inventory levels and material reservations across warehouses.


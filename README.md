# SAP Production Analytics Platform (PostgreSQL)

## 📌 Project Overview
This project delivers a relational database system modeled after SAP ERP structures (MARA, AUFK, MSEG) for an aviation manufacturing facility. It focuses on analyzing production fulfillment, quality tracking (scrap rates), and financial losses due to manufacturing defects.

The dataset includes 25 operational production orders enabling deep-dive performance analysis and KPI tracking.

## 🏢 Database Architecture & Schema
The project consists of 4 core tables located in the public schema:

- **sap_mara (Master Data)**: Contains aircraft part numbers, descriptions, unit costs, and safety stock levels.
- **sap_work_centers (Master Data)**: Defines manufacturing cells (CNC, Laser, Assembly) and their weekly capacities.
- **sap_aufk (Fact Data)**: Production orders containing planned vs. actual quantities, scrap tracking, timestamps, and setup times.
- **sap_mseg (Transactional Data)**: Current inventory levels and material reservations across warehouses.

## 📂 Project Structure
```text
sap-production-analytics/
├── data/
│   └── 02_seed_data.sql                        # Seeding master data and 25 operational production orders
├── queries/
│   ├── 03_financial_analysis.sql               # Evaluation of scrap costs and financial losses
│   ├── 04_kpi_metrics.sql                      # Machine efficiency and operational KPIs
│   └── 06_inventory_alerts.sql                 # Automated material shortage detection script
├── schema/
│   ├── 01_init_tables.sql                      # Table DDL definitions and relationships
│   └── 07_performance_indexes.sql              # Performance tuning indexes for foreign keys and dates
├── views/
│   └── 05_production_performance_dashboard.sql # Global reporting view optimized for Power BI & Tableau
├── .gitignore                                  # Standard protection against environment leaks (.dbeaver/, *.log)
└── README.md                                   # Project documentation
```

## 📖 Playbook: SAP-to-PostgreSQL Analytics Pipeline
*Infrastructure, Performance Optimization, and BI Integration Guide*

This repository implements a production-ready engineering workflow based on three core architectural principles:

### 1. Advanced Inventory Alerting (`queries/06_inventory_alerts.sql`)
- **Deficit Engine**: Automatically screens current stock (`sap_mseg`) against engineering thresholds (`sap_mara`).
- **Mathematical Resilience**: Implements the `NULLIF(safety_stock_level, 0)` pattern to eliminate any risk of critical runtime division-by-zero errors.

### 2. High-Performance Indexing (`schema/07_performance_indexes.sql`)
- **Relational Speedups**: Manually indexes foreign key attributes (`material_id`, `wc_id`) in high-frequency transaction tables to reduce `JOIN` complexity from sequential scans to rapid index scans.
- **Time-Series Optimization**: Applies B-Tree indexing on operational timestamps (`planned_start_date`, `actual_end_date`) to accelerate business filtering and date-truncation functions.

### 3. Business Intelligence Semantic Layer (`views/05_production_performance_dashboard.sql`)
- **Data Denormalization**: Transforms a highly normalized schema into a flattened Reporting View, reducing modelling workload directly inside Power BI or Tableau.
- **Pre-computed KPIs**: Exposes standard operational metrics including `plan_fulfillment_percentage`, `days_delayed`, and `stock_health_status` compiled directly at the database engine level.

### 4. Git Repository & Environment Sanitation (`.gitignore`)
- Rules for blocking local database metadata (`.dbeaver/`), application logs (`*.log`), and system artifacts.

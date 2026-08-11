-- TYPE: DDL (Data Definition Language)
-- DESCRIPTION: Initialization of SAP-modeled relational table structures

-- 1. Material Master Data Table
CREATE TABLE IF NOT EXISTS sap_mara (
    material_id VARCHAR(20) PRIMARY KEY,
    part_number VARCHAR(30) UNIQUE,
    description VARCHAR(100),
    material_group VARCHAR(30),
    unit_cost_usd DECIMAL(10, 2),
    safety_stock_level INT
);

-- 2. Manufacturing Work Centers Table
CREATE TABLE IF NOT EXISTS sap_work_centers (
    wc_id VARCHAR(10) PRIMARY KEY,
    wc_name VARCHAR(50),
    max_capacity_hours_weekly INT
);

-- 3. Production Orders Fact Table
CREATE TABLE IF NOT EXISTS sap_aufk (
    order_id VARCHAR(20) PRIMARY KEY,
    material_id VARCHAR(20) REFERENCES sap_mara(material_id),
    wc_id VARCHAR(10) REFERENCES sap_work_centers(wc_id),
    quantity_planned INT,
    quantity_produced INT,
    quantity_scrapped INT,
    planned_start_date DATE,
    planned_end_date DATE,
    actual_end_date DATE,
    setup_hours_actual INT
);

-- 4. Inventory & Stock Levels Table
CREATE TABLE IF NOT EXISTS sap_mseg (
    material_id VARCHAR(20) REFERENCES sap_mara(material_id),
    warehouse_id VARCHAR(10),
    stock_qty_available INT,
    stock_qty_reserved INT,
    PRIMARY KEY (material_id, warehouse_id)
);

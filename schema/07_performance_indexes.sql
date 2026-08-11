-- SCRIPT: 07_performance_indexes.sql
-- DESCRIPTION: Performance tuning for foreign keys and reporting dates.

-- OPTIMIZATION: Foreign keys in the production orders table (accelerates JOINs with sap_mara and sap_work_centers)
CREATE INDEX IF NOT EXISTS idx_sap_aufk_material_id ON sap_aufk(material_id);
CREATE INDEX IF NOT EXISTS idx_sap_aufk_wc_id ON sap_aufk(wc_id);

-- OPTIMIZATION: Date columns used for filtering, sorting, and time-series reporting
CREATE INDEX IF NOT EXISTS idx_sap_aufk_planned_start ON sap_aufk(planned_start_date);
CREATE INDEX IF NOT EXISTS idx_sap_aufk_planned_end ON sap_aufk(planned_end_date);
CREATE INDEX IF NOT EXISTS idx_sap_aufk_actual_end ON sap_aufk(actual_end_date);


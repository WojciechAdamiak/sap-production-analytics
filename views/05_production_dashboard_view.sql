-- TYPE: DDL (Database View)
-- DESCRIPTION: Global reporting view optimized for Business Intelligence (BI) tools

CREATE OR REPLACE VIEW public.v_production_performance_dashboard AS
SELECT 
    a.order_id,
    m.material_id,
    m.part_number,
    m.description AS material_description,
    m.material_group,
    w.wc_id,
    w.wc_name AS work_center_name,
    a.quantity_planned,
    a.quantity_produced,
    a.quantity_scrapped,
    ROUND((a.quantity_produced::NUMERIC / NULLIF(a.quantity_planned, 0) * 100), 2) AS plan_fulfillment_percentage,
    a.planned_start_date,
    a.planned_end_date,
    a.actual_end_date,
    COALESCE(a.actual_end_date - a.planned_end_date, 0) AS days_delayed,
    a.setup_hours_actual,
    
    -- Added columns for Business Intelligence inventory tracking
    i.warehouse_id,
    i.stock_qty_available,
    i.stock_qty_reserved,
    m.safety_stock_level,
    CASE 
        WHEN i.stock_qty_available < m.safety_stock_level THEN 'CRITICAL'
        ELSE 'OK'
    END AS stock_health_status
FROM public.sap_aufk a
JOIN public.sap_mara m ON a.material_id = m.material_id
JOIN public.sap_work_centers w ON a.wc_id = w.wc_id
-- Left join ensures we don't lose production records if warehouse stock is missing
LEFT JOIN public.sap_mseg i ON m.material_id = i.material_id;


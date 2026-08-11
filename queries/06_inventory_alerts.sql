-- SCRIPT: 06_inventory_alerts.sql
-- DESCRIPTION: Automatically detects materials where available stock has dropped below the safety stock level.

SELECT 
    m.warehouse_id,
    m.material_id,
    p.part_number,
    p.description,
    p.material_group,
    m.stock_qty_available,
    p.safety_stock_level,
    -- Calculate the exact shortage amount
    (p.safety_stock_level - m.stock_qty_available) AS stock_deficit,
    -- Calculate the current safety level percentage (prevents division by zero)
    ROUND((m.stock_qty_available::NUMERIC / NULLIF(p.safety_stock_level, 0)) * 100, 2) AS safety_stock_percentage
FROM 
    sap_mseg m
JOIN 
    sap_mara p ON m.material_id = p.material_id
WHERE 
    m.stock_qty_available < p.safety_stock_level
ORDER BY 
    safety_stock_percentage ASC, 
    stock_deficit DESC;


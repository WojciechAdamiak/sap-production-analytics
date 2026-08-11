-- TYPE: DQL (Data Query Language)
-- DESCRIPTION: Financial analysis of scrap material losses and logistical fulfillment status

SELECT 
    a.order_id,
    m.part_number,
    a.quantity_produced AS produced_qty,
    (a.quantity_produced * m.unit_cost_usd) AS production_value_usd,
    a.quantity_scrapped AS scrapped_qty,
    (a.quantity_scrapped * m.unit_cost_usd) AS scrap_loss_cost_usd,
    CASE 
        WHEN a.actual_end_date IS NULL THEN 'In Progress (Planned)'
        WHEN a.actual_end_date <= a.planned_end_date THEN 'Success (On Time)'
        ELSE CONCAT('Delayed by ', a.actual_end_date - a.planned_end_date, ' days')
    END AS execution_status
FROM public.sap_aufk a
JOIN public.sap_mara m ON a.material_id = m.material_id
ORDER BY scrap_loss_cost_usd DESC, order_id;


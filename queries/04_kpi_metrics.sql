-- TYPE: DQL (Data Query Language)
-- DESCRIPTION: KPI aggregation for manufacturing work centers (Quality vs Throughput)

SELECT 
    w.wc_id,
    w.wc_name,
    COUNT(a.order_id) AS total_orders,
    SUM(a.quantity_planned) AS total_planned_qty,
    SUM(a.quantity_produced) AS total_good_qty,
    SUM(a.quantity_scrapped) AS total_scrapped_qty,
    ROUND(
        (SUM(a.quantity_produced)::NUMERIC / NULLIF(SUM(a.quantity_produced + a.quantity_scrapped), 0) * 100), 2
    ) AS quality_rate_percentage,
    SUM(a.setup_hours_actual) AS total_setup_hours
FROM public.sap_work_centers w
LEFT JOIN public.sap_aufk a ON w.wc_id = a.wc_id
GROUP BY w.wc_id, w.wc_name
ORDER BY quality_rate_percentage DESC;


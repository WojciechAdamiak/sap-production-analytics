# SCRIPT: generate_clean_data.py
# DESCRIPTION: Automatically creates the clean_data/ directory and populates it with CSV exports.

import os
import pandas as pd

print("--- STARTING DATA EXTRACTION PIPELINE ---")

# Automatically create the destination folder if it doesn't exist
os.makedirs('clean_data', exist_ok=True)

# 1. Master Data: Materials (MARA)
mara_data = {
    'material_id': ['MAT-991', 'MAT-992', 'MAT-993'],
    'part_number': ['PW-BLADE-01', 'PW-CASE-05', 'PW-ROTR-09'],
    'description': ['Low Pressure Turbine Blade (Rzeszów Fleet)', 'Titanium Fan Case Enclosure', 'High Pressure Compressor Shaft'],
    'material_group': ['Turbines', 'Casings', 'Rotors'],
    'unit_cost_usd': [1250.00, 8900.00, 5400.00],
    'safety_stock_level': [100, 15, 25]
}
pd.DataFrame(mara_data).to_csv('clean_data/sap_mara.csv', index=False)
print("[SUCCESS] Exported: clean_data/sap_mara.csv")

# 2. Master Data: Work Centers
wc_data = {
    'wc_id': ['WC-CNC01', 'WC-LAS02', 'WC-ASM03'],
    'wc_name': ['High-Precision CNC Milling Center', 'Laser Quality Inspection & Certification', 'Final Engine Assembly Line'],
    'max_capacity_hours_weekly': [120, 80, 160]
}
pd.DataFrame(wc_data).to_csv('clean_data/sap_work_centers.csv', index=False)
print("[SUCCESS] Exported: clean_data/sap_work_centers.csv")

# 3. Transactional Data: Inventory (MSEG)
mseg_data = {
    'material_id': ['MAT-991', 'MAT-992', 'MAT-993'],
    'warehouse_id': ['WH-RZE01', 'WH-RZE01', 'WH-RZE02'],
    'stock_qty_available': [85, 22, 40],
    'stock_qty_reserved': [40, 10, 15]
}
pd.DataFrame(mseg_data).to_csv('clean_data/sap_mseg.csv', index=False)
print("[SUCCESS] Exported: clean_data/sap_mseg.csv")

# 4. Fact Data: Production Orders (AUFK)
aufk_raw = [
    ('ORD-2026-001', 'MAT-991', 'WC-CNC01', 150, 142, 8, '2026-08-01', '2026-08-05', '2026-08-06', 5),
    ('ORD-2026-002', 'MAT-992', 'WC-LAS02', 10, 10, 0, '2026-08-02', '2026-08-07', '2026-08-07', 12),
    ('ORD-2026-003', 'MAT-993', 'WC-CNC01', 30, 29, 1, '2026-08-03', '2026-08-10', '2026-08-12', 8),
    ('ORD-2026-004', 'MAT-991', 'WC-ASM03', 80, 80, 0, '2026-08-04', '2026-08-08', '2026-08-08', 4),
    ('ORD-2026-005', 'MAT-992', 'WC-CNC01', 15, 12, 3, '2026-08-05', '2026-08-12', '2026-08-14', 10),
    ('ORD-2026-006', 'MAT-991', 'WC-CNC01', 200, 195, 5, '2026-08-08', '2026-08-12', '2026-08-12', 6),
    ('ORD-2026-007', 'MAT-993', 'WC-LAS02', 25, 25, 0, '2026-08-09', '2026-08-15', '2026-08-15', 7),
    ('ORD-2026-008', 'MAT-992', 'WC-ASM03', 12, 12, 0, '2026-08-10', '2026-08-16', '2026-08-15', 3),
    ('ORD-2026-009', 'MAT-991', 'WC-ASM03', 90, 85, 5, '2026-08-11', '2026-08-17', '2026-08-19', 5),
    ('ORD-2026-010', 'MAT-993', 'WC-CNC01', 45, 40, 5, '2026-08-12', '2026-08-19', '2026-08-21', 9),
    ('ORD-2026-011', 'MAT-991', 'WC-CNC01', 160, 155, 5, '2026-08-15', '2026-08-20', '2026-08-20', 6),
    ('ORD-2026-012', 'MAT-992', 'WC-LAS02', 8, 8, 0, '2026-08-16', '2026-08-22', '2026-08-23', 11),
    ('ORD-2026-013', 'MAT-993', 'WC-ASM03', 35, 32, 3, '2026-08-17', '2026-08-24', '2026-08-24', 4),
    ('ORD-2026-014', 'MAT-991', 'WC-LAS02', 110, 108, 2, '2026-08-18', '2026-08-23', '2026-08-23', 8),
    ('ORD-2026-015', 'MAT-992', 'WC-CNC01', 20, 18, 2, '2026-08-19', '2026-08-26', '2026-08-27', 12),
    ('ORD-2026-016', 'MAT-991', 'WC-CNC01', 180, 0, 0, '2026-08-22', '2026-08-26', None, 0),
    ('ORD-2026-017', 'MAT-993', 'WC-LAS02', 30, 0, 0, '2026-08-23', '2026-08-29', None, 0),
    ('ORD-2026-018', 'MAT-992', 'WC-ASM03', 15, 0, 0, '2026-08-24', '2026-08-30', None, 0),
    ('ORD-2026-019', 'MAT-991', 'WC-ASM03', 95, 0, 0, '2026-08-25', '2026-08-31', None, 0),
    ('ORD-2026-020', 'MAT-993', 'WC-CNC01', 50, 0, 0, '2026-08-26', '2026-09-02', None, 0),
    ('ORD-2026-090', 'MAT-991', 'WC-CNC01', 140, 140, 0, '2026-07-25', '2026-07-29', '2026-07-29', 4),
    ('ORD-2026-091', 'MAT-992', 'WC-LAS02', 14, 11, 3, '2026-07-26', '2026-08-01', '2026-08-02', 13),
    ('ORD-2026-092', 'MAT-993', 'WC-ASM03', 28, 28, 0, '2026-07-27', '2026-08-02', '2026-08-02', 3),
    ('ORD-2026-093', 'MAT-991', 'WC-LAS02', 100, 95, 5, '2026-07-28', '2026-08-02', '2026-08-04', 7),
    ('ORD-2026-094', 'MAT-993', 'WC-CNC01', 40, 39, 1, '2026-07-29', '2026-08-05', '2026-08-05', 8)
]
aufk_cols = [
    'order_id', 'material_id', 'wc_id', 'quantity_planned', 'quantity_produced', 
    'quantity_scrapped', 'planned_start_date', 'planned_end_date', 'actual_end_date', 'setup_hours_actual'
]
pd.DataFrame(aufk_raw, columns=aufk_cols).to_csv('clean_data/sap_aufk.csv', index=False)
print("[SUCCESS] Exported: clean_data/sap_aufk.csv")

print("\n[COMPLETE] All 4 data packages successfully compiled inside clean_data/ folder!")

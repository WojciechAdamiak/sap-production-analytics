-- TYPE: DML (Data Manipulation Language)
-- DESCRIPTION: Seeding master data and 25 operational production orders

-- Seeding Material Master (MARA)
INSERT INTO sap_mara VALUES 
('MAT-991', 'PW-BLADE-01', 'Low Pressure Turbine Blade (Rzeszów Fleet)', 'Turbines', 1250.00, 100),
('MAT-992', 'PW-CASE-05', 'Titanium Fan Case Enclosure', 'Casings', 8900.00, 15),
('MAT-993', 'PW-ROTR-09', 'High Pressure Compressor Shaft', 'Rotors', 5400.00, 25)
ON CONFLICT (material_id) DO NOTHING;

-- Seeding Work Centers
INSERT INTO sap_work_centers VALUES 
('WC-CNC01', 'High-Precision CNC Milling Center', 120),
('WC-LAS02', 'Laser Quality Inspection & Certification', 80),
('WC-ASM03', 'Final Engine Assembly Line', 160)
ON CONFLICT (wc_id) DO NOTHING;

-- Seeding Stock Inventory (MSEG)
INSERT INTO sap_mseg VALUES 
('MAT-991', 'WH-RZE01', 85, 40),
('MAT-992', 'WH-RZE01', 22, 10),
('MAT-993', 'WH-RZE02', 40, 15)
ON CONFLICT (material_id, warehouse_id) DO NOTHING;

-- Seeding Production Orders (AUFK - Exactly 25 rows)
INSERT INTO sap_aufk VALUES
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
('ORD-2026-016', 'MAT-991', 'WC-CNC01', 180, 0, 0, '2026-08-22', '2026-08-26', NULL, 0),
('ORD-2026-017', 'MAT-993', 'WC-LAS02', 30, 0, 0, '2026-08-23', '2026-08-29', NULL, 0),
('ORD-2026-018', 'MAT-992', 'WC-ASM03', 15, 0, 0, '2026-08-24', '2026-08-30', NULL, 0),
('ORD-2026-019', 'MAT-991', 'WC-ASM03', 95, 0, 0, '2026-08-25', '2026-08-31', NULL, 0),
('ORD-2026-020', 'MAT-993', 'WC-CNC01', 50, 0, 0, '2026-08-26', '2026-09-02', NULL, 0),
('ORD-2026-090', 'MAT-991', 'WC-CNC01', 140, 140, 0, '2026-07-25', '2026-07-29', '2026-07-29', 4),
('ORD-2026-091', 'MAT-992', 'WC-LAS02', 14, 11, 3, '2026-07-26', '2026-08-01', '2026-08-02', 13),
('ORD-2026-092', 'MAT-993', 'WC-ASM03', 28, 28, 0, '2026-07-27', '2026-08-02', '2026-08-02', 3),
('ORD-2026-093', 'MAT-991', 'WC-LAS02', 100, 95, 5, '2026-07-28', '2026-08-02', '2026-08-04', 7),
('ORD-2026-094', 'MAT-993', 'WC-CNC01', 40, 39, 1, '2026-07-29', '2026-08-05', '2026-08-05', 8)
ON CONFLICT (order_id) DO NOTHING;


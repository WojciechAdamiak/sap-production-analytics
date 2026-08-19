# 🏫 SAP Production Analytics Platform — Onboarding & Training Guide
*Standard Operating Procedure (SOP) and Knowledge Transfer Framework for Analytics Engineers*

Welcome to the team! As the platform architect and mentor, I have developed this onboarding blueprint to streamline your technical and business integration. This guide guarantees full operational autonomy within a 3-day deployment cycle, ensuring zero legacy knowledge gaps.

---

## 🗓️ 3-Day Technical Onboarding Plan

### 🔹 Day 1: Backend Architecture, Python ETL & Relational Integrity
**Objective:** Master the core data pipelines, database schema mappings, and performance indices.
* **Theoretical Framework**: Evaluation of raw SAP ERP data structures (`MARA`, `AUFK`, `MSEG`) mapped into an analytical PostgreSQL layer.
* **Practical Execution**: 
  1. Initialize the pipeline engine via terminal: `python generate_clean_data.py`.
  2. Inspect the data integrity handler safeguarding `None` constraints for uncompleted timeline runs.
  3. Audit query optimization layers inside `schema/07_performance_indexes.sql`.
* **Deliverable (Your Task)**: Introduce a mock testing attribute inside the Python array generator, modify the DDL schema in `01_init_tables.sql`, and run a successful database migration.

### 🔹 Day 2: BI Semantic Modeling & DAX Calculation Layers
**Objective:** Navigate the Power BI Star Schema layout and maintain explicit business calculation boundaries.
* **Theoretical Framework**: Enforcement of One-to-Many (`1` to `*`) relational cardinality and verification of single-directional cross-filtering parameters.
* **Practical Execution**:
  1. Launch the staging file: `dashboard/SAP_Production_Fulfillment_Dashboard.pbix`.
  2. Inspect the virtual container `_Measures` to map calculation execution paths (`DIVIDE`, `SUMX`, `RELATED`).
  3. Validate runtime time-intelligence boundaries utilizing the dynamic `Dim_Calendar` DAX script.
* **Deliverable (Your Task)**: Program an isolated DAX measure computing the mean financial scrap impact per unfulfilled production order.

### 🔹 Day 3: Business Risk Interpretation & Executive Presentation
**Objective:** Convert visual metrics into defensive actions and justify performance indicators to the steering committee.
* **Theoretical Framework**: Applied UX principles (The 5-Second KPI Rule) and operational risk thresholds for aerospace manufacturing.
* **Practical Execution**:
  1. Isolate the 13 underperforming production records (Fulfillment Index <= 95%) inside the core audit grid.
  2. Map out how a tight 3.66% manufacturing quality variance manifests as a heavy **\$162.70k** cash bleeding.
* **Deliverable (Your Task)**: Draft a 1-page executive summary (Executive Briefing) for the Chief Operating Officer based on active August scheduling bottlenecks.

---

## 📖 Data Dictionary & Governance Standards

To preserve structural reporting alignment across departments, any analytical modification must adhere to the following definitions:

* **Quality Rate % (Defect Metric)**: Context-evaluated row-level filter isolating conforming components against total processed volume. Always leverage internal data variables (`VAR`) to optimize memory cache:
  ```dax
  Quality Rate % = 
  VAR TotalGood = SUM('sap_aufk'[Quantity Produced])
  VAR TotalScrap = SUM('sap_aufk'[Quantity Scrapped])
  VAR TotalProcessed = TotalGood + TotalScrap
  RETURN DIVIDE(TotalGood, TotalProcessed, 0)
  ```
* **Total Scrap Loss Cost USD (Financial Waste Ledger)**: Primary fiscal damage tracking. Material valuations are dynamically linked via `RELATED` from the catalog table `sap_mara`. *Hardcoding pricing figures inside the fact grid is strictly forbidden.*

---

## 🛠️ Infrastructure Troubleshooting & FAQ

#### Q1: The automated ETL script throws a `ModuleNotFoundError: No module named 'pandas'`.
* **Mitigation**: Ensure your python virtual environment is initialized. Install required pipeline dependencies via terminal: `pip install pandas`.

#### Q2: The "Delayed Orders Count" card reports zero active issues despite existing timeline slippage.
* **Mitigation**: Verify that the time-series relationship linking `sap_aufk[actual_end_date]` to the `Dim_Calendar` table is active. The measure evaluates a strict baseline logical boundary condition: `[actual_end_date] > [planned_end_date]`.

---
*Framework maintained by: [Your Name and Surname]*

===============================================================================

# 🇵🇱 Polska Wersja Językowa (Polish Version)
*Przewodnik wdrożeniowy i plan szkoleniowy dla zespołu analityków*

## 🗓️ 3-Dniowy Plan Wdrożenia

### 🔹 Dzień 1: Backend, Potok ETL i Struktura Relacyjna (Inżynieria Danych)
* **Teoria**: Mapowanie struktur SAP ERP (`MARA`, `AUFK`, `MSEG`) na relacyjną bazę danych PostgreSQL.
* **Praktyka**: Uruchomienie skryptu Python `python generate_clean_data.py` oraz analiza indeksów B-Tree w pliku `schema/07_performance_indexes.sql`.
* **Zadanie**: Dodanie testowego atrybutu do skryptu Python i aktualizacja definicji DDL w bazie.

### 🔹 Dzień 2: Warstwa Semantyczna i Logika DAX (Modelowanie i Power BI)
* **Teoria**: Utrzymanie relacji Jeden do Wielu (`1` do `*`) i jednokierunkowego filtrowania danych.
* **Praktyka**: Analiza pliku `.pbix`, kontenera miar `_Measures` oraz kodu dynamicznego kalendarza `Dim_Calendar`.
* **Zadanie**: Stworzenie nowej miary obliczającej średni koszt odpadów na jedno zlecenie.

### 🔹 Dzień 3: Kontekst Biznesowy i Prezentacja Wyników (Zarządzanie Ryzykiem)
* **Teoria**: Zrozumienie wskaźników KPI i "Zasady 5 sekund" w raportowaniu dla zarządu.
* **Praktyka**: Analiza 13 opóźnionych zleceń produkcyjnych i interpretacja straty **\$162.70k**.
* **Zadanie**: Przygotowanie krótkiej notatki biznesowej (Executive Briefing) dla Dyrektora Operacyjnego.

---

## 📖 Słownik Danych i Standardy Obliczeń

* **Quality Rate % (Wskaźnik Jakości)**: Obliczany na poziomie kontekstu wiersza przy użyciu optymalnych zmiennych pamięci cache (`VAR/RETURN`).
* **Total Scrap Loss Cost USD (Koszt Strat Finansowych)**: Wartości cenowe są dynamicznie pobierane relacją `RELATED` ze słownika materiałów `sap_mara` – zakaz wpisywania cen na sztywno do tabeli faktów.

# Healthcare Data Analysis Project (SQL)
## Project Overview
This project involves a comprehensive analysis of a healthcare dataset containing 55,500 patient records. The goal was to transform raw, messy data into actionable insights regarding patient demographics, hospital stays, and billing trends.

## Technical Skills Applied
* **Data Cleaning:** Handled mixed-case string formatting and corrected date-of-birth/admission range errors.
* **ETL (Extract, Transform, Load):** Resolved schema mismatches during the import process in pgAdmin.
* **Advanced SQL:** Utilized Aggregate Functions, Grouping, Type Casting, and Data Transformation functions.

## Data Cleaning Process
Before analysis, I performed a rigorous cleaning process to ensure data integrity:
1. **Schema Optimization:** Initially imported date columns as `VARCHAR` to bypass regional formatting errors (`DD-MM-YYYY` vs `YYYY-MM-DD`).
2. **Type Casting:** Converted text-based dates into PostgreSQL `DATE` objects using the `TO_DATE` function.
3. **Text Standardization:** Used `INITCAP` and `LOWER` to fix inconsistent capitalization in patient names, ensuring a professional look for reporting.

## Key Insights Solved
* Calculated total patient volume and gender distribution.
* Identified the most prevalent medical conditions across the 55,500 records.
* Analyzed billing averages to identify high-cost treatment categories.

* /* HEALTHCARE DATA ANALYSIS REPORT
   Dataset Size: 55,500 Records
   Description: Data cleaning and exploration for hospital records.
*/

-- 1. Table Setup & Data Loading
DROP TABLE IF EXISTS healthcare_data;

CREATE TABLE healthcare_data (
    patient_name VARCHAR(150),
    age INT,
    gender VARCHAR(15),
    blood_type VARCHAR(10),
    medical_condition VARCHAR(100),
    date_of_admission VARCHAR(50), 
    doctor VARCHAR(150),
    hospital VARCHAR(200),
    insurance_provider VARCHAR(100),
    billing_amount DECIMAL(15, 2),
    room_number INT,
    admission_type VARCHAR(50),
    discharge_date VARCHAR(50),
    medication VARCHAR(100),
    test_results VARCHAR(50)
);

-- 2. Data Transformation (Cleaning Phase)
-- Converting text strings to proper DATE format
ALTER TABLE healthcare_data 
    ALTER COLUMN date_of_admission TYPE DATE 
    USING TO_DATE(date_of_admission, 'DD-MM-YYYY');

ALTER TABLE healthcare_data 
    ALTER COLUMN discharge_date TYPE DATE 
    USING TO_DATE(discharge_date, 'DD-MM-YYYY');

-- Standardizing Name Formatting (Proper Case)
UPDATE healthcare_data
SET patient_name = INITCAP(LOWER(patient_name));

-- 3. Exploratory Data Analysis (EDA)

-- View clean dataset
SELECT * FROM healthcare_data LIMIT 10;

-- Total unique patients
SELECT COUNT(DISTINCT patient_name) AS total_unique_patients 
FROM healthcare_data;

-- Patient distribution by Gender
SELECT 
    gender, 
    COUNT(*) AS patient_count 
FROM healthcare_data 
GROUP BY gender 
ORDER BY patient_count DESC;

-- Analysis of Medical Conditions
SELECT 
    medical_condition, 
    COUNT(*) AS total_cases 
FROM healthcare_data 
GROUP BY medical_condition 
ORDER BY total_cases DESC;

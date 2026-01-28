
drop table if exists healthcare_data

CREATE TABLE healthcare_data (
    patient_name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    blood_type VARCHAR(5),
    medical_condition VARCHAR(50),
    date_of_admission VARCHAR(20), -- text changed after that
    doctor VARCHAR(100),
    hospital VARCHAR(150),
    insurance_provider VARCHAR(50),
    billing_amount DECIMAL(15, 2),
    room_number INT,
    admission_type VARCHAR(20),
    discharge_date VARCHAR(20),    -- text changed after that
    medication VARCHAR(50),
    test_results VARCHAR(20)
);



-- date conversion
-- Convert both columns to real dates
ALTER TABLE healthcare_data 
ALTER COLUMN date_of_admission TYPE DATE 
USING TO_DATE(date_of_admission, 'DD-MM-YYYY');

ALTER TABLE healthcare_data 
ALTER COLUMN discharge_date TYPE DATE 
USING TO_DATE(discharge_date, 'DD-MM-YYYY');





-- data explorataion
select  * from healthcare_data;
-- update the names in the right format
UPDATE healthcare_data
SET patient_name = INITCAP(LOWER(patient_name));
-- total patitent 
select count (distinct (patient_name)) from healthcare_data;
--gender basis dividation
select gender, count(distinct(patient_name)) from healthcare_data group by gender order by 2 desc;
--total disease category we have
select  medical_condition , count(distinct(patient_name))   from healthcare_data group by 1 order by 2 desc;
--total doctors we have
select  doctor, count(distinct(patient_name))  from healthcare_data group by 1 order by 2 desc;
-- total hospital we have
select distinct(hospital) , count(distinct(patient_name)) from healthcare_data group by 1 order by 2 desc;




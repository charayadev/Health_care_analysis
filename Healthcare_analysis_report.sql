
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

-- Begning with the problems

/*-----
----
Part 1: Getting to Know the Data
----
----*/

--Count how many total patients are in the list. Also, find the youngest and oldest patient age.
SELECT count(distinct(patient_name)) as total_Patient, min(age) as minimum_age, max(age) as maximum_age from HEALTHCARE_DATA;

--Show a list of all the different medical conditions (like Cancer or Diabetes) and how many patients have each one.
select medical_condition, count(distinct(patient_name)) as total_Patient  from healthcare_data group by 1 order 
by 2 desc;

--Which hospitals appear most often in this data? Show the top 5.
select hospital, count(distinct(patient_name)) as total_Patient  from healthcare_data group by 1 order 
by 2 desc limit 5;


/*-----
----
Part 2: Looking at Money and Insurance
----
----*/ 

--On average, which medical condition costs the most money to treat?
select medical_condition, round(avg(billing_amount),2) as avgerage from healthcare_data group by 1 order by 2 desc;

--Which insurance company (like Aetna or Medicare) has paid the most total "Billing Amount"?
select insurance_provider, sum(billing_amount) as total_paid from healthcare_data group by 1 order by 2 desc;


--For patients with "Diabetes," what is the most common medicine they are given?
select medication, count(distinct(patient_name)) as total_patient from healthcare_data
where medical_condition = 'Diabetes' group by 1 order by 2 desc;

/*-----
----
Part 3: Looking at Money and Insurance
----
----*/ 

--Figure out how many days each patient spent in the hospital (Discharge Date minus Admission Date). What is the average stay for all patients?















CREATE database Healthcare_Management;

USE Healthcare_Management;

CREATE table diabetic_data(
encounter_id BIGINT NOT NULL,
patient_nbr BIGINT NOT NULL,
race VARCHAR(30),
gender VARCHAR(20),
age VARCHAR(20),
weight VARCHAR(20),

admission_type_id INT,
discharge_disposition_id INT,
admission_source_id INT,
time_in_hospital INT,

payer_code VARCHAR(20),
medical_specialty VARCHAR(100),

num_lab_procedures INT,
num_proceuders INT,
num_medications INT,

number_outpatient INT,
number_emergency INT,
number_inpatient INT,

diag_1 VARCHAR(20),
diag_2 VARCHAR(20),
diag_3 VARCHAR(20),

number_diagnoses INT,

max_glu_serum VARCHAR(20),
A1Cresult VARCHAR(20),

metformin VARCHAR(20),
repaglinide VARCHAR(20),
nateglinid VARCHAR(20),
chlorpropamide VARCHAR(20),
glimepiride VARCHAR(20),
acetohexamide VARCHAR(20),
glipizide VARCHAR(20),
glyburide VARCHAR(20),
tolbutamide VARCHAR(20),
pioglitazone VARCHAR(20),
rosiglitazone VARCHAR(20),
acarbose VARCHAR(20),
miglitol VARCHAR(20),
troglitazone VARCHAR(20),
tolazamide VARCHAR(20),
examide VARCHAR(20),
citogliptone VARCHAR(20),
insulin VARCHAR(20),

`glyburide-metformin` VARCHAR(20),
`glipizide-metformin` VARCHAR(20),
`metforminn-rosiglitazone` VARCHAR(20),
`metformin-pioglitazone` VARCHAR(20),

`change` VARCHAR(20),
diabeteMed VARCHAR(20),

readmitted VARCHAR(20),
readmitted_30d TINYINT NOT NULL
);

SELECT * FROM diabetic_data;

DESCRIBE diabetic_data;

SELECT COUNT(*) as row_count
FROM diabetic_data;

SHOW variables LIKE 'local_infile';

SET GLOBAL local_infile = 1; 

ALTER TABLE diabetic_data
ADD COLUMN `glimepiride-pioglitazone` VARCHAR(20)
AFTER `glipizide-metformin`;

LOAD DATA LOCAL INFILE 'C:\\Users\\sasik\\Downloads\\IIT Guwahati\\Capstone Project 2\\Healthcare_Management_Datasets\\diabetic_data _cleaned_.csv'
INTO TABLE diabetic_data
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    encounter_id,
    patient_nbr,
    race,
    gender,
    age,
    weight,
    admission_type_id,
    discharge_disposition_id,
    admission_source_id,
    time_in_hospital,
    payer_code,
    medical_specialty,
    num_lab_procedures,
    num_proceuders,
    num_medications,
    number_outpatient,
    number_emergency,
    number_inpatient,
    diag_1,
    diag_2,
    diag_3,
    number_diagnoses,
    max_glu_serum,
    A1Cresult,
    metformin,
    repaglinide,
    nateglinid,
    chlorpropamide,
    glimepiride,
    acetohexamide,
    glipizide,
    glyburide,
    tolbutamide,
    pioglitazone,
    rosiglitazone,
    acarbose,
    miglitol,
    troglitazone,
    tolazamide,
    examide,
    citogliptone,
    insulin,
    `glyburide-metformin`,
    `glipizide-metformin`,
    `glimepiride-pioglitazone`,
    `metforminn-rosiglitazone`,
    `metformin-pioglitazone`,
    `change`,
    diabeteMed,
    readmitted,
    readmitted_30d
);

SELECT * FROM diabetic_data;

DESCRIBE diabetic_data;

-- Check duplicate encounters
SELECT
	COUNT(*) AS total_rows,
    COUNT(DISTINCT encounter_id) AS unique_encounters
FROM diabetic_data;

-- Validate the 30-day target
SELECT
	readmitted_30d,
	COUNT(readmitted_30d) AS encounter_count
FROM diabetic_data
GROUP BY readmitted_30d
ORDER BY readmitted_30d;

-- Calculate the SQL 30-day readmission rate
SELECT
	COUNT(*) AS total_encounters,
    SUM(readmitted_30d) AS readmission_30d,
    ROUND(
		SUM(readmitted_30d) * 100 / COUNT(*),2) AS readmission_rate_pct
FROM diabetic_data;

-- Check important category feild
SELECT 
	race,
    COUNT(*) AS encounter_count
FROM diabetic_data
GROUP BY race
ORDER BY encounter_count desc;

-- Check Missing Values
SELECT
	SUM(race IS NULL) AS race_nulls,
    SUM(payer_code IS NULL) AS Payer_nulls,
    SUM(medical_specialty IS NULL) AS speciality_nulls,
    SUM(diag_1 IS NULL) AS diag1_nulls,
    SUM(diag_2 IS NULL) AS diag2_nulls,
    SUM(diag_3 IS NULL) AS diag3_nulls,
    SUM(max_glu_serum IS NULL) AS max_glu_nulls,
    SUM(A1Cresult IS NULL) AS alc_nulls
FROm diabetic_data;

-- Total Hospital Encounters
SELECT 
	COUNT(*) AS total_encounters
FROM diabetic_data;

-- Most frequently recorded diagnoses among hospital encounters
SELECT 
	diagnosis_code,
    COUNT(*) AS diagnosis_frequency
FROM(
	SELECT diag_1 AS diagnosis_code
    FROM diabetic_data
    WHERE diag_1 IS NOT NULL 
		AND TRIM(diag_1) <> ''
    
    UNION ALL 
    
    SELECT diag_2 AS diagnosis_code
    FROM diabetic_data
    WHERE diag_2 IS NOT NULL
		AND TRIM(diag_2) <> ''
    
    UNION ALL 
    
    SELECT diag_3 AS diagnosis_code
    FROM diabetic_data
    WHERE diag_2 IS NOT NULL
		AND TRIM(diag_3) <> ''
) AS all_diagnosis
GROUP BY diagnosis_code
ORDER BY diagnosis_frequency DESC
LIMIT 10; 

-- Calculate the average length of hospital stay for each admission type
SELECT 
	CASE admission_type_id 
    WHEN 1 THEN 'Emergency'
    WHEN 2 THEN 'Urgent'
    WHEN 3 THEN 'Elective'
    WHEN 4 THEN 'Newborn'
    WHEN 5 THEN 'Not Available'
    WHEN 6 THEN 'NULL'
    WHEN 7 THEN 'Trauma Center'
    WHEN 8 THEN 'Not Mapped'
    ELSE 'Unknown'
END AS admission_type,
    COUNT(*) AS encounter_count,
    ROUND(AVG(time_in_hospital),2) AS avg_length_of_stay
FROM diabetic_data
GROUP BY admission_type_id
ORDER BY admission_type_id;

-- Number of hospital encounters resulted in a 30-day readmission, and what percentage of all encounters do they represent?
SELECT
	SUM(readmitted_30d) AS readmitted_30d_count,
    COUNT(*) AS total_encounters,
    ROUND(
		SUM(readmitted_30d) * 100.0 / COUNT(*),
        2) AS readmission_rate
FROM diabetic_data;


-- Hospital encounters distribution across different age groups
SELECT 
	age AS age_group,
    COUNT(*) AS encounter_count
FROM diabetic_data
GROUP BY age
ORDER BY age;
    
-- Most frequently performed procedures during Hospital encounters    
SELECT 
	num_proceuders,
    COUNT(*) AS encounter_count
FROM diabetic_data
GROUP BY num_proceuders
ORDER BY num_proceuders;

-- Average number of medications prescribed vary across age groups
SELECT 
	age AS age_group,
    COUNT(*) AS encounter_count,
    ROUND(AVG(num_medications),2) AS avg_medications
FROM diabetic_data
GROUP BY age
ORDER BY age;

-- The distribution of readmission rates vary across different payer codes
SELECT
	payer_code,
    COUNT(*) AS total_encounter,
    SUM(readmitted_30d) AS readmitted_30d_count,
    ROUND(
		SUM(readmitted_30d) * 100.0 / COUNT(*),
        2
        ) AS readmission_rate
FROM diabetic_data
GROUP BY payer_code
ORDER BY readmission_rate DESC;

-- Phase 2
-- Unique Patients vs Hospital Encounters
SELECT 
	COUNT(DISTINCT patient_nbr) AS unique_patients,
    COUNT(*) AS total_encounters,
    ROUND(
		COUNT(*) * 1.0 / COUNT(DISTINCT patient_nbr),2) AS encounter_per_patient
FROM diabetic_data;
    
-- The Proportion of Hospital encounters involved an emergency visits
SELECT 
	COUNT(*) AS total_encounters,
    SUM(CASE 
			WHEN number_emergency > 0 THEN 1 
            ELSE 0 
            END) AS encountes_with_emergency_history,
	ROUND(
		SUM(CASE 
				WHEN number_emergency > 0 THEN 1
                ELSE 0 
			END) * 100.0 / COUNT(*), 2)
		AS emergency_utilization_rate
	FROM diabetic_data;

-- The Proportion of hospital encounters involved patients with a history of prior inpatient visits

SELECT 
	COUNT(*) AS total_encounters,
    SUM(
		CASE WHEN number_inpatient > 0 THEN 1 
			ELSE 0
		END
        ) AS encounter_with_inpatient_history,
	ROUND(
		SUM(
        CASE WHEN number_inpatient > 0 THEn 1
			ELSE 0
            END) * 100.0 / COUNT(*), 2 ) AS inpatient_utilization_rate
	FROM diabetic_data;
    
SELECT * FROM diabetic_data;

-- Total diagnosis codes are recorded per hospital encounter
SELECT 
	diagnosis_count,
    COUNT(*) AS encounter_count
    FROM(
    SELECT
		encounter_id,
        ( 
			CASE 
				WHEN diag_1 IS NOT NULL
					 AND TRIM(diag_1) <> ''
                     AND TRIM(diag_1) <> '?' THEN 1 
				ELSE 0
			END 
            + 
            CASE 
				WHEN diag_2 IS NOT NULL
					 AND TRIM(diag_2) <> ''
                     AND TRIM(diag_2) <> '?' THEN 1
				ELSE 0
			END
            + 
            CASE 
				WHEN diag_3 IS NOT NULL
					 AND TRIM(diag_3) <> ''
                     AND TRIM(diag_3) <> '?' THEN 1
				ELSE 0
			END
		) AS diagnosis_count
	FROM diabetic_data
) AS encounter_diagnosis
GROUP BY diagnosis_count
ORDER BY diagnosis_count;

-- Medication Distribution Burden
SELECT 
	num_medications,
    COUNT(*) AS encounter_count
FROM diabetic_data
GROUP BY num_medications
ORDER BY num_medications;

-- The 30-day readmission rate vary across different age groups

SELECT 
	age As age_group,
    COUNT(*) AS total_encounter,
    SUM(readmitted_30d) AS readmitted_30d_count,
    ROUND(
		SUM(readmitted_30d)*100.0 / COUNT(*), 2) AS readmitted_rate
FROM diabetic_data
GROUP BY age
ORDER BY age;

-- 30-day readmitted vary by Gender
SELECT 
	gender AS gender_group,
    COUNT(*) AS encounters_count,
    SUM(readmitted_30d) AS readmitted_30d_count,
    ROUND(
		SUM(readmitted_30d)* 100.0 / COUNT(*), 2) AS readmitted_rate
FROM diabetic_data
GROUP BY gender
ORDER BY readmitted_rate DESC;

-- The 30-day readmission rate vary across different racial groups
SELECT 
	race AS race_group,
    COUNT(*) AS encounter_count,
    SUM(readmitted_30d) AS readmitted_30d_count,
    ROUND(
		SUM(readmitted_30d)*100.0 / COUNT(*),2) AS readmitted_rate
FROM diabetic_data
GROUP BY race
ORDER BY readmitted_rate DESC;

-- The 30-day readmission rate vary across different admission types
SELECT 
	CASE admission_type_id
    WHEN 1 THEN 'Emergency'
    WHEN 2 THEN 'Urgent'
    WHEN 3 THEN 'Elective'
    WHEN 4 THEN 'Newborn'
    WHEN 5 THEN 'Not Availabel'
    WHEN 6 THEN 'Unknown'
    WHEN 7 THEN 'Trauma Center'
    WHEN 8 THEN 'Not Mapped'
    ELSE 'Unknown'
END AS admission_type,
COUNT(*) AS total_encounters,
SUM(readmitted_30d) AS readmitted_30d_count,
ROUND(
	SUM(readmitted_30d) * 100.0 / COUNT(*), 2) 
    AS readmitted_30d_rate
FROM diabetic_data
GROUP BY admission_type
ORDER BY readmitted_30d_rate;

-- the 30-day readmission rate vary across different payer codes
SELECT
	payer_code,
    COUNT(*) AS total_encounters,
    SUM(readmitted_30d) AS readmitted_30d_count,
    ROUND(
		SUM(readmitted_30d) * 100.0 / COUNT(*), 2) AS readmitted_rate
FROM diabetic_data
GROUP BY payer_code
ORDER BY readmitted_rate;

-- 30-day readmission rate vary across different medical specialties
SELECT 
	medical_specialty,
    COUNT(*) AS total_encounters,
    SUM(readmitted_30d) AS readmitted_30d_count,
    ROUND(SUM(readmitted_30d) * 100.0 / COUNT(*), 2) 
    AS readmitted_30d_rate
FROM diabetic_data
GROUP BY medical_specialty
ORDER BY readmitted_30d_rate;

-- 30-day readmission rate vary across different diagnoses
SELECT 
	diagnosis_code,
    COUNT(*) As total_encounters,
    SUM(readmitted_30d) AS readmitted_30d_count,
    ROUND(
		SUM(readmitted_30d)*100.0 / COUNT(*),
        2) AS readmission_rate
FROM(
	SELECT DISTINCT
			encounter_id,
            diag_1 as diagnosis_code,
            readmitted_30d
	FROM diabetic_data
    WHERE diag_1 IS NOT NULL
		AND TRIM(diag_1) <> ''
        AND TRIm(diag_1) <> '?'
        
	UNION
    
    SELECT DISTINCT 
		encounter_id,
		diag_2 AS diagnosis_code,
		readmitted_30d
	FROM diabetic_data
    WHERE diag_2 IS NOT NULL
		AND TRIM(diag_2) <> ''
        AND TRIM(diag_2) <> '?'
        
	UNION
    
    SELECT DISTINCT
		encounter_id,
        diag_3 AS diagnosis_code,
        readmitted_30d
	FROM diabetic_data
    WHERE diag_3 IS NOT NULL
    AND TRIM(diag_3) <> ''
    AND TRIM(diag_3) <> '?'
)AS diagnosis_encounter

GROUP BY diagnosis_code
ORDER BY readmission_rate DESC;
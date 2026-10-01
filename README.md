# Healthcare Management: Patient Readmission Prediction

## Project Overview

This project analyzes hospital encounter data from diabetic patients to understand patterns associated with 30-day hospital readmission.

The project is designed for **ReadmitGuard**, a hypothetical healthcare analytics initiative that aims to help hospitals identify patients who may require additional care coordination after discharge.

The analysis combines Excel, SQL, Python, and Tableau to create a complete healthcare analytics workflow, from data profiling and database analysis to exploratory analysis, dashboard development, and future predictive modeling.

> **Note:** The current phase focuses on descriptive and exploratory analytics. Predictive machine learning will be implemented in a subsequent phase.

---

## Business Problem

Hospital readmissions within 30 days of discharge can increase healthcare costs, create additional pressure on hospital resources, and indicate the need for improved post-discharge care coordination.

Healthcare organizations need to understand:

- Which patient and encounter characteristics are associated with readmission?
- How do admission sources and discharge destinations vary?
- What patterns exist in prior healthcare utilization?
- Which clinical and treatment-related variables may be useful for future risk modeling?
- How can analytical findings support targeted intervention planning?

This project explores these questions using historical hospital encounter data.

---

## Project Objectives

The primary objectives of this project are to:

1. Define a binary target for 30-day readmission.
2. Assess dataset structure, data quality, missing values, and duplicate records.
3. Analyze demographic, admission, clinical, treatment, and utilization characteristics.
4. Group ICD-9 diagnosis codes into broader clinical categories.
5. Explore patterns associated with 30-day readmission.
6. Perform SQL-based healthcare KPI and segmentation analysis.
7. Conduct exploratory data analysis using Python.
8. Build an interactive Tableau dashboard for healthcare stakeholders.
9. Prepare the dataset for future machine learning-based readmission prediction.
10. Identify relevant business and clinical insights while avoiding causal overinterpretation.

---

## Dataset Description

### Dataset Name

**Diabetes 130-US Hospitals for Years 1999–2008**

### Source

UCI Machine Learning Repository:

https://archive.ics.uci.edu/dataset/296/diabetes-130-us-hospitals-for-years-1999-2008

### Dataset Characteristics

| Attribute | Description |
|---|---|
| Original dataset | Diabetes 130-US Hospitals for Years 1999–2008 |
| Number of encounters | 101,766 |
| Number of variables in project dataset | 51 |
| Number of hospitals | 130 US hospitals / integrated delivery networks |
| Time period | 1999–2008 |
| Unit of observation | Hospital encounter |
| Domain | Healthcare / Clinical Outcome Analytics |
| Primary outcome | 30-day readmission |

The dataset contains information related to patient demographics, hospital admission and discharge details, diagnoses, procedures, medications, laboratory procedures, and previous healthcare utilization.

> Each row represents a hospital encounter. Therefore, encounter-level counts and rates should not automatically be interpreted as unique-patient-level measures.

---

## Target Variable

The original dataset contains the `readmitted` variable with three categories:

- `<30`: Readmitted within 30 days
- `>30`: Readmitted after 30 days
- `NO`: Not readmitted

For this project, the target was converted into a binary variable named:

### `readmitted_30d`

| Original Value | Binary Value | Meaning |
|---|---:|---|
| `<30` | 1 | Readmitted within 30 days |
| `>30` | 0 | Not readmitted within 30 days |
| `NO` | 0 | Not readmitted within 30 days |

### Target Distribution

| Target | Encounter Count | Percentage |
|---|---:|---:|
| No 30-day readmission | 90,409 | 88.84% |
| 30-day readmission | 11,357 | 11.16% |
| **Total** | **101,766** | **100.00%** |

The target is imbalanced, with 30-day readmissions representing approximately 11.16% of encounters.

This imbalance will be considered during future predictive modeling and evaluation.

---

## Technology Stack

| Tool | Purpose |
|---|---|
| Microsoft Excel | Initial data profiling, summary tables, and preliminary visualizations |
| MySQL | Data storage, transformation, aggregation, and analytical queries |
| Python | Data cleaning, exploratory data analysis, statistical summaries, and visualization |
| Pandas | Data manipulation and analysis |
| NumPy | Numerical computation |
| Matplotlib | Data visualization |
| Seaborn | Statistical visualization |
| Tableau | Interactive dashboard development |
| Jupyter Notebook | Python analysis documentation |
| VS Code | Development environment |

---

## Project Workflow

The project follows the workflow below:

```text
Raw Dataset
    |
    v
Data Cleaning and Preparation
    |
    v
Excel Data Profiling
    |
    v
SQL Database Loading and Analysis
    |
    v
Python Exploratory Data Analysis
    |
    v
Tableau Dashboard Development
    |
    v
Feature Engineering
    |
    v
Machine Learning Readmission Prediction
```

---

## Data Quality and Preprocessing

The dataset was examined for:

- Dataset dimensions
- Data types
- Missing values
- Duplicate records
- Unique patient counts
- Encounter counts
- Categorical value distributions
- Numerical feature distributions
- Invalid or placeholder values

### Missing Values

The cleaned dataset contains missing values in selected clinical and diagnosis-related fields.

| Feature | Missing Count | Missing Percentage |
|---|---:|---:|
| `weight` | 98,569 | 96.86% |
| `max_glu_serum` | 96,420 | 94.75% |
| `A1Cresult` | 84,748 | 83.28% |
| `diag_3` | 1,423 | 1.40% |
| `diag_2` | 358 | 0.35% |
| `diag_1` | 21 | 0.02% |

The symbol `?` was treated as a missing-value indicator during data preparation. In the cleaned dataset, missing values are represented appropriately for analysis.

### Duplicate Records

- Duplicate records identified: **0**

### Patient and Encounter Counts

| Metric | Value |
|---|---:|
| Unique patients | 71,518 |
| Total encounters | 101,766 |

Because patients may have multiple encounters, the dataset contains more encounters than unique patients.

---

## Exploratory Data Analysis

Python was used to analyze numerical, categorical, clinical, treatment, and utilization-related variables.

### Numerical Features Analyzed

- `time_in_hospital`
- `num_lab_procedures`
- `num_procedures`
- `num_medications`
- `number_outpatient`
- `number_emergency`
- `number_inpatient`
- `number_diagnoses`

### Categorical Features Analyzed

- Race
- Gender
- Age group
- Admission type
- Admission source
- Discharge disposition
- Medication change
- Primary diagnosis category

---

## Diagnosis Categorization

The primary diagnosis variable contains ICD-9 diagnosis codes. To improve interpretability, the codes were grouped into broader clinical categories.

The categories include:

- Circulatory
- Respiratory
- Digestive
- Endocrine
- Genitourinary
- Musculoskeletal
- Neoplasms
- Injury
- Supplementary Factors
- External Causes
- Other
- Unknown

### Primary Diagnosis Distribution

| Diagnosis Category | Encounter Count |
|---|---:|
| Circulatory | 30,437 |
| Other | 16,566 |
| Respiratory | 14,423 |
| Digestive | 9,475 |
| Endocrine | 8,757 |
| Injury | 6,974 |
| Genitourinary | 5,078 |
| Musculoskeletal | 4,957 |
| Neoplasms | 3,433 |
| Supplementary Factors | 1,644 |
| Unknown | 21 |
| External Causes | 1 |

Circulatory conditions were the most common primary diagnosis category in the dataset.

These categories describe diagnosis distribution and should not be interpreted as independent causal determinants of readmission.

---

## Key Exploratory Findings

### Demographic Findings

- Caucasian encounters represented the largest racial group.
- Female encounters were slightly more common than male encounters.
- Readmission rates varied across age groups.
- Small age groups should be interpreted cautiously because their rates are based on fewer observations.

### Admission Source Findings

The most common admission sources were:

| Admission Source | Encounter Count | Percentage |
|---|---:|---:|
| Emergency Room | 57,494 | 56.50% |
| Physician Referral | 29,565 | 29.05% |
| Unknown | 6,781 | 6.66% |
| Transfer from a Hospital | 3,187 | 3.13% |
| Transfer from Healthcare Facility | 2,264 | 2.22% |

Emergency Room admissions and Physician Referrals together accounted for approximately 85.55% of all encounters.

### Discharge Disposition Findings

Discharge to home was the most common discharge disposition, followed by discharge to skilled nursing facilities and home with home health services.

This indicates that most encounters ended in home or post-acute care settings, although several other dispositions were also present.

### Medication Findings

- Mean number of medications: approximately 16.02
- Median number of medications: 15
- Encounters without medication change: approximately 53.8%
- Encounters with medication change: approximately 46.2%

The medication count distribution was right-skewed, indicating that some encounters involved substantially higher medication counts.

### Correlation Findings

The strongest observed numerical relationships included:

- `time_in_hospital` and `num_medications`
- `num_procedures` and `num_medications`
- `time_in_hospital` and `num_lab_procedures`
- `number_emergency` and `number_inpatient`

These are descriptive associations. Correlation does not establish causation.

---

## Outlier Analysis

The Interquartile Range (IQR) method and boxplots were used to identify potential outliers in numerical variables.

The highest proportions of statistically identified outliers were observed in:

- `number_outpatient`
- `number_emergency`
- `number_inpatient`

These variables are highly right-skewed because most encounters have zero prior healthcare visits, while a smaller group has multiple previous visits.

The potential outliers were retained because they may represent genuine high healthcare utilization or clinical complexity rather than data-entry errors.

---

## SQL Analysis

MySQL was used to load the cleaned dataset and perform healthcare-focused analytical queries.

The SQL analysis included:

- Total encounters
- Unique patient counts
- 30-day readmission rate
- Average length of stay
- Emergency utilization
- Inpatient utilization
- Outpatient utilization
- Medication burden
- Procedure counts
- Readmission by age
- Readmission by gender
- Readmission by race
- Readmission by admission type
- Readmission by payer category
- Readmission by medical specialty
- Readmission by diagnosis

### Main SQL KPI

| KPI | Value |
|---|---:|
| Total encounters | 101,766 |
| Unique patients | 71,518 |
| 30-day readmission rate | 11.16% |

The SQL analysis provides an aggregated view of healthcare utilization and readmission patterns.

---

## Python Analysis

Python was used for:

- Data loading
- Data validation
- Missing-value assessment
- Duplicate checking
- Descriptive statistics
- Skewness analysis
- Categorical distributions
- Readmission analysis
- Correlation analysis
- Medication analysis
- Diagnosis categorization
- Outlier detection
- Data visualization

The Python analysis is documented in:

```text
notebooks/healthcare_eda.ipynb
```

---

## Tableau Dashboard

An interactive Tableau dashboard will be developed to communicate the main findings to healthcare stakeholders.

The planned dashboard will include:

- Total encounters
- Unique patients
- 30-day readmission rate
- Readmission distribution
- Age-group analysis
- Admission source distribution
- Discharge disposition distribution
- Diagnosis category distribution
- Emergency and inpatient utilization
- Demographic breakdowns
- Interactive filters

The dashboard is intended to support exploratory analysis and healthcare management decision-making.

> The dashboard will present descriptive patterns and should not be interpreted as a clinical decision-support system until a validated predictive model and appropriate clinical governance are established.

---

## Machine Learning: Planned Next Phase

The next phase will focus on developing a predictive model for 30-day readmission.

Planned activities include:

1. Feature engineering
2. Clinical diagnosis categorization
3. Handling missing values
4. Encoding categorical variables
5. Checking for data leakage
6. Train-test splitting
7. Model development
8. Class imbalance handling
9. Model evaluation
10. Threshold analysis
11. Model interpretation

Potential models include:

- Logistic Regression
- XGBoost

Because the positive class represents only 11.16% of encounters, model evaluation will focus on metrics such as:

- Recall
- Precision
- F1-score
- PR-AUC
- Confusion Matrix
- ROC-AUC
- Calibration

Accuracy alone will not be considered sufficient for evaluating the model.

---

## Data Leakage Considerations

A key requirement for future modeling is to ensure that all predictive features would be available at the appropriate point in the care process.

Features that may represent information recorded after discharge or after the readmission outcome must be carefully reviewed before inclusion.

The project will distinguish between:

- Variables available before or during the index encounter
- Variables recorded after discharge
- Variables that may indirectly reveal the readmission outcome

This is essential to ensure that the model reflects realistic prediction conditions.

---

## Business Value

The project can support healthcare organizations by helping them:

- Understand readmission patterns
- Identify important utilization characteristics
- Segment encounters by demographic and clinical attributes
- Monitor admission and discharge patterns
- Prioritize future care-coordination analysis
- Prepare for risk-stratification modeling
- Support data-driven resource planning

The project is intended to support analytical decision-making and does not replace clinical judgment.

---

## Project Structure

```text
Healthcare_Management/
│
├── data/
│   └── diabetic_data_cleaned.csv
│
├── notebooks/
│   └── healthcare_eda.ipynb
│
├── sql/
│   ├── SQL_Tasks.sql
│   └── Healthcare_Readmission_SQL_Report_To_Date.docx
│
├── reports/
│   └── Healthcare_Readmission_Excel_EDA_Report.docx
│
├── dashboards/
│   └── Tableau dashboard files
│
├── images/
│   └── EDA charts and dashboard images
│
├── README.md
│
└── requirements.txt
```

---

## Limitations

The project has several limitations:

1. The dataset represents historical encounters from 1999–2008 and may not reflect current healthcare practices.
2. The dataset is encounter-level and may contain multiple encounters for the same patient.
3. Several variables contain substantial missingness.
4. Some categorical fields contain unknown or unmapped values.
5. Medical specialty contains a large unknown category.
6. Diagnosis categories are broad groupings of ICD-9 codes.
7. Exploratory findings are unadjusted associations.
8. The analysis does not establish causation.
9. The dataset does not contain all clinical, socioeconomic, or post-discharge care information.
10. A predictive model would require independent validation before real-world deployment.

---

## Future Improvements

Potential future improvements include:

- Develop and validate machine learning models.
- Apply patient-level train-test splitting where appropriate.
- Investigate temporal validation.
- Perform feature selection.
- Evaluate model calibration.
- Use explainability techniques such as SHAP.
- Analyze subgroup performance.
- Assess fairness across demographic groups.
- Incorporate more recent clinical data.
- Integrate post-discharge information.
- Validate the model with clinical stakeholders.
- Develop monitoring procedures for model drift.

---

## Author

**Sasikanth Chintada**

### Areas of Interest

- Healthcare Analytics
- Risk Analytics
- Data Analysis
- Econometrics
- SQL
- Python
- Business Intelligence
- Machine Learning

---
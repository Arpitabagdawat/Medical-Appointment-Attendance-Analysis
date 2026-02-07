# 🏥 Medical Appointment Attendance Analysis  
**End-to-End Data Analytics & Machine Learning Project**

> An end-to-end project to analyze why patients miss medical appointments (no-shows) using **Python, SQL (PostgreSQL), Power BI, and Machine Learning**.

---

## 📌 1. Project Objective  
The goal of this project is to understand and predict **medical appointment no-shows**.  
We aim to answer business questions like:

- Do SMS reminders reduce no-show rate?
- Does longer waiting time increase no-shows?
- Do health conditions (Diabetes, Alcoholism) impact attendance?
- Which age group misses appointments the most?

---

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Medical Appointment No Shows](https://www.kaggle.com/datasets/joniarroba/noshowappointments)

**Description:**  
This dataset contains patient and appointment information to analyze attendance behavior.

**Main Columns:**  
- `Gender`, `Age`, `Neighbourhood`  
- `Scholarship`, `Hipertension`, `Diabetes`, `Alcoholism`  
- `SMS_received`  
- `ScheduledDay`, `AppointmentDay`, `WaitingDays`  
- `No_show` (Target variable: 1 = No-show, 0 = Showed up)

---

## 🛠️ 3. Tech Stack  
- **Python (Pandas, NumPy, Matplotlib, Seaborn)** – Data cleaning & EDA  
- **Jupyter Notebook** – Data analysis workflow  
- **PostgreSQL (SQL)** – Business queries & insights  
- **Power BI** – Interactive dashboard  
- **Machine Learning (Scikit-learn)** – No-show prediction  
- **GitHub** – Project hosting & portfolio  

---

## 🔄 4. End-to-End Workflow  

1️⃣ Data Cleaning & Feature Engineering (Python)  
2️⃣ Exploratory Data Analysis (EDA)  
3️⃣ Export Cleaned Data to CSV  
4️⃣ Load Data into PostgreSQL  
5️⃣ SQL Analysis (Business Questions)  
6️⃣ Power BI Dashboard  
7️⃣ Machine Learning Model (Prediction)

---

## 🧹 5. Data Cleaning & Feature Engineering (Python)  

Performed in Jupyter Notebook:

- Removed invalid ages (Age < 1)  
- Removed negative waiting days  
- Converted No-show into binary (0/1)  
- Created `WaitingDays` column  
- Saved cleaned data as: ```python
df.to_csv("cleaned_medical_appointments.csv", index=False)


## 🗄️ 6. SQL Analysis (PostgreSQL)

## Schema

```sql
-- DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (
    PatientId TEXT,
    AppointmentID BIGINT,
    Gender VARCHAR(10),
    ScheduledDay TIMESTAMP,
    AppointmentDay TIMESTAMP,
    Age INT,
    Neighbourhood TEXT,
    Scholarship INT,
    Hipertension INT,
    Diabetes INT,
    Alcoholism INT,
    Handcap INT,
    SMS_received INT,
    No_show INT,
    WaitingDays INT
);
```

## Exploratory SQL Queries

### 1. Show the total number of male and female patients.

```sql
SELECT Gender, COUNT(*) AS total_patients
FROM appointments
GROUP BY Gender;
```

### 2. Show how many appointments were a no_show and how many were not.

```sql
SELECT No_show, COUNT(*) AS total_appointments
FROM appointments
GROUP BY No_show
ORDER BY total_appointments DESC;
```

### 3. Show the average waiting days for no-show vs show-up appointments.

```sql
SELECT No_show, AVG(WaitingDays) AS avg_waiting_days
FROM appointments
GROUP BY No_show;
```

### 4. Show the no-show rate (percentage) by gender.

```sql
SELECT 
    Gender,
    ROUND(100.0 * SUM(CASE WHEN No_show = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS no_show_rate_percent
FROM appointments
GROUP BY Gender;
```

### 5. Show the average waiting days by age group:
 #### 0–18
 #### 19–35
 ####  36–60
 #### 60+
   
```sql
SELECT 
    CASE 
        WHEN Age BETWEEN 0 AND 18 THEN '0-18'
        WHEN Age BETWEEN 19 AND 35 THEN '19-35'
        WHEN Age BETWEEN 36 AND 60 THEN '36-60'
        ELSE '60+' 
    END AS age_group,
    ROUND(AVG(WaitingDays), 2) AS avg_waiting_days
FROM appointments
GROUP BY age_group
ORDER BY age_group;
```

### 6. Show the top 5 neighbourhoods with the highest no-show rate.

```sql
SELECT 
    Neighbourhood,
    ROUND(100.0 * SUM(CASE WHEN No_show = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS no_show_rate_percent
FROM appointments
GROUP BY Neighbourhood
ORDER BY no_show_rate_percent DESC
LIMIT 5;
```

### 7. Show the effect of SMS reminders: compare no-show rate for patients who received SMS vs those who didn’t.

```sql
SELECT sms_received, 
ROUND(100.0 * SUM(CASE WHEN No_show = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS no_show_rate_percent
FROM appointments
GROUP BY sms_received
```

### 8. Which day of the week has the highest no-show rate?

```sql
SELECT 
    TO_CHAR(AppointmentDay, 'Day') AS day_of_week,
    ROUND(100.0 * SUM(CASE WHEN No_show = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS no_show_rate_percent
FROM appointments
GROUP BY day_of_week
ORDER BY no_show_rate_percent DESC;
```

### 9. Does waiting time affect no-show? Show no-show rate by waiting time bucket:
  #### Same day (0 days)
  ####  1–3 days
   #### 4–7 days
  ####  8+ days
   
```sql
 SELECT 
    CASE 
        WHEN WaitingDays = 0 THEN 'Same day (0)'
        WHEN WaitingDays BETWEEN 1 AND 3 THEN '1-3 days'
        WHEN WaitingDays BETWEEN 4 AND 7 THEN '4-7 days'
        ELSE '8+ days'
    END AS waiting_bucket,
    ROUND(100.0 * SUM(CASE WHEN No_show = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS no_show_rate_percent
FROM appointments
GROUP BY waiting_bucket
ORDER BY no_show_rate_percent DESC;
```

### 10. Find the top 3 factors most associated with no-show (e.g., SMS_received, Scholarship, Alcoholism, Diabetes).
### (Show no-show rate for each factor: 0 vs 1)

```sql
SELECT 
    SMS_received,
    ROUND(100.0 * SUM(CASE WHEN No_show = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS no_show_percent
FROM appointments
GROUP BY SMS_received
ORDER BY no_show_percent DESC;
```

## 📊 7. Power BI Dashboard

Key Visuals:

1. No-Show by SMS Received (100% Stacked Column)

2. No-Show by Gender

3. Average Waiting Days vs No-Show

4. Age Group vs No-Show

5. Matrix: Impact of Key Factors

6. Slicers: Gender, Scholarship, SMS_received, Neighbourhood

![Power BI Dashboard](https://github.com/Arpitabagdawat/Medical-Appointment-Attendance-Analysis/blob/main/Screenshot%20.png)

## 🤖 8. Machine Learning

Goal: Predict whether a patient will miss the appointment.

Features:

 Age, Gender, WaitingDays, SMS_received, Scholarship, Diabetes, Alcoholism

 Models:

 Logistic Regression, Random Forest

Output:

No-show prediction


## 📈 9. Key Insights

SMS reminders reduce no-show rate

Longer waiting time increases no-shows

Scholarship patients have higher no-show rate

Younger adults (19–30) miss more appointments



## 👩‍💻 10. Author

Arpita Bagdawat

GitHub: [https://github.com/your-username](https://github.com/Arpitabagdawat)

LinkedIn: [https://linkedin.com/in/your-profile](https://www.linkedin.com/in/arpita-b-66a996292/)



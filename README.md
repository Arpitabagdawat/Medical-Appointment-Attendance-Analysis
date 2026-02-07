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

## 📂 2. Dataset  
**Source:** Kaggle – Medical Appointment No-Shows Dataset  

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


##🗄️ 6. SQL Analysis (PostgreSQL)


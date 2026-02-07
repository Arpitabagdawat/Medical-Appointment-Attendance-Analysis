DROP TABLE IF EXISTS appointments;
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


SELECT * FROM appointments;
LIMIT 10;

--Exploratory SQL Queries
1. Show the total number of male and female patients.

SELECT Gender, COUNT(*) AS total_patients
FROM appointments
GROUP BY Gender;

2. Show how many appointments were a no_show and how many were not.

SELECT No_show, COUNT(*) AS total_appointments
FROM appointments
GROUP BY No_show
ORDER BY total_appointments DESC;

3. Show the average waiting days for no-show vs show-up appointments.

SELECT No_show, AVG(WaitingDays) AS avg_waiting_days
FROM appointments
GROUP BY No_show;

4. Show the no-show rate (percentage) by gender.

SELECT 
    Gender,
    ROUND(100.0 * SUM(CASE WHEN No_show = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS no_show_rate_percent
FROM appointments
GROUP BY Gender;

5. Show the average waiting days by age group:
  0–18
  19–35
  36–60
  60+

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

6. Show the top 5 neighbourhoods with the highest no-show rate.

SELECT 
    Neighbourhood,
    ROUND(100.0 * SUM(CASE WHEN No_show = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS no_show_rate_percent
FROM appointments
GROUP BY Neighbourhood
ORDER BY no_show_rate_percent DESC
LIMIT 5;

7. Show the effect of SMS reminders: compare no-show rate for patients who received SMS vs those who didn’t.

SELECT sms_received, 
ROUND(100.0 * SUM(CASE WHEN No_show = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS no_show_rate_percent
FROM appointments
GROUP BY sms_received

8. Which day of the week has the highest no-show rate?

SELECT 
    TO_CHAR(AppointmentDay, 'Day') AS day_of_week,
    ROUND(100.0 * SUM(CASE WHEN No_show = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS no_show_rate_percent
FROM appointments
GROUP BY day_of_week
ORDER BY no_show_rate_percent DESC;

9. Does waiting time affect no-show? Show no-show rate by waiting time bucket:
   Same day (0 days)
   1–3 days
   4–7 days
   8+ days

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

10. Find the top 3 factors most associated with no-show (e.g., SMS_received, Scholarship, Alcoholism, Diabetes).
(Show no-show rate for each factor: 0 vs 1)

SELECT 
    SMS_received,
    ROUND(100.0 * SUM(CASE WHEN No_show = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS no_show_percent
FROM appointments
GROUP BY SMS_received
ORDER BY no_show_percent DESC;

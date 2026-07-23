-- ===========================================
-- Hospital Database - Example SQL Queries
-- ===========================================

-- Show all patients
SELECT * FROM Patients;

-- Show all doctors
SELECT * FROM Doctors;

-- Show all departments
SELECT * FROM Departments;

-- Show all appointments
SELECT * FROM Appointments;

-- Join patients with doctors and appointments
SELECT
    P.first_name || ' ' || P.last_name AS Patient,
    D.first_name || ' ' || D.last_name AS Doctor,
    D.specialty,
    A.appointment_date,
    A.appointment_time,
    A.status
FROM Appointments A
JOIN Patients P
ON A.patient_id = P.patient_id
JOIN Doctors D
ON A.doctor_id = D.doctor_id;

-- Number of appointments per doctor
SELECT
    D.first_name || ' ' || D.last_name AS Doctor,
    COUNT(*) AS Total_Appointments
FROM Appointments A
JOIN Doctors D
ON A.doctor_id = D.doctor_id
GROUP BY D.doctor_id
ORDER BY Total_Appointments DESC;

-- Number of patients
SELECT COUNT(*) AS Total_Patients
FROM Patients;

-- Number of doctors
SELECT COUNT(*) AS Total_Doctors
FROM Doctors;

-- Completed appointments
SELECT COUNT(*) AS Completed_Appointments
FROM Appointments
WHERE status = 'Completed';

-- Scheduled appointments
SELECT *
FROM Appointments
WHERE status = 'Scheduled';

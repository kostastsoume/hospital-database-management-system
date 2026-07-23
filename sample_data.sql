PRAGMA foreign_keys = ON;

-- Departments
INSERT INTO Departments (department_name, floor) VALUES
('Cardiology', 2),
('Radiology', 1),
('Neurology', 3),
('Oncology', 4),
('Orthopedics', 2),
('Emergency', 0);

-- Doctors
INSERT INTO Doctors
(first_name, last_name, specialty, phone, email, department_id)
VALUES
('Maria', 'Papadopoulou', 'Cardiologist', '2105551001', 'm.papadopoulou@hospital.example', 1),
('George', 'Nikolaidis', 'Radiologist', '2105551002', 'g.nikolaidis@hospital.example', 2),
('Eleni', 'Kosta', 'Neurologist', '2105551003', 'e.kosta@hospital.example', 3),
('Andreas', 'Georgiou', 'Oncologist', '2105551004', 'a.georgiou@hospital.example', 4),
('Sofia', 'Dimitriou', 'Orthopedic Surgeon', '2105551005', 's.dimitriou@hospital.example', 5),
('Nikos', 'Antoniou', 'Emergency Physician', '2105551006', 'n.antoniou@hospital.example', 6);

-- Patients
INSERT INTO Patients
(first_name, last_name, birth_date, gender, phone, email, address)
VALUES
('Konstantinos', 'Tsoumeleas', '2001-05-12', 'Male', '6900000000', 'konstantinos@example.com', 'Athens'),
('Anna', 'Georgiou', '1988-03-22', 'Female', '6900000001', 'anna.georgiou@example.com', 'Piraeus'),
('Dimitris', 'Papadakis', '1975-11-08', 'Male', '6900000002', 'dimitris.papadakis@example.com', 'Marousi'),
('Eleni', 'Nikolaou', '1992-07-14', 'Female', '6900000003', 'eleni.nikolaou@example.com', 'Chalandri'),
('Nikos', 'Antoniou', '1966-01-30', 'Male', '6900000004', 'nikos.antoniou@example.com', 'Kallithea'),
('Maria', 'Kostopoulou', '1983-09-18', 'Female', '6900000005', 'maria.kostopoulou@example.com', 'Glyfada'),
('Giorgos', 'Dimitriou', '1997-04-06', 'Male', '6900000006', 'giorgos.dimitriou@example.com', 'Peristeri'),
('Sofia', 'Markou', '1959-12-25', 'Female', '6900000007', 'sofia.markou@example.com', 'Nea Smyrni'),
('Andreas', 'Vasileiou', '2000-06-10', 'Male', '6900000008', 'andreas.vasileiou@example.com', 'Agia Paraskevi'),
('Katerina', 'Alexiou', '1979-02-17', 'Female', '6900000009', 'katerina.alexiou@example.com', 'Ilioupoli');

-- Appointments
INSERT INTO Appointments
(patient_id, doctor_id, appointment_date, appointment_time, reason, status)
VALUES
(1, 2, '2026-08-01', '09:00', 'Chest CT', 'Scheduled'),
(2, 1, '2026-08-02', '10:30', 'Heart Checkup', 'Completed'),
(3, 4, '2026-08-03', '11:00', 'Cancer Consultation', 'Scheduled'),
(4, 3, '2026-08-04', '12:00', 'Migraine Evaluation', 'Completed'),
(5, 5, '2026-08-05', '09:30', 'Knee Pain', 'Scheduled'),
(6, 6, '2026-08-05', '14:00', 'Emergency Examination', 'Completed'),
(7, 2, '2026-08-06', '08:30', 'MRI Review', 'Scheduled'),
(8, 1, '2026-08-06', '15:00', 'ECG', 'Completed'),
(9, 3, '2026-08-07', '13:00', 'Neurological Assessment', 'Scheduled'),
(10, 4, '2026-08-08', '10:00', 'Follow-up Visit', 'Scheduled');

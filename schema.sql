-- Enable foreign-key constraints in SQLite.
PRAGMA foreign_keys = ON;

-- Drop tables in dependency order so the schema can be recreated safely.
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Patients;

CREATE TABLE Patients (
    patient_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    birth_date TEXT,
    gender TEXT,
    phone TEXT,
    email TEXT,
    address TEXT
);

CREATE TABLE Departments (
    department_id INTEGER PRIMARY KEY AUTOINCREMENT,
    department_name TEXT NOT NULL UNIQUE,
    floor INTEGER
);

CREATE TABLE Doctors (
    doctor_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    specialty TEXT NOT NULL,
    phone TEXT,
    email TEXT,
    department_id INTEGER NOT NULL,

    FOREIGN KEY (department_id)
        REFERENCES Departments(department_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Appointments (
    appointment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    patient_id INTEGER NOT NULL,
    doctor_id INTEGER NOT NULL,
    appointment_date TEXT NOT NULL,
    appointment_time TEXT NOT NULL,
    reason TEXT,
    status TEXT NOT NULL DEFAULT 'Scheduled'
        CHECK (status IN ('Scheduled', 'Completed', 'Cancelled')),

    FOREIGN KEY (patient_id)
        REFERENCES Patients(patient_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (doctor_id)
        REFERENCES Doctors(doctor_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Indexes improve searches and joins involving foreign keys and appointment dates.
CREATE INDEX idx_doctors_department
ON Doctors(department_id);

CREATE INDEX idx_appointments_patient
ON Appointments(patient_id);

CREATE INDEX idx_appointments_doctor
ON Appointments(doctor_id);

CREATE INDEX idx_appointments_date
ON Appointments(appointment_date);

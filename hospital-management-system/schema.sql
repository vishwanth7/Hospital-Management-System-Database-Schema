DROP SCHEMA IF EXISTS hospital_management CASCADE;
CREATE SCHEMA IF NOT EXISTS hospital_management;

DROP TABLE IF EXISTS online_retail_app.user_login;
CREATE TABLE IF NOT EXISTS online_retail_app.user_login (
    user_id TEXT PRIMARY KEY,
    user_password TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    sign_up_on DATE NOT NULL,
    email_id TEXT UNIQUE NOT NULL
);

DROP TABLE IF EXISTS hospital_management.patient;
CREATE TABLE IF NOT EXISTS hospital_management.patient (
    email VARCHAR(50) PRIMARY KEY,
    password VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    gender VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS hospital_management.medical_history;
CREATE TABLE IF NOT EXISTS hospital_management.medical_history (
    medical_history_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    conditions VARCHAR(255),
    surgeries VARCHAR(255),
    medication VARCHAR(255)
);

DROP TABLE IF EXISTS hospital_management.doctor;
CREATE TABLE IF NOT EXISTS hospital_management.doctor (
    email VARCHAR(50) PRIMARY KEY,
    password VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    gender VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS hospital_management.appointment;
CREATE TABLE IF NOT EXISTS hospital_management.appointment (
    appointment_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    status VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS hospital_management.patient_visits;
CREATE TABLE IF NOT EXISTS hospital_management.patient_visits (
    patient_email VARCHAR(50) NOT NULL,
    appointment_id INT NOT NULL,
    concerns VARCHAR(255),
    symptoms VARCHAR(255),
    PRIMARY KEY (patient_email, appointment_id),
    FOREIGN KEY (patient_email) REFERENCES hospital_management.patient (email) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES hospital_management.appointment (appointment_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS hospital_management.schedule;
CREATE TABLE IF NOT EXISTS hospital_management.schedule (
    schedule_id SERIAL PRIMARY KEY,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    break_time TIME,
    day VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS hospital_management.patients_history;
CREATE TABLE IF NOT EXISTS hospital_management.patients_history (
    patient_email VARCHAR(50) NOT NULL,
    medical_history_id INT NOT NULL,
    PRIMARY KEY (patient_email, medical_history_id),
    FOREIGN KEY (patient_email) REFERENCES hospital_management.patient (email) ON DELETE CASCADE,
    FOREIGN KEY (medical_history_id) REFERENCES hospital_management.medical_history (medical_history_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS hospital_management.diagnose;
CREATE TABLE IF NOT EXISTS hospital_management.diagnose (
    appointment_id INT NOT NULL,
    doctor_email VARCHAR(50) NOT NULL,
    diagnosis VARCHAR(255),
    prescription VARCHAR(255),
    PRIMARY KEY (appointment_id, doctor_email),
    FOREIGN KEY (appointment_id) REFERENCES hospital_management.appointment (appointment_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_email) REFERENCES hospital_management.doctor (email) ON DELETE CASCADE
);

DROP TABLE IF EXISTS hospital_management.doctor_schedules;
CREATE TABLE IF NOT EXISTS hospital_management.doctor_schedules (
    schedule_id INT NOT NULL,
    doctor_email VARCHAR(50) NOT NULL,
    PRIMARY KEY (schedule_id, doctor_email),
    FOREIGN KEY (schedule_id) REFERENCES hospital_management.schedule (schedule_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_email) REFERENCES hospital_management.doctor (email) ON DELETE CASCADE
);

DROP TABLE IF EXISTS hospital_management.doctor_view_history;
CREATE TABLE IF NOT EXISTS hospital_management.doctor_view_history (
    medical_history_id INT NOT NULL,
    doctor_email VARCHAR(50) NOT NULL,
    PRIMARY KEY (medical_history_id, doctor_email),
    FOREIGN KEY (medical_history_id) REFERENCES hospital_management.medical_history (medical_history_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_email) REFERENCES hospital_management.doctor (email) ON DELETE CASCADE
);

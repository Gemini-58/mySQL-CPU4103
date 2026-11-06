-- ==================================================================
-- Crownfield Eye Hospital NHS Foundation Trust
-- 01_schema.sql
-- Database and initial schema/data setup
-- It created the database, all 11 tables with 10 Sythetic Records
-- ==================================================================

CREATE DATABASE IF NOT EXISTS CrownfieldEyeHospital;
USE CrownfieldEyeHospital;

-- ------------------------------------------------------------
-- 1. CREATE TABLES (parent tables before dependent tables)
-- ------------------------------------------------------------

-- 1. Patient
CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Postcode VARCHAR(10) NOT NULL
);

-- 2. Specialty
CREATE TABLE Specialty (
    SpecialtyID INT PRIMARY KEY,
    SpecialtyName VARCHAR(100) NOT NULL UNIQUE
);

-- 3. Clinician
CREATE TABLE Clinician (
    ClinicianID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    SpecialtyID INT NOT NULL,
    FOREIGN KEY (SpecialtyID)
        REFERENCES Specialty(SpecialtyID)
);

-- 4. Clinic
CREATE TABLE Clinic (
    ClinicID INT PRIMARY KEY,
    ClinicName VARCHAR(100) NOT NULL UNIQUE
);

-- 5. Appointment
CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY,
    PatientID INT NOT NULL,
    ClinicianID INT NOT NULL,
    ClinicID INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,

    -- Link appointments to existing records
    FOREIGN KEY (PatientID)
        REFERENCES Patient(PatientID),

    FOREIGN KEY (ClinicianID)
        REFERENCES Clinician(ClinicianID),

    FOREIGN KEY (ClinicID)
        REFERENCES Clinic(ClinicID)
);

-- 6. Diagnosis
CREATE TABLE Diagnosis (
    DiagnosisID INT PRIMARY KEY,
    DiagnosisName VARCHAR(150) NOT NULL UNIQUE
);

-- 7. Appointment_Diagnosis
CREATE TABLE Appointment_Diagnosis (
    AppointmentID INT NOT NULL,
    DiagnosisID INT NOT NULL,

    -- Composite primary key
    PRIMARY KEY (AppointmentID, DiagnosisID),

    -- Link to the Appointment table
    FOREIGN KEY (AppointmentID)
        REFERENCES Appointment(AppointmentID),

    -- Link to the Diagnosis table
    FOREIGN KEY (DiagnosisID)
        REFERENCES Diagnosis(DiagnosisID)
);

-- 8. Prescription
CREATE TABLE Prescription (
    PrescriptionID INT PRIMARY KEY,
    AppointmentID INT NOT NULL,
    PrescriptionDate DATE NOT NULL,

    -- Link each prescription to an existing appointment
    FOREIGN KEY (AppointmentID)
        REFERENCES Appointment(AppointmentID)
);

-- 9. Medicine
CREATE TABLE Medicine (
    medicine_id INT PRIMARY KEY,
    MedicineName VARCHAR(100) NOT NULL,
    Strength VARCHAR(50) NOT NULL,
    MedicineType VARCHAR(50) NOT NULL,
    Manufacturer VARCHAR(100),
    UNIQUE (MedicineName, Strength)
);

-- 10. Prescription_Item
CREATE TABLE Prescription_Item (
    PrescriptionItemID INT PRIMARY KEY,
    PrescriptionID INT NOT NULL,
    medicine_id INT NOT NULL,
    Dosage VARCHAR(50) NOT NULL,
    Route VARCHAR(50) NOT NULL,
    Frequency VARCHAR(100) NOT NULL,
    Duration VARCHAR(50) NOT NULL,

    FOREIGN KEY (PrescriptionID)
    REFERENCES Prescription(PrescriptionID),

    FOREIGN KEY (medicine_id)
    REFERENCES Medicine(medicine_id)
);

-- 11. FollowUpPlan
CREATE TABLE FollowUpPlan (
    FollowUpID INT PRIMARY KEY,
    AppointmentID INT NOT NULL UNIQUE,
    DueDate DATE NOT NULL,
    Priority VARCHAR(20) NOT NULL DEFAULT 'Routine',
    Status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    Notes VARCHAR(255),

    FOREIGN KEY (AppointmentID)
    REFERENCES Appointment(AppointmentID),

    CHECK (Priority IN ('Low', 'Routine', 'High', 'Urgent')),
    CHECK (Status IN ('Pending', 'Completed', 'Cancelled'))
);

-- ------------------------------------------------------------
-- 2. INSERT INITIAL FICTIONAL SAMPLE DATA
-- Insert parent records before records that reference them.
-- ------------------------------------------------------------

-- Initial records: Specialty
INSERT INTO Specialty (SpecialtyID, SpecialtyName)
VALUES
(1, 'Glaucoma'),
(2, 'Retina'),
(3, 'Cornea'),
(4, 'Cataract'),
(5, 'Paediatric Ophthalmology'),
(6, 'Oculoplastics'),
(7, 'Neuro-Ophthalmology'),
(8, 'Uveitis'),
(9, 'Medical Retina'),
(10, 'Emergency Eye Care');

-- Initial records: Clinic
INSERT INTO Clinic (ClinicID, ClinicName)
VALUES
(1, 'City Road Eye Clinic'),
(2, 'Bedford Eye Clinic'),
(3, 'Croydon Eye Clinic'),
(4, 'Riverside Eye Clinic'),
(5, 'Northgate Eye Clinic'),
(6, 'Westfield Eye Clinic'),
(7, 'Meadow Park Eye Clinic'),
(8, 'Central Eye Clinic'),
(9, 'Oakwood Eye Clinic'),
(10, 'Lakeside Eye Clinic');

-- Initial records: Patient
INSERT INTO Patient (PatientID, FirstName, LastName, Postcode)
VALUES
(1, 'Oliver', 'Bennett', 'AB1 2CD'),
(2, 'Amelia', 'Carter', 'BC2 3DE'),
(3, 'George', 'Wilson', 'CD3 4EF'),
(4, 'Isla', 'Thompson', 'DE4 5FG'),
(5, 'Arthur', 'Robinson', 'EF5 6GH'),
(6, 'Ava', 'Walker', 'FG6 7HJ'),
(7, 'Leo', 'Wright', 'GH7 8JK'),
(8, 'Freya', 'Hall', 'HJ8 9KL'),
(9, 'Noah', 'Green', 'KL9 1MN'),
(10, 'Grace', 'Baker', 'MN1 2PQ');

-- Initial records: Clinician
INSERT INTO Clinician
    (ClinicianID, FirstName, LastName, SpecialtyID)
VALUES
    (1, 'James', 'Hughes', 1),
    (2, 'Sarah', 'Mitchell', 2),
    (3, 'Daniel', 'Evans', 3),
    (4, 'Emily', 'Collins', 4),
    (5, 'Thomas', 'Edwards', 5),
    (6, 'Charlotte', 'Stewart', 6),
    (7, 'William', 'Morris', 7),
    (8, 'Sophie', 'Rogers', 8),
    (9, 'Henry', 'Cook', 9),
    (10, 'Lucy', 'Morgan', 10);

-- Initial records: Appointment
INSERT INTO Appointment
    (AppointmentID, PatientID, ClinicianID, ClinicID,
     AppointmentDate, AppointmentTime)
VALUES
(1, 1, 1, 1, '2026-11-02', '09:00:00'),
(2, 2, 2, 2, '2026-11-02', '09:30:00'),
(3, 3, 3, 3, '2026-11-03', '10:00:00'),
(4, 4, 4, 4, '2026-11-03', '10:30:00'),
(5, 5, 5, 5, '2026-11-04', '11:00:00'),
(6, 6, 6, 6, '2026-11-04', '11:30:00'),
(7, 7, 7, 7, '2026-11-05', '12:00:00'),
(8, 8, 8, 8, '2026-11-05', '13:00:00'),
(9, 9, 9, 9, '2026-11-06', '14:00:00'),
(10, 10, 10, 10, '2026-11-06', '15:00:00');

-- Initial records: Diagnosis
INSERT INTO Diagnosis (DiagnosisID, DiagnosisName)
VALUES
(1, 'Ocular hypertension'),
(2, 'Diabetic macular oedema'),
(3, 'Glaucoma suspect'),
(4, 'Keratoconus'),
(5, 'Cataract'),
(6, 'Dry eye disease'),
(7, 'Retinal detachment'),
(8, 'Uveitis'),
(9, 'Conjunctivitis'),
(10, 'Age-related macular degeneration');

-- Initial records: Appointment_Diagnosis
INSERT INTO Appointment_Diagnosis (AppointmentID, DiagnosisID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Initial records: Prescription
INSERT INTO Prescription
    (PrescriptionID, AppointmentID, PrescriptionDate)
VALUES
(1, 1, '2026-11-02'),
(2, 2, '2026-11-02'),
(3, 3, '2026-11-03'),
(4, 4, '2026-11-03'),
(5, 5, '2026-11-04'),
(6, 6, '2026-11-04'),
(7, 7, '2026-11-05'),
(8, 8, '2026-11-05'),
(9, 9, '2026-11-06'),
(10, 10, '2026-11-06');

-- Initial records: Medicine
INSERT INTO Medicine
(medicine_id, medicineName, strength, medicineType, manufacturer)
VALUES
(1,'Latanoprost','0.005%','Eye Drops','Pharma A'),
(2,'Timolol','0.5%','Eye Drops','Pharma B'),
(3,'Aflibercept','2mg','Injection','Pharma C'),
(4,'Sodium Chloride','5%','Eye Drops','Pharma D'),
(5,'Dorzolamide','2%','Eye Drops','Pharma E'),
(6,'Brimonidine','0.2%','Eye Drops','Pharma F'),
(7,'Prednisolone','1%','Eye Drops','Pharma G'),
(8,'Cyclopentolate','1%','Eye Drops','Pharma H'),
(9,'Tropicamide','0.5%','Eye Drops','Pharma I'),
(10,'Carboxymethylcellulose','0.5%','Eye Drops','Pharma J');

-- Initial records: Prescription_Item
INSERT INTO Prescription_Item
    (PrescriptionItemID, PrescriptionID, medicine_id,
     Dosage, Route, Frequency, Duration)
VALUES
(1, 1, 1, '1 drop', 'Ophthalmic', 'Once daily', '6 weeks'),
(2, 2, 2, '1 drop', 'Ophthalmic', 'Twice daily', '4 weeks'),
(3, 3, 3, '2mg', 'Intravitreal', 'As prescribed', 'Monthly'),
(4, 4, 4, '1 drop', 'Ophthalmic', 'Three times daily', '8 weeks'),
(5, 5, 5, '1 drop', 'Ophthalmic', 'Twice daily', '6 weeks'),
(6, 6, 6, '1 drop', 'Ophthalmic', 'Twice daily', '4 weeks'),
(7, 7, 7, '1 drop', 'Ophthalmic', 'Four times daily', '2 weeks'),
(8, 8, 8, '1 drop', 'Ophthalmic', 'As prescribed', '1 week'),
(9, 9, 9, '1 drop', 'Ophthalmic', 'As prescribed', '1 day'),
(10, 10, 10, '1 drop', 'Ophthalmic', 'Three times daily', '4 weeks');

-- Initial records: FollowUpPlan
INSERT INTO FollowUpPlan
    (FollowUpID, AppointmentID, DueDate, Priority, Status, Notes) VALUES
(1, 1, '2026-11-16', 'High', 'Pending', 'Review eye pressure'),
(2, 2, '2026-11-02', 'Urgent', 'Pending', 'OCT scan review'),
(3, 3, '2026-12-01', 'Routine', 'Pending', 'Visual field test'),
(4, 4, '2026-12-07', 'Routine', 'Pending', 'Corneal topography'),
(5, 5, '2026-11-20', 'High', 'Pending', 'Glaucoma assessment'),
(6, 6, '2026-11-25', 'Routine', 'Pending', 'Retina examination'),
(7, 7, '2026-12-10', 'Low', 'Pending', 'General eye review'),
(8, 8, '2026-11-30', 'High', 'Pending', 'Medication review'),
(9, 9, '2026-12-15', 'Routine', 'Pending', 'Vision assessment'),
(10, 10, '2026-12-20', 'Low', 'Pending', 'Follow-up consultation');

-- ------------------------------------------------------------
-- 3. VERIFY TABLES AND INITIAL RECORD COUNTS
-- ------------------------------------------------------------
SHOW TABLES;

SELECT 'Patient' AS TableName, COUNT(*) AS TotalRecords FROM Patient
UNION ALL
SELECT 'Specialty', COUNT(*) FROM Specialty
UNION ALL
SELECT 'Clinician', COUNT(*) FROM Clinician
UNION ALL
SELECT 'Clinic', COUNT(*) FROM Clinic
UNION ALL
SELECT 'Appointment', COUNT(*) FROM Appointment
UNION ALL
SELECT 'Diagnosis', COUNT(*) FROM Diagnosis
UNION ALL
SELECT 'Appointment_Diagnosis', COUNT(*) FROM Appointment_Diagnosis
UNION ALL
SELECT 'Prescription', COUNT(*) FROM Prescription
UNION ALL
SELECT 'Medicine', COUNT(*) FROM Medicine
UNION ALL
SELECT 'Prescription_Item', COUNT(*) FROM Prescription_Item
UNION ALL
SELECT 'FollowUpPlan', COUNT(*) FROM FollowUpPlan;

-- End of 01_schema.sql

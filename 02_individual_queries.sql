


-- ==========================================
-- PART C: INDIVIDUAL SQL AND VALIDATION
-- G1432252_Aamna
-- ==========================================

USE CrownfieldEyeHospital;

-- 4.1 Aggregate Query Using GROUP BY and HAVING
-- Question: Which medicine types contain at least two medicines?
-- ===============================================================


SELECT
    MedicineType,
    COUNT(*) AS TotalMedicines
FROM Medicine
GROUP BY MedicineType
HAVING COUNT(*) >= 2
ORDER BY TotalMedicines DESC;


-- 4.2 INNER JOIN ACROSS FIVE TABLES
-- Question: Which patients attended appointments,
-- which clinicians treated them, and at which clinics?
-- ======================================================

SELECT
    a.AppointmentID,
    p.FirstName AS PatientFirstName,
    p.LastName AS PatientLastName,
    c.FirstName AS ClinicianFirstName,
    c.LastName AS ClinicianLastName,
    s.SpecialtyName,
    cl.ClinicName,
    a.AppointmentDate,
    a.AppointmentTime

FROM Appointment AS a

INNER JOIN Patient AS p
    ON a.PatientID = p.PatientID

INNER JOIN Clinician AS c
    ON a.ClinicianID = c.ClinicianID

INNER JOIN Specialty AS s
    ON c.SpecialtyID = s.SpecialtyID

INNER JOIN Clinic AS cl
    ON a.ClinicID = cl.ClinicID

ORDER BY a.AppointmentID;



-- 4.3 LEFT JOIN: 
-- Check whether test AppointmentID 11 exists
-- ======================================================

SELECT *
FROM Appointment
WHERE AppointmentID = 11;


-- Insert a temporary appointment without a follow-up plan

INSERT INTO Appointment
    (AppointmentID, PatientID, ClinicianID, ClinicID,
     AppointmentDate, AppointmentTime)
VALUES
    (11, 1, 1, 1, '2026-11-07', '16:00:00');

-- Verify that the temporary appointment was inserted

SELECT * FROM Appointment WHERE AppointmentID = 11;

-- including appointments without follow-up plans

SELECT
    a.AppointmentID,
    a.AppointmentDate,
    a.AppointmentTime,
    f.FollowUpID,
    f.DueDate,
    f.Priority,
    f.Status

FROM Appointment AS a

LEFT JOIN FollowUpPlan AS f
    ON a.AppointmentID = f.AppointmentID

ORDER BY a.AppointmentID;


-- Remove the temporary appointment
DELETE FROM Appointment
WHERE AppointmentID = 11;

-- Verify that the temporary appointment was deleted
SELECT *
FROM Appointment
WHERE AppointmentID = 11;

-- Confirm the original appointment count
SELECT COUNT(*) AS TotalAppointments FROM Appointment;


-- 4.4 SUBQUERY
-- Find patients with appointments with Glaucoma specialists
-- ==========================================================

SELECT
    PatientID,
    FirstName,
    LastName
FROM Patient
WHERE PatientID IN
(
    SELECT PatientID
    FROM Appointment
    WHERE ClinicianID IN
    (
        SELECT ClinicianID
        FROM Clinician
        WHERE SpecialtyID =
        (
            SELECT SpecialtyID
            FROM Specialty
            WHERE SpecialtyName = 'Glaucoma'
        )
    )
);






-- =============================================
-- 4.5 STORED PROCEDURE WITH INPUT PARAMETER
-- Retrieve appointments for a selected patient
-- =============================================

USE CrownfieldEyeHospital;

CREATE PROCEDURE GetPatientAppointments(
    IN p_PatientID INT
)
SELECT
    p.PatientID,
    p.FirstName,
    p.LastName,
    a.AppointmentID,
    a.AppointmentDate,
    a.AppointmentTime,
    c.FirstName AS ClinicianFirstName,
    c.LastName AS ClinicianLastName,
    cl.ClinicName

FROM Patient AS p

INNER JOIN Appointment AS a
    ON p.PatientID = a.PatientID

INNER JOIN Clinician AS c
    ON a.ClinicianID = c.ClinicianID

INNER JOIN Clinic AS cl
    ON a.ClinicID = cl.ClinicID

WHERE p.PatientID = p_PatientID;

CALL GetPatientAppointments(1);


-- ================================================================
-- 4.6 TRIGGER AND BUSINESS RULE ENFORCEMENT
-- Prevent appointments from being entered with a date in the past
-- ================================================================

USE crownfieldeyehospital;

-- Remove the trigger if it already exists
DROP TRIGGER IF EXISTS CheckAppointmentDate;

-- Change the delimiter
DELIMITER //

-- Create the trigger
CREATE TRIGGER CheckAppointmentDate
BEFORE INSERT ON Appointment
FOR EACH ROW
BEGIN
    IF NEW.AppointmentDate < CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Appointment date cannot be in the past';
    END IF;
END //

-- Restore the normal delimiter
DELIMITER ;


SHOW TRIGGERS WHERE `Trigger` = 'CheckAppointmentDate';


USE crownfieldeyehospital;

INSERT INTO Appointment
    (AppointmentID, PatientID, ClinicianID, ClinicID,
     AppointmentDate, AppointmentTime)
VALUES
    (9999, 1, 1, 1, '2020-01-01', '10:00:00');


SELECT * FROM Appointment WHERE AppointmentID = 9999;

SELECT COUNT(*) AS TotalAppointments FROM Appointment;


USE crownfieldeyehospital;

SELECT AppointmentID, AppointmentDate, AppointmentTime
FROM Appointment
ORDER BY AppointmentID;

DELETE FROM Appointment WHERE AppointmentID = 12;

SELECT AppointmentID, AppointmentDate
FROM Appointment
ORDER BY AppointmentID;

SELECT COUNT(*) AS TotalAppointments FROM Appointment;

INSERT INTO Appointment
    (AppointmentID, PatientID, ClinicianID, ClinicID,
     AppointmentDate, AppointmentTime)
VALUES
    (9999, 1, 1, 1, '2020-01-01', '10:00:00');


SELECT * FROM Appointment WHERE AppointmentID = 9999;

SELECT COUNT(*) AS TotalAppointments FROM Appointment;



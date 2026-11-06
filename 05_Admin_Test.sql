

USE CrownfieldEyeHospital;

SELECT CURRENT_USER(), CURRENT_ROLE();

-- Verify the Administrator permissions

USE CrownfieldEyeHospital;

SHOW GRANTS FOR CURRENT_USER();

SELECT * FROM Patient LIMIT 5;

USE CrownfieldEyeHospital;

-- Generate a SHA-256 password hash
SELECT SHA2('HospitalDemo2026!', 256) AS HashedPassword;

-- Test correct password
SELECT
    CASE
        WHEN SHA2('HospitalDemo2026!', 256) =
             SHA2('HospitalDemo2026!', 256)
        THEN 'Password Matched'
        ELSE 'Password Not Matched'
    END AS PasswordVerification;

-- Test incorrect password
SELECT
    CASE
        WHEN SHA2('WrongPassword123', 256) =
             SHA2('HospitalDemo2026!', 256)
        THEN 'Password Matched'
        ELSE 'Password Not Matched'
    END AS PasswordVerification;


USE CrownfieldEyeHospital;

SELECT
    UserID,
    Username,
    PasswordHash
FROM PasswordSecurityDemo;



-- Secure Coding and SQL Injection Prevention

USE CrownfieldEyeHospital;

-- Set a patient ID as a parameter
SET @patient_id = 1;

-- Prepare a parameterised SQL query
PREPARE patient_query FROM
'SELECT PatientID, FirstName, LastName
 FROM Patient
 WHERE PatientID = ?';

-- Execute the query using the parameter
EXECUTE patient_query USING @patient_id;

-- Release the prepared statement
DEALLOCATE PREPARE patient_query;

-- Transaction Integrity

USE CrownfieldEyeHospital;

-- Create a temporary demonstration table
CREATE TEMPORARY TABLE TransactionDemo (
    TestID INT PRIMARY KEY,
    TestValue VARCHAR(50)
);

-- Insert an original value
INSERT INTO TransactionDemo
VALUES (1, 'Original Value');

-- Check the original value
SELECT * FROM TransactionDemo;


-- Start a transaction
START TRANSACTION;

-- Update the existing value
UPDATE TransactionDemo
SET TestValue = 'Updated Value'
WHERE TestID = 1;

-- Display the updated value
SELECT * FROM TransactionDemo;

-- Undo the previous update
ROLLBACK;

-- Check whether the original value has been restored
SELECT * FROM TransactionDemo;
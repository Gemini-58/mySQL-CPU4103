

USE CrownfieldEyeHospital;

-- Verify the connected user and active role
SELECT CURRENT_USER(), CURRENT_ROLE();

USE CrownfieldEyeHospital;

SELECT * FROM Patient LIMIT 5;

USE CrownfieldEyeHospital;

DELETE FROM Patient WHERE PatientID = -999;
# Crownfield Eye Hospital Database

## CPU4:103 – Introduction to Databases

**Project:** Crownfield Eye Hospital NHS Foundation Trust – Ophthalmology Relational Database  
**Database:** `CrownfieldEyeHospital`  
**DBMS:** MySQL  
**Repository:** Aamna's Individual repository database development work

## 1. Project Overview

This project develops a relational database for the fictional Crownfield Eye Hospital ophthalmology service. The assignment covers the analysis and design of the database, normalisation, implementation in MySQL, SQL queries, stored procedures, triggers, security controls and testing.

The database is a teaching project and uses synthetic demonstration records only. It must not be used to store real patient information.

## 2. Repository Structure

| File or folder | Contents | Assignment area |
|---|---|---|
| `01_schema.sql` | Creates the database and 11 tables, inserts synthetic sample data and provides table/count verification. | Part B – Physical design and implementation |
| `02_individual_queries.sql` | Aggregate query using `GROUP BY` and `HAVING`, five-table `INNER JOIN`, `LEFT JOIN` test and nested subquery. | Part C – Individual SQL queries |
| `03_Procedure_and_Trigger.sql` | `GetPatientAppointments` stored procedure and `CheckAppointmentDate` trigger. | Part C – Procedure and trigger |
| `04_Security_Controls.sql` | Creates the Administrator, Doctor, Receptionist and Patient roles, assigns privileges and includes the password-hashing demonstration. | Part D – Security and data protection |
| `05_Admin_Test.sql` | Administrator tests, prepared statement and transaction/rollback demonstration. | Part D – Individual testing |
| `06_Doctor_Test.sql` | Doctor account and permission checks, including a restricted delete attempt. | Part D – Individual testing |
| `07_ERD/` | Conceptual Data Model, Logical Data Model and Final Relational Schema (`.drawio` files), with a folder README. | Part A – Database design |
| `README.md` | Project overview, file guide, execution order and contribution summary. | Repository documentation |


## 3. Database Design – Part A

Part A focuses on analysing the ophthalmology dataset and designing a relational database.

The design work includes:
- Reviewing the unnormalised data and identifying repeating groups, redundancy and potential insertion, update and deletion anomalies.
- Identifying the entities, attributes and relationships needed for the hospital scenario.
- Producing a conceptual ER diagram and a logical data model.
- Showing the normalisation process towards Third Normal Form (3NF).
- Defining the final relational schema, including primary keys and foreign keys.

The three diagrams are stored in `07_ERD/`:
1. `Conceptual Data Model.drawio`
2. `Logical Data Model.drawio`
3. `Final Relational Schema.drawio`

Open the `.drawio` files with [diagrams.net](https://app.diagrams.net/). GitHub may display the XML source rather than a rendered diagram; download the file to view or edit it in diagrams.net.

## 4. Physical Implementation – Part B

The database is implemented in MySQL and contains 11 related tables:

1. `Patient`
2. `Specialty`
3. `Clinician`
4. `Clinic`
5. `Appointment`
6. `Diagnosis`
7. `Appointment_Diagnosis`
8. `Prescription`
9. `Medicine`
10. `Prescription_Item`
11. `FollowUpPlan`

The implementation uses primary keys and foreign keys to identify records and maintain relationships. The schema script also inserts synthetic sample data and includes checks to inspect the created tables and record counts.

## 5. Individual SQL Work – Part C

The individual query file demonstrates four query techniques:

- **Aggregate query:** groups medicines by `MedicineType` and uses `HAVING` to return types containing at least two medicines.
- **INNER JOIN:** joins `Appointment`, `Patient`, `Clinician`, `Specialty` and `Clinic` to show appointment, patient, clinician, specialty and clinic information.
- **LEFT JOIN:** returns appointments whether or not a matching follow-up plan exists. The script creates and removes a temporary appointment for this test.
- **Subquery:** finds patients with appointments involving clinicians whose specialty is Glaucoma.

The individual procedure and trigger file contains:
- **Stored procedure – `GetPatientAppointments`:** accepts a PatientID input parameter and retrieves that patient's appointment information, including clinician and clinic details.
- **Trigger – `CheckAppointmentDate`:** runs before an appointment is inserted and rejects an appointment date earlier than the current date.

## 6. Security and Data Protection – Part D

The security script creates four database roles and assigns privileges:

- `HospitalAdministrator`
- `Doctor`
- `Receptionist`
- `Patient`

My allocated security work was the **HospitalAdministrator and Doctor roles**. The Administrator role receives full privileges on the project database. The Doctor role receives `SELECT`, `INSERT` and `UPDATE` privileges, without `DELETE` permission.

The group security work also includes the Receptionist and Patient roles and a SHA-256 password-hashing demonstration. The hashing example is for learning purposes only. SHA-256 on its own is not suitable for production password storage; a production system should use a dedicated password-hashing algorithm with a unique salt and suitable work factor.

The Administrator and Doctor test scripts provide checks of the respective accounts and permissions. The Administrator test file also demonstrates a prepared statement and a transaction that is rolled back.

**Security note:** The SQL security script contains demonstration account credentials. These must only be used in a local teaching environment. Do not reuse them for personal accounts or production systems. As this repository is public, replace demonstration passwords with safe placeholders before publishing if they are not required for assessment evidence.

## 7. Suggested Execution Order

Use MySQL Server and MySQL Workbench. Run the scripts in this order, after reviewing their contents and confirming that the database is a suitable test environment:

1. `01_schema.sql` – create the database, tables and sample data.
2. `02_individual_queries.sql` – run the four individual query demonstrations.
3. `03_Procedure_and_Trigger.sql` – create and test the stored procedure and trigger.
4. `04_Security_Controls.sql` – create roles, users and privileges.
5. `05_Admin_Test.sql` – run Administrator tests.
6. `06_Doctor_Test.sql` – run Doctor tests.

### Important testing precautions

- Run the schema script in a clean project database. Do not run it over an existing database containing work you need to keep.
- In the LEFT JOIN test in `02_individual_queries.sql`, check that `AppointmentID = 11` is not already in use before inserting the temporary appointment. Confirm that the test record is removed afterwards.
- Review the statements in `03_Procedure_and_Trigger.sql` before executing the whole file. It includes deliberate invalid-date tests and a `DELETE` statement for `AppointmentID = 12`. Check the record first and do not run that deletion unless it is confirmed to be a disposable test record.
- Some test statements are expected to produce errors because they deliberately test constraints or permissions. Record the actual MySQL output as evidence.
- The scripts have been organised for the repository; successful execution should be confirmed in MySQL Workbench. Do not assume a script has passed simply because it is present in GitHub.

## 8. Group Allocation and Individual Contribution

The project was completed as a group of three, with individual responsibilities recorded in the supplied SQL work.

### Aamna – Individual repository owner

**Part B – Group schema contribution**
- Created the `Patient` table.
- Created the `Specialty` table.
- Created the `Clinician` table and its relationship to `Specialty`.
- Created the `Clinic` table.

**Part C – Individual SQL work**
- Wrote the aggregate query using `GROUP BY` and `HAVING`.
- Wrote the five-table `INNER JOIN`.
- Wrote the `LEFT JOIN` test for appointments without follow-up plans.
- Wrote the nested subquery for patients with appointments involving Glaucoma specialists.
- Created the `GetPatientAppointments` stored procedure.
- Created the `CheckAppointmentDate` trigger.

**Part D – Individual security allocation**
- Created the `HospitalAdministrator` and `Doctor` roles.
- Assigned privileges to those roles and created their test accounts.
- Prepared the Administrator and Doctor testing scripts.

**Part A**
- Prepared the database analysis, conceptual and logical design, normalisation work and database design diagrams for the individual assignment submission.

### Khalid – Group contribution
- Contributed the `Appointment`, `Diagnosis`, `Appointment_Diagnosis` and `Prescription` tables.
- Contributed the `Receptionist` and `Patient` roles and related role work.

### Farhan – Group contribution
- Contributed the `Medicine`, `Prescription_Item` and `FollowUpPlan` tables.
- Contributed the SHA-256 password-hashing demonstration.

This allocation summary distinguishes the individual work from the collaborative database build. The individual report and presentation explain the work undertaken and the decisions made.

## 9. Tools

- MySQL Server
- MySQL Workbench
- GitHub
- diagrams.net (Draw.io)

## 10. Scope and Limitations

This is an academic database prototype using fictional data. It is not a production clinical system. The role permissions and password-hashing demonstration are educational examples and would need further security design, testing and review before any real-world use.

The repository contains the SQL scripts and database diagrams. The written report, presentation and assessment screenshots should be submitted in the locations specified by the university.

## How to View the Diagrams
Open the `.drawio` files from the `07_ERD` folder using https://app.diagrams.net/.

## Individual Contribution
This repository presents my individual database development work for the CPU4:103 assignment.

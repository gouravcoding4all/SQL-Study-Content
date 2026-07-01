#DELETE AUDIT:
DELIMITER $$
CREATE TRIGGER trg_employee_delete_audit
AFTER DELETE ON employee1
FOR EACH ROW
BEGIN
    INSERT INTO audit_employee
    (eid, ename, action)
    VALUES
    (OLD.eid, OLD.ename, 'DELETE');
END$$
DELIMITER ;

#track only EMPLOYEE NAME Changes
DELIMITER $$
CREATE TRIGGER trg_name_change_audit
AFTER UPDATE ON employee1
FOR EACH ROW
BEGIN
    IF OLD.ename <> NEW.ename THEN
        INSERT INTO audit_employee
        (eid, ename, action)
        VALUES
        (OLD.eid, NEW.ename, 'NAME CHANGED');
    END IF;
END$$
DELIMITER ;

#track balance changes in audit table
DELIMITER $$
CREATE TRIGGER trg_balance_change_audit
AFTER UPDATE ON employee1
FOR EACH ROW
BEGIN
    IF OLD.ename <> NEW.ename THEN
        INSERT INTO audit_employee
        (eid, ename, action)
        VALUES
        (NEW.eid, NEW.ename, 'BALANCE CHANGED');
    END IF;
END$$
DELIMITER ;

#Log every new account add
DELIMITER $$
CREATE TRIGGER trg_new_esal_log
AFTER UPDATE ON employee1
FOR EACH ROW
BEGIN
        INSERT INTO esal_log
        (eid, ename, action,OLD_esal,NEW_esal)
        VALUES
        (NEW.eid,'BALANCE DIFF',NEW.esal-OLD.esal,OLD.esal,NEW.esal);
END$$
DELIMITER ;

#Maintain Minimum balance rs 500:-
DELIMITER $$
CREATE TRIGGER trg_min_balance
BEFORE UPDATE ON employee1
FOR EACH ROW
BEGIN
    IF NEW.esal < 15000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Minimum balance must be 15000';
    END IF;
END$$
DELIMITER ;

#Restrict withdrawls above rs 10000
DELIMITER $$
CREATE TRIGGER trg_max_withdrawl
BEFORE UPDATE ON employee1
FOR EACH ROW
BEGIN
    IF (OLD.esal - NEW.ename) > 10000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Withdrawl exceeds limit';
    END IF;
END$$
DELIMITER ;

#prevent deletion if salary >12000
DELIMITER $$
CREATE TRIGGER trg_no_delete_positive_balance
BEFORE DELETE ON employee1
FOR EACH ROW
BEGIN
    IF OLD.esal > 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT='Cannot delete employee with positive esal';
    END IF;
END$$
DELIMITER ;

#Give Rs 100 bonus on esal>= Rs 30000:-
DELIMITER $$
CREATE TRIGGER trg_opening_bonus
BEFORE DELETE ON employee1
FOR EACH ROW
BEGIN
    IF NEW.esal > 30000 THEN
    SET NEW.esal= NEW.esal + 100;
    END IF;
END$$
DELIMITER ;
#-----------------------------------------------Practice set 10---------------------------------------------------------------------------
#SIMPLE PROCEDURE
DELIMITER //
CREATE PROCEDURE GetAllEmployee1()
BEGIN 
SELECT*FROM employee1;
END//
DELIMITER ;
SELECT * FROM employee1;
#PROCEDURE WITH IN PARAMETER:
DELIMITER //
CREATE PROCEDURE GetEmployeesByDepartment(IN dept_name VARCHAR(30))
BEGIN
SELECT*FROM employee1
WHERE dept=dept_name;
END//
DELIMITER ;

#PROCEDURE WITH MULTIPLE IN PARAMETERS:
DELIMITER //
CREATE PROCEDURE GetEmployeebySalaryRange(
IN min_sal DECIMAL(10,2),
IN max_sal DECIMAL(10,2)
)
BEGIN
SELECT*FROM employee1
WHERE esal BETWEEN min_sal AND max_sal;
END //
DELIMITER ;

#PROCEDURE WITH OUT PARAMETER
DELIMITER //
CREATE PROCEDURE EmployeeCountByDepartment(
IN dept VARCHAR(30),
OUT eid INT
)
BEGIN
SELECT COUNT(*) 
INTO eid
FROM employee1
WHERE department=dept;
END //
DELIMITER ;

#PROCEDURE TO INSERT DATA
DELIMITER //
CREATE PROCEDURE InsertEmployee(
IN p_eid INT,
IN p_ename VARCHAR(50),
IN p_dept VARCHAR(30),
IN p_esal DECIMAL(10,2),
IN p_eadd DATE
)
BEGIN
INSERT INTO employee1
VALUES(
p_eid,
p_ename,
p_dept,
p_esal,
p_eadd
);
END //
DELIMITER ;

#PROCEDURE TO UPDATE SALARY
DELIMITER //
CREATE PROCEDURE UpdateSalary(
IN P_eid INT,
IN hike_percent DECIMAL(5,2)
)
BEGIN
UPDATE employee1
SET esal = esal + (esal*hike_percent/100)
WHERE eid=P_eid;
END //
DELIMITER ;

#Procedure with if Condition 
DELIMITER //
CREATE PROCEDURE SalaryHike(IN p_eid INT)
BEGIN
    DECLARE esal1 DECIMAL(10,2);
    SELECT esal
    INTO esal1
    FROM employee1
    WHERE eid = p_eid;

    IF esal1 < 50000 THEN
        UPDATE employee1
        SET esal = esal * 1.10
        WHERE eid = p_eid;
    ELSE
        UPDATE employee1
        SET esal = esal * 1.05
        WHERE eid = p_eid;
    END IF;
END //
DELIMITER ;

#PROCEDURE USING CASE
DELIMITER //
CREATE PROCEDURE EmployeeLevel(IN p_eid INT)
BEGIN
    DECLARE esal1 DECIMAL(10,2);
    SELECT esal
    INTO esal1
    FROM employee1
    WHERE eid = p_eid;
	CASE
    WHEN esal1 < 50000 THEN
        SELECT 'Junior Employee' AS Level;
	WHEN esal1 BETWEEN 50000 AND 70000 THEN
        SELECT 'Senior Employee' AS Level;
        END CASE;
END //
DELIMITER ;

SELECT*FROM employee1;

#PROCEDURE WITH TRANSACTION:
DELIMITER //
CREATE PROCEDURE InsertEmployeeTransaction(
IN p_eid INT,
IN p_ename VARCHAR(50),
IN p_dept VARCHAR(30),
IN p_esal DECIMAL(10,2),
IN p_eadd VARCHAR(40)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    ROLLBACK;
    END;
    START TRANSACTION;
    INSERT INTO employee1
    VALUES(
	p_eid,
	p_ename,
	p_dept,
	p_esal,
	p_eadd
);
COMMIT;
END //
DELIMITER ;

#PROCEDURE WITH CURSOR
DELIMITER //
CREATE PROCEDURE TotalSalaryPAYOUT()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE esal DECIMAL(10,2);
    DECLARE Tesal DECIMAL(15,2) DEFAULT 0;
    DECLARE cur CURSOR FOR
        SELECT esal
        FROM employee1;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO esal;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;
        SET Tesal = Tesal + esal;
    END LOOP;
    CLOSE cur;
    SELECT Tesal AS Total_Salary_Payout;
END //
DELIMITER ;

CALL GetAllEmployees();

CALL GetEmployeesByDepartment('IT');

CALL GetEmployeesBySalaryRange(40000,70000);

CALL EmployeeCountByDepartment('HR', @cnt);
SELECT @cnt;

CALL UpdateSalary(101,10);

CALL SalaryHike(102);

CALL EmployeeLevel(103);

CALL TotalSalaryPayout();
#-----------------------------------------------Practice set 11---------------------------------------------------------------------------
-- Patients Table
CREATE TABLE patients(
patient_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
age INT,
gender VARCHAR(10),
phone VARCHAR(15) UNIQUE
);

-- doctors Table 
CREATE TABLE doctors(
doctor_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
specialization VARCHAR(100),
consultation_fee DECIMAL(10,2)
);

#APPOINTMENT TABLE
CREATE TABLE appointments(
appointment_id INT PRIMARY KEY AUTO_INCREMENT,
patient_id INT,
doctor_id INT,
appointment_date DATE,
appointment_time TIME,
status VARCHAR(20),
FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

#Treatments Table
CREATE TABLE treatments(
treatment_id INT PRIMARY KEY AUTO_INCREMENT,
appointment_id INT,
diagnosis VARCHAR(255),
treatment_details VARCHAR(255),
medicine VARCHAR(100),
FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

#Billing table
CREATE TABLE billing(
bill_id INT PRIMARY KEY AUTO_INCREMENT,
patient_id INT,
appointment_id INT,
amount DECIMAL(10,2),
payment_status VARCHAR(20),
bill_date DATE,
FOREIGN KEY(patient_id) REFERENCES patients(patient_id),
FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

SHOW TABLES;
DESC patients;
DESC doctors;
DESC appointments;
DESC treatments;
DESC billing;

SELECT*FROM patients;

INSERT INTO patients (name, age, gender, phone) VALUES
('Aarav Sharma', 25, 'Male', '9876500001'),
('Vivaan Singh', 32, 'Male', '9876500002'),
('Aditya Verma', 28, 'Male', '9876500003'),
('Rohan Gupta', 40, 'Male', '9876500004'),
('Karan Mehta', 35, 'Male', '9876500005'),
('Rahul Yadav', 29, 'Male', '9876500006'),
('Ankit Kumar', 31, 'Male', '9876500007'),
('Mohit Jain', 27, 'Male', '9876500008'),
('Saurabh Mishra', 45, 'Male', '9876500009'),
('Nikhil Patel', 38, 'Male', '9876500010'),
('Priya Sharma', 24, 'Female', '9876500011'),
('Neha Verma', 30, 'Female', '9876500012'),
('Pooja Gupta', 26, 'Female', '9876500013'),
('Sneha Singh', 34, 'Female', '9876500014'),
('Kavita Yadav', 41, 'Female', '9876500015'),
('Riya Mehta', 22, 'Female', '9876500016'),
('Anjali Jain', 37, 'Female', '9876500017'),
('Muskan Patel', 29, 'Female', '9876500018'),
('Simran Kaur', 33, 'Female', '9876500019'),
('Nisha Kumari', 28, 'Female', '9876500020'),
('Amit Sinha', 36, 'Male', '9876500021'),
('Deepak Roy', 39, 'Male', '9876500022'),
('Harsh Vardhan', 27, 'Male', '9876500023'),
('Ritesh Das', 43, 'Male', '9876500024'),
('Abhishek Tiwari', 30, 'Male', '9876500025'),
('Sanjay Kumar', 46, 'Male', '9876500026'),
('Ajay Singh', 50, 'Male', '9876500027'),
('Manish Gupta', 33, 'Male', '9876500028'),
('Sunil Sharma', 48, 'Male', '9876500029'),
('Vikas Yadav', 26, 'Male', '9876500030'),
('Shalini Verma', 31, 'Female', '9876500031'),
('Asha Kumari', 44, 'Female', '9876500032'),
('Meena Sharma', 39, 'Female', '9876500033'),
('Suman Gupta', 35, 'Female', '9876500034'),
('Rekha Singh', 42, 'Female', '9876500035'),
('Divya Patel', 23, 'Female', '9876500036'),
('Komal Jain', 29, 'Female', '9876500037'),
('Bhavna Yadav', 36, 'Female', '9876500038'),
('Preeti Mishra', 27, 'Female', '9876500039'),
('Pallavi Roy', 32, 'Female', '9876500040'),
('Gourav Pal', 24, 'Male', '9876500041'),
('Rakesh Chauhan', 47, 'Male', '9876500042'),
('Ashish Kumar', 34, 'Male', '9876500043'),
('Lokesh Sharma', 29, 'Male', '9876500044'),
('Tarun Verma', 37, 'Male', '9876500045'),
('Hemant Singh', 41, 'Male', '9876500046'),
('Pankaj Gupta', 28, 'Male', '9876500047'),
('Sachin Mishra', 45, 'Male', '9876500048'),
('Vinod Patel', 52, 'Male', '9876500049'),
('Arun Tiwari', 38, 'Male', '9876500050');

INSERT INTO doctors (name, specialization, consultation_fee) VALUES
('Dr. Rajesh Sharma', 'Cardiologist', 1000.00),
('Dr. Priya Verma', 'Dermatologist', 700.00),
('Dr. Amit Kumar', 'Orthopedic', 900.00),
('Dr. Neha Singh', 'Gynecologist', 800.00),
('Dr. Vivek Gupta', 'Neurologist', 1200.00),
('Dr. Anjali Mehta', 'Pediatrician', 600.00),
('Dr. Rakesh Yadav', 'ENT Specialist', 750.00),
('Dr. Suman Jain', 'Ophthalmologist', 850.00),
('Dr. Mohit Patel', 'Psychiatrist', 950.00),
('Dr. Kavita Roy', 'General Physician', 500.00),
('Dr. Deepak Mishra', 'Cardiologist', 1000.00),
('Dr. Pooja Sharma', 'Dermatologist', 700.00),
('Dr. Harish Tiwari', 'Orthopedic', 900.00),
('Dr. Rekha Gupta', 'Gynecologist', 800.00),
('Dr. Ajay Verma', 'Neurologist', 1200.00),
('Dr. Shalini Yadav', 'Pediatrician', 600.00),
('Dr. Sanjay Kumar', 'ENT Specialist', 750.00),
('Dr. Meena Singh', 'Ophthalmologist', 850.00),
('Dr. Rahul Jain', 'Psychiatrist', 950.00),
('Dr. Nisha Patel', 'General Physician', 500.00),
('Dr. Ashok Das', 'Cardiologist', 1050.00),
('Dr. Komal Sharma', 'Dermatologist', 720.00),
('Dr. Vinod Chauhan', 'Orthopedic', 920.00),
('Dr. Divya Gupta', 'Gynecologist', 820.00),
('Dr. Pankaj Kumar', 'Neurologist', 1250.00),
('Dr. Sneha Roy', 'Pediatrician', 650.00),
('Dr. Lokesh Mishra', 'ENT Specialist', 780.00),
('Dr. Bhavna Jain', 'Ophthalmologist', 870.00),
('Dr. Tarun Singh', 'Psychiatrist', 980.00),
('Dr. Ritu Verma', 'General Physician', 550.00),
('Dr. Hemant Sharma', 'Cardiologist', 1100.00),
('Dr. Muskan Gupta', 'Dermatologist', 750.00),
('Dr. Sachin Patel', 'Orthopedic', 950.00),
('Dr. Asha Kumari', 'Gynecologist', 850.00),
('Dr. Arun Tiwari', 'Neurologist', 1300.00),
('Dr. Simran Kaur', 'Pediatrician', 700.00),
('Dr. Sunil Kumar', 'ENT Specialist', 800.00),
('Dr. Pallavi Singh', 'Ophthalmologist', 900.00),
('Dr. Abhishek Roy', 'Psychiatrist', 1000.00),
('Dr. Preeti Sharma', 'General Physician', 600.00),
('Dr. Gaurav Mehta', 'Cardiologist', 1150.00),
('Dr. Rohan Yadav', 'Dermatologist', 780.00),
('Dr. Manish Gupta', 'Orthopedic', 980.00),
('Dr. Ankit Verma', 'Gynecologist', 900.00),
('Dr. Kiran Patel', 'Neurologist', 1350.00),
('Dr. Saurabh Jain', 'Pediatrician', 720.00),
('Dr. Vikas Sharma', 'ENT Specialist', 820.00),
('Dr. Nidhi Mishra', 'Ophthalmologist', 920.00),
('Dr. Ravi Kumar', 'Psychiatrist', 1050.00),
('Dr. Seema Gupta', 'General Physician', 650.00);

INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, status) VALUES
(1,1,'2026-07-01','09:00:00','Completed'),
(2,2,'2026-07-01','09:30:00','Completed'),
(3,3,'2026-07-01','10:00:00','Completed'),
(4,4,'2026-07-01','10:30:00','Completed'),
(5,5,'2026-07-01','11:00:00','Completed'),
(6,6,'2026-07-01','11:30:00','Completed'),
(7,7,'2026-07-01','12:00:00','Pending'),
(8,8,'2026-07-01','12:30:00','Pending'),
(9,9,'2026-07-01','01:00:00','Completed'),
(10,10,'2026-07-01','01:30:00','Completed'),
(11,11,'2026-07-02','09:00:00','Completed'),
(12,12,'2026-07-02','09:30:00','Pending'),
(13,13,'2026-07-02','10:00:00','Completed'),
(14,14,'2026-07-02','10:30:00','Cancelled'),
(15,15,'2026-07-02','11:00:00','Completed'),
(16,16,'2026-07-02','11:30:00','Completed'),
(17,17,'2026-07-02','12:00:00','Pending'),
(18,18,'2026-07-02','12:30:00','Completed'),
(19,19,'2026-07-02','01:00:00','Completed'),
(20,20,'2026-07-02','01:30:00','Cancelled'),
(21,21,'2026-07-03','09:00:00','Completed'),
(22,22,'2026-07-03','09:30:00','Completed'),
(23,23,'2026-07-03','10:00:00','Pending'),
(24,24,'2026-07-03','10:30:00','Completed'),
(25,25,'2026-07-03','11:00:00','Completed'),
(26,26,'2026-07-03','11:30:00','Completed'),
(27,27,'2026-07-03','12:00:00','Pending'),
(28,28,'2026-07-03','12:30:00','Completed'),
(29,29,'2026-07-03','01:00:00','Completed'),
(30,30,'2026-07-03','01:30:00','Cancelled'),
(31,31,'2026-07-04','09:00:00','Completed'),
(32,32,'2026-07-04','09:30:00','Pending'),
(33,33,'2026-07-04','10:00:00','Completed'),
(34,34,'2026-07-04','10:30:00','Completed'),
(35,35,'2026-07-04','11:00:00','Completed'),
(36,36,'2026-07-04','11:30:00','Pending'),
(37,37,'2026-07-04','12:00:00','Completed'),
(38,38,'2026-07-04','12:30:00','Completed'),
(39,39,'2026-07-04','01:00:00','Cancelled'),
(40,40,'2026-07-04','01:30:00','Completed'),
(41,41,'2026-07-05','09:00:00','Completed'),
(42,42,'2026-07-05','09:30:00','Pending'),
(43,43,'2026-07-05','10:00:00','Completed'),
(44,44,'2026-07-05','10:30:00','Completed'),
(45,45,'2026-07-05','11:00:00','Completed'),
(46,46,'2026-07-05','11:30:00','Pending'),
(47,47,'2026-07-05','12:00:00','Completed'),
(48,48,'2026-07-05','12:30:00','Completed'),
(49,49,'2026-07-05','01:00:00','Cancelled'),
(50,50,'2026-07-05','01:30:00','Completed');

INSERT INTO treatments (appointment_id, diagnosis, treatment_details, medicine) VALUES
(1,'Hypertension','Blood pressure monitoring and lifestyle advice','Amlodipine'),
(2,'Skin Allergy','Anti-allergic treatment','Cetirizine'),
(3,'Knee Pain','Physiotherapy recommended','Paracetamol'),
(4,'Pregnancy Checkup','Routine prenatal examination','Folic Acid'),
(5,'Migraine','Neurological assessment','Sumatriptan'),
(6,'Fever','General examination and hydration','Paracetamol'),
(7,'Ear Infection','Ear cleaning and antibiotics','Amoxicillin'),
(8,'Vision Problem','Eye examination and glasses prescribed','Eye Drops'),
(9,'Depression','Counseling and medication','Sertraline'),
(10,'Viral Fever','Rest and hydration','Paracetamol'),
(11,'Heart Disease','ECG and medication','Aspirin'),
(12,'Acne','Skin treatment','Clindamycin Gel'),
(13,'Back Pain','Pain management','Ibuprofen'),
(14,'Routine Checkup','Pregnancy monitoring','Iron Tablets'),
(15,'Epilepsy','Neurological treatment','Levetiracetam'),
(16,'Cold and Cough','Symptomatic treatment','Cough Syrup'),
(17,'Sinus Infection','ENT consultation','Azithromycin'),
(18,'Cataract','Eye surgery consultation','Eye Drops'),
(19,'Anxiety','Counseling session','Escitalopram'),
(20,'Diabetes','Blood sugar monitoring','Metformin'),
(21,'Chest Pain','Cardiac evaluation','Nitroglycerin'),
(22,'Eczema','Skin cream prescribed','Hydrocortisone Cream'),
(23,'Fracture','Plaster applied','Pain Killer'),
(24,'Routine Pregnancy','Ultrasound performed','Calcium Tablets'),
(25,'Headache','Brain scan advised','Paracetamol'),
(26,'Malaria','Blood test and treatment','Artemether'),
(27,'Tonsillitis','Antibiotic course','Amoxicillin'),
(28,'Myopia','Vision correction','Prescription Glasses'),
(29,'Stress','Therapy session','Fluoxetine'),
(30,'Food Poisoning','IV Fluids administered','ORS'),
(31,'Arrhythmia','Heart rhythm monitoring','Beta Blocker'),
(32,'Psoriasis','Skin therapy','Coal Tar Ointment'),
(33,'Shoulder Pain','Physiotherapy','Diclofenac'),
(34,'Pregnancy Review','Routine examination','Vitamin Supplements'),
(35,'Parkinsonism','Neurological medication','Levodopa'),
(36,'Typhoid','Antibiotics prescribed','Cefixime'),
(37,'Hearing Loss','Audiometry test','Vitamin B Complex'),
(38,'Conjunctivitis','Eye cleaning','Moxifloxacin Drops'),
(39,'Insomnia','Sleep therapy','Melatonin'),
(40,'Gastritis','Diet counseling','Pantoprazole'),
(41,'Heart Failure','Cardiac treatment','Ramipril'),
(42,'Fungal Infection','Antifungal therapy','Fluconazole'),
(43,'Arthritis','Joint pain treatment','Naproxen'),
(44,'Prenatal Care','Routine pregnancy care','Iron Tablets'),
(45,'Stroke Follow-up','Rehabilitation','Clopidogrel'),
(46,'Influenza','Antiviral medication','Oseltamivir'),
(47,'Nasal Allergy','ENT treatment','Levocetirizine'),
(48,'Glaucoma','Eye pressure monitoring','Timolol Eye Drops'),
(49,'Panic Disorder','Psychiatric treatment','Alprazolam'),
(50,'General Checkup','Routine health examination','Multivitamins');

INSERT INTO billing (patient_id, appointment_id, amount, payment_status, bill_date) VALUES
(1,1,1000.00,'Paid','2026-07-01'),
(2,2,700.00,'Paid','2026-07-01'),
(3,3,900.00,'Paid','2026-07-01'),
(4,4,800.00,'Pending','2026-07-01'),
(5,5,1200.00,'Paid','2026-07-01'),
(6,6,600.00,'Paid','2026-07-01'),
(7,7,750.00,'Pending','2026-07-01'),
(8,8,850.00,'Paid','2026-07-01'),
(9,9,950.00,'Paid','2026-07-01'),
(10,10,500.00,'Paid','2026-07-01'),
(11,11,1000.00,'Paid','2026-07-02'),
(12,12,700.00,'Pending','2026-07-02'),
(13,13,900.00,'Paid','2026-07-02'),
(14,14,800.00,'Pending','2026-07-02'),
(15,15,1200.00,'Paid','2026-07-02'),
(16,16,600.00,'Paid','2026-07-02'),
(17,17,750.00,'Pending','2026-07-02'),
(18,18,850.00,'Paid','2026-07-02'),
(19,19,950.00,'Paid','2026-07-02'),
(20,20,500.00,'Pending','2026-07-02'),
(21,21,1050.00,'Paid','2026-07-03'),
(22,22,720.00,'Paid','2026-07-03'),
(23,23,920.00,'Pending','2026-07-03'),
(24,24,820.00,'Paid','2026-07-03'),
(25,25,1250.00,'Paid','2026-07-03'),
(26,26,650.00,'Paid','2026-07-03'),
(27,27,780.00,'Pending','2026-07-03'),
(28,28,870.00,'Paid','2026-07-03'),
(29,29,980.00,'Paid','2026-07-03'),
(30,30,550.00,'Pending','2026-07-03'),
(31,31,1100.00,'Paid','2026-07-04'),
(32,32,750.00,'Pending','2026-07-04'),
(33,33,950.00,'Paid','2026-07-04'),
(34,34,850.00,'Paid','2026-07-04'),
(35,35,1300.00,'Paid','2026-07-04'),
(36,36,700.00,'Pending','2026-07-04'),
(37,37,800.00,'Paid','2026-07-04'),
(38,38,900.00,'Paid','2026-07-04'),
(39,39,1000.00,'Pending','2026-07-04'),
(40,40,600.00,'Paid','2026-07-04'),
(41,41,1150.00,'Paid','2026-07-05'),
(42,42,780.00,'Pending','2026-07-05'),
(43,43,980.00,'Paid','2026-07-05'),
(44,44,900.00,'Paid','2026-07-05'),
(45,45,1350.00,'Paid','2026-07-05'),
(46,46,720.00,'Pending','2026-07-05'),
(47,47,820.00,'Paid','2026-07-05'),
(48,48,920.00,'Paid','2026-07-05'),
(49,49,1050.00,'Pending','2026-07-05'),
(50,50,650.00,'Paid','2026-07-05');

SELECT * FROM patients;
SELECT*FROM doctors;
SELECT*FROM doctors
WHERE specialization='Cardiologist';

#DISPLAY ALL APPOINTMENTS WITH PATIENT AND DOCTOR NAMES:
SELECT
a.appointment_id,
p.name AS Patient_Name,
d.name AS Doctor_Name,
a.status
FROM appointments a
JOIN patients p
ON a.patient_id=p.patient_id
JOIN doctors d
ON a.doctor_id=d.doctor_id;

#FIND TOTAL NUMBER OF APPOINTMENTS PER DOCTOR:
SELECT
d.doctor_id,
d.name,
COUNT(a.appointment_id) AS Total_Appointments
FROM doctors d
LEFT JOIN appointments a
ON d.doctor_id=a.doctor_id
GROUP BY d.doctor_id,d.name;

#FIND TOTAL REVENUE GENERATED PER DECTOR:
SELECT * FROM treatments;
SELECT
    d.doctor_id,
    d.name,
    SUM(t.treatment_cost + d.consultation_fee) AS Revenue
FROM doctors d
JOIN appointments a
    ON d.doctor_id = a.doctor_id
JOIN treatments t
    ON a.appointment_id = t.appointment_id
GROUP BY d.doctor_id, d.name;

ALTER TABLE treatments
ADD COLUMN treatment_cost INT;

UPDATE treatments SET treatment_cost = 1200 WHERE treatment_id = 1;
UPDATE treatments SET treatment_cost = 800 WHERE treatment_id = 2;
UPDATE treatments SET treatment_cost = 1500 WHERE treatment_id = 3;
UPDATE treatments SET treatment_cost = 1800 WHERE treatment_id = 4;
UPDATE treatments SET treatment_cost = 2200 WHERE treatment_id = 5;
UPDATE treatments SET treatment_cost = 700 WHERE treatment_id = 6;
UPDATE treatments SET treatment_cost = 1100 WHERE treatment_id = 7;
UPDATE treatments SET treatment_cost = 1600 WHERE treatment_id = 8;
UPDATE treatments SET treatment_cost = 2500 WHERE treatment_id = 9;
UPDATE treatments SET treatment_cost = 750 WHERE treatment_id = 10;
UPDATE treatments SET treatment_cost = 3500 WHERE treatment_id = 11;
UPDATE treatments SET treatment_cost = 900 WHERE treatment_id = 12;
UPDATE treatments SET treatment_cost = 1400 WHERE treatment_id = 13;
UPDATE treatments SET treatment_cost = 1700 WHERE treatment_id = 14;
UPDATE treatments SET treatment_cost = 3200 WHERE treatment_id = 15;
UPDATE treatments SET treatment_cost = 600 WHERE treatment_id = 16;
UPDATE treatments SET treatment_cost = 1300 WHERE treatment_id = 17;
UPDATE treatments SET treatment_cost = 4500 WHERE treatment_id = 18;
UPDATE treatments SET treatment_cost = 2400 WHERE treatment_id = 19;
UPDATE treatments SET treatment_cost = 2000 WHERE treatment_id = 20;
UPDATE treatments SET treatment_cost = 3800 WHERE treatment_id = 21;
UPDATE treatments SET treatment_cost = 950 WHERE treatment_id = 22;
UPDATE treatments SET treatment_cost = 4200 WHERE treatment_id = 23;
UPDATE treatments SET treatment_cost = 2300 WHERE treatment_id = 24;
UPDATE treatments SET treatment_cost = 2100 WHERE treatment_id = 25;
UPDATE treatments SET treatment_cost = 2600 WHERE treatment_id = 26;
UPDATE treatments SET treatment_cost = 1200 WHERE treatment_id = 27;
UPDATE treatments SET treatment_cost = 1700 WHERE treatment_id = 28;
UPDATE treatments SET treatment_cost = 2300 WHERE treatment_id = 29;
UPDATE treatments SET treatment_cost = 1800 WHERE treatment_id = 30;
UPDATE treatments SET treatment_cost = 3900 WHERE treatment_id = 31;
UPDATE treatments SET treatment_cost = 1400 WHERE treatment_id = 32;
UPDATE treatments SET treatment_cost = 1600 WHERE treatment_id = 33;
UPDATE treatments SET treatment_cost = 2000 WHERE treatment_id = 34;
UPDATE treatments SET treatment_cost = 4100 WHERE treatment_id = 35;
UPDATE treatments SET treatment_cost = 2800 WHERE treatment_id = 36;
UPDATE treatments SET treatment_cost = 2200 WHERE treatment_id = 37;
UPDATE treatments SET treatment_cost = 1000 WHERE treatment_id = 38;
UPDATE treatments SET treatment_cost = 1900 WHERE treatment_id = 39;
UPDATE treatments SET treatment_cost = 1300 WHERE treatment_id = 40;
UPDATE treatments SET treatment_cost = 5000 WHERE treatment_id = 41;
UPDATE treatments SET treatment_cost = 1100 WHERE treatment_id = 42;
UPDATE treatments SET treatment_cost = 2100 WHERE treatment_id = 43;
UPDATE treatments SET treatment_cost = 2400 WHERE treatment_id = 44;
UPDATE treatments SET treatment_cost = 4500 WHERE treatment_id = 45;
UPDATE treatments SET treatment_cost = 1500 WHERE treatment_id = 46;
UPDATE treatments SET treatment_cost = 1200 WHERE treatment_id = 47;
UPDATE treatments SET treatment_cost = 2700 WHERE treatment_id = 48;
UPDATE treatments SET treatment_cost = 2600 WHERE treatment_id = 49;
UPDATE treatments SET treatment_cost = 1000 WHERE treatment_id = 50;

#FIND PATIENTS WHO NEVER BOOKED AN APPOINTMENT:
SELECT*FROM patients
WHERE patient_ID NOT IN 
(
SELECT patient_id FROM appointments
);

#GET TOP 3 HIGHEST BILLING PATIENTS
SELECT*FROM patients;
SELECT*FROM billing;
SHOW TABLES;
SELECT
p.patient_id,
p.name,
SUM(b.amount) AS Total_bill
FROM patients P
JOIN billing b
ON p.patient_id=b.bill_id
GROUP BY p.patient_id,p.name
ORDER BY total_Bill desc 
LIMIT 3;

#CREATE VIEW:
SELECT*FROM doctors;
CREATE VIEW doctor_revenue_summary AS
SELECT
d.doctor_id,
d.name,
SUM(t.treatment_cost+d.consultation_fee) AS Total_Revenue
FROM doctors d
JOIN appointments a
ON d.doctor_id=a.doctor_id
JOIN treatments t
ON a.appointment_id=t.appointment_id
GROUP BY d.doctor_id,d.name;

#TO SEE VIEW
SHOW FULL TABLES
WHERE Table_type = 'VIEW';
SHOW FULL TABLES;
SELECT * FROM doctor_revenue_summary;
SHOW CREATE VIEW doctor_revenue_summary;    #See the SQL used to create the view
DESC doctor_revenue_summary; # OR DESCRIBE doctor_revenue_summary;

#Trigger TO Auto Add Treatment Cost INTO Bill:
DELIMITER $$
CREATE TRIGGER trg_add_treatment_bill
AFTER INSERT ON treatments
FOR EACH ROW
BEGIN
    DECLARE pid INT;

    SELECT patient_id
    INTO pid
    FROM appointments
    WHERE appointment_id = NEW.appointment_id;

    UPDATE bills
    SET total_amount = total_amount + NEW.treatment_cost
    WHERE patient_id = pid;
END$$
DELIMITER ;

#STORED PROCEDURE TO BOOK APPOINTMENT:
SELECT*FROM appointments;
DELIMITER $$
CREATE PROCEDURE BookAppointment
(
IN p_patient INT,
IN p_doctor INT,
IN p_date date,
IN p_time TIME,
IN p_status VARCHAR(20)

)
BEGIN
INSERT INTO appointments
(patient_id,doctor_id,appointment_date,appointment_time,status)

VALUES
(p_patient,p_doctor,p_date,p_time,p_status);
END$$
DELIMITER ;

CALL BookAppointment(50,8,'2026-07-05','09:40:00','Booked');
SELECT * FROM appointments
ORDER BY appointment_id DESC;    #Check that it booked

CALL BookAppointment(51, 8, '2026-07-05', '09:40:00');
DROP PROCEDURE IF EXISTS BookAppointment;



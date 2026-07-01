CREATE DATABASE Gp_University;
USE Gp_University;

#Practice Set1:-
CREATE TABLE student(
student_id INT PRIMARY KEY,
name VARCHAR(50),
age INT,
email VARCHAR(100) UNIQUE
);

ALTER TABLE student
ADD phone_number VARCHAR(15);
ALTER TABLE student
ADD subject VARCHAR(15);

ALTER TABLE student
MODIFY age SMALLINT;

RENAME TABLE student TO students;
RENAME TABLE
student TO students,
teacher TO teachers;

ALTER TABLE student
RENAME TO students;

CREATE TABLE student1(
student_id INT PRIMARY KEY,
name VARCHAR(50),
age INT,
email VARCHAR(100) UNIQUE
);
ALTER TABLE student1
DROP COLUMN email;

ALTER TABLE student
ADD CONSTRAINT chk_age
CHECK(age >=18);

CREATE TABLE course(
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50)
    email VARCHAR(100) UNIQUE
);

ALTER TABLE course
ADD COLUMN room_no INT;

ALTER TABLE course
MODIFY room_no BIGINT;

CREATE TABLE Employee(
emp_id INT PRIMARY KEY,
course_id INT,
email VARCHAR(100) UNIQUE,
FOREIGN KEY(email)
REFERENCES course(email)
);  #Employee table Course table se connected hai.

ALTER TABLE Employee
DROP FOREIGN KEY employee_ibfk_1;
#employee → table name
#ibfk → InnoDB Foreign Key
#1 → first foreign key in that table
TRUNCATE TABLE EMPLOYEE;
#DML (Data Manipulation Language)Data Insert, Update, Delete aur Retrieve karne ke liye.
INSERT INTO student
VALUE
(101,'Rahul',21,'rahul@gmail.com','English','9892838883');

UPDATE student
SET
    subject = 'English',
    phone_number = '9892838883'
WHERE student_id = 101;

INSERT INTO Course
VALUES
(101,'SQL',3),
(102,'Power BI',2),
(103,'Python',4);

SELECT*FROM student;
SELECT name,email
FROM student;

UPDATE student
SET email='new@gmail.com'
WHERE student_id=101;

INSERT INTO student
VALUE
(102,'Aahul',31,'Aahul@gmail.com','Hindi','9892838884');

DELETE FROM student
WHERE student_id=101;

INSERT INTO student
VALUES
(103,'Amit',22,'amit@gmail.com','Maths','9892838885'),
(104,'Priya',20,'priya@gmail.com','Science','9892838886'),
(105,'Rohit',23,'rohit@gmail.com','English','9892838887'),
(106,'Sneha',21,'sneha@gmail.com','Hindi','9892838888'),
(107,'Vikas',24,'vikas@gmail.com','Maths','9892838889'),
(108,'Neha',22,'neha@gmail.com','Science','9892838890'),
(109,'Karan',25,'karan@gmail.com','English','9892838891'),
(110,'Pooja',20,'pooja@gmail.com','Hindi','9892838892'),
(111,'Arjun',23,'arjun@gmail.com','Maths','9892838893'),
(112,'Anjali',21,'anjali@gmail.com','Science','9892838894');

SELECT *
FROM student
ORDER BY age DESC;

SELECT*FROM student
LIMIT 3;

SELECT UPPER(name)
FROM student;

SELECT LEFT(name,3) FROM student;
SELECT REPLACE(name,'Amit','Amitab')
from student;

SELECT name,LENGTH(name)
FROM student;

SELECT CONCAT(name,'-',subject)
FROM student;

ALTER TABLE student
ADD COLUMN salary INT;

UPDATE student
SET salary = 25000
WHERE student_id = 101;

UPDATE student
SET salary = 30000
WHERE student_id = 102;

UPDATE student
SET salary = 28000
WHERE student_id = 103;

UPDATE student
SET salary = 35000
WHERE student_id = 104;

UPDATE student
SET salary = 32000
WHERE student_id = 105;

UPDATE student
SET salary = CASE student_id
    WHEN 106 THEN 25000
    WHEN 107 THEN 30000
    WHEN 108 THEN 28000
    WHEN 109 THEN 35000
    WHEN 110 THEN 32000
END
WHERE student_id IN (106, 107, 108, 109, 110);

ALTER TABLE student
MODIFY salary varchar(50);

SELECT ROUND(salary,-3) FROM employee;

SET SQL_SAFE_UPDATES = 0;

ALTER TABLE student
ADD COLUMN salary_backup VARCHAR(50);
UPDATE student
SET salary_backup = salary;

SELECT ABS(salary-salary_backup)
FROM student;
SELECT salary - salary_backup AS salary_difference
FROM student;

SELECT MOD(salary,5000)
FROM student;

SELECT SQRT(salary)
FROM student;

SELECT YEAR(join_date)
FROM student;

SELECT DATE_ADD(join_date,
INTERVAL 6 MONTH)
FROM employees;

SELECT LAST_DAY(join_date)
FROM employees;

SELECT DATE_FORMAT(join_date,'%d-%m-%Y')
FROM employees;

SELECT SUM(salary)
FROM student;

SELECT*FROM student;
SELECT age,
AVG(salary)
FROM student
GROUP BY age;

SELECT MAX(salary)
FROM student;

SELECT age,
COUNT(*)
FROM student GROUP BY age;

SELECT IF(salary>30000,'A','B')
FROM student;

SELECT IFNULL(salary,0)
FROM student;

SELECT
CASE
WHEN salary>20000 THEN 'A'
WHEN salary>=18000 THEN 'B'
ELSE 'C'
END Grade
FROM student;

#-------------------------------------------------------------------------------------------------------
#Practice Set 3:-
SELECT*
FROM student
WHERE subject='Hindi';
SELECT*FROM student;

SELECT*
FROM student
WHERE subject='Hindi'
AND age>21;

SELECT*
FROM student
WHERE subject='Hindi'
OR subject='English';

SELECT*
FROM student
WHERE salary BETWEEN 22000 AND 35000;

SELECT*
FROM student
ORDER BY salary DESC;

SELECT subject,
COUNT(*)
FROM student
GROUP BY subject;

SELECT subject,
AVG(salary)
FROM student
GROUP BY subject
HAVING AVG(salary)>22000;

SELECT * 
FROM student
LIMIT 3;

SELECT *
FROM student
LIMIT 2 OFFSET 2;

#-------------------------------------PRACTICE SET 4------------------------------------------------------------------------------------------------------------------
#DAX-SUM,IF,CALCULATE,FILTER,SUMX,TOTALYTD,
#-------------------------------------PRACTICE SET 5------------------------------------------------------------------------------------------------------------------
SELECT emp_name,
subject FROM student e
INNER JOIN ;

SELECT*FROM student;

CREATE TABLE departments (
    eid INT PRIMARY KEY,
    ename VARCHAR(50),
    eadd VARCHAR(50),
    esal DECIMAL(10,2),
    dept VARCHAR(30)
);

INSERT INTO departments (eid, ename, eadd, esal, dept) VALUES
(101, 'Rahul', 'Delhi', 45000, 'HR'),
(102, 'Amit', 'Mumbai', 55000, 'IT'),
(103, 'Priya', 'Pune', 60000, 'Finance'),
(104, 'Neha', 'Delhi', 48000, 'HR'),
(105, 'Rohit', 'Jaipur', 70000, 'IT'),
(106, 'Anjali', 'Lucknow', 52000, 'Marketing'),
(107, 'Vikas', 'Chandigarh', 65000, 'Finance'),
(108, 'Sneha', 'Indore', 58000, 'IT'),
(109, 'Karan', 'Bhopal', 75000, 'Sales'),
(110, 'Pooja', 'Patna', 50000, 'HR'),
(111, 'Arjun', 'Delhi', 82000, 'IT'),
(112, 'Meena', 'Nagpur', 47000, 'Marketing'),
(113, 'Deepak', 'Kanpur', 68000, 'Finance'),
(114, 'Ritu', 'Agra', 54000, 'Sales'),
(115, 'Manish', 'Noida', 90000, 'IT'),
(116, 'Kavita', 'Gurgaon', 62000, 'HR'),
(117, 'Suresh', 'Faridabad', 56000, 'Marketing'),
(118, 'Nisha', 'Amritsar', 73000, 'Finance'),
(119, 'Ajay', 'Meerut', 81000, 'Sales'),
(120, 'Shreya', 'Varanasi', 59000, 'IT');
CREATE TABLE employee1 (
    eid INT PRIMARY KEY,
    ename VARCHAR(50),
    eadd VARCHAR(50),
    esal DECIMAL(10,2),
    dept VARCHAR(30)
);

INSERT INTO employee1 (eid, ename, eadd, esal, dept) VALUES
(101, 'Rahul', 'Delhi', 45000, 'HR'),
(102, 'Amit', 'Mumbai', 55000, 'IT'),
(103, 'Priya', 'Pune', 60000, 'Finance'),
(104, 'Neha', 'Delhi', 48000, 'HR'),
(105, 'Rohit', 'Jaipur', 70000, 'IT'),
(106, 'Anjali', 'Lucknow', 52000, 'Marketing'),
(107, 'Vikas', 'Chandigarh', 65000, 'Finance'),
(108, 'Sneha', 'Indore', 58000, 'IT'),
(109, 'Karan', 'Bhopal', 75000, 'Sales'),
(110, 'Pooja', 'Patna', 50000, 'HR'),
(111, 'Arjun', 'Delhi', 82000, 'IT'),
(112, 'Meena', 'Nagpur', 47000, 'Marketing'),
(113, 'Deepak', 'Kanpur', 68000, 'Finance'),
(114, 'Ritu', 'Agra', 54000, 'Sales'),
(115, 'Manish', 'Noida', 90000, 'IT'),
(116, 'Kavita', 'Gurgaon', 62000, 'HR'),
(117, 'Suresh', 'Faridabad', 56000, 'Marketing'),
(118, 'Nisha', 'Amritsar', 73000, 'Finance'),
(119, 'Ajay', 'Meerut', 81000, 'Sales'),
(120, 'Shreya', 'Varanasi', 59000, 'IT');

ALTER TABLE departments
RENAME COLUMN eid TO did;

SELECT * FROM employee1;

SELECT ename, dname
FROM employee1 e
INNER JOIN departments d
ON e.did = d.did;

SELECT *
FROM employee1 e
INNER JOIN departments d
ON e.eid = d.did;

SELECT e.ename, d.dname
FROM employee1 e
INNER JOIN departments d
ON e.eid = d.did;

ALTER TABLE departments
RENAME COLUMN ename TO dname;

SELECT *
FROM employee1 e
LEFT JOIN departments d
ON e.eid = d.did;

SELECT *
FROM employee1 e
RIGHT JOIN departments d
ON e.eid = d.did;

SELECT e.ename,
       e.dept,
       e.esal,
       s.name,
       s.subject
FROM employee1 e
INNER JOIN departments d
ON e.eid = d.did
INNER JOIN student s
ON d.did = s.student_id;

SELECT e.ename,
       s.name,
       s.subject
FROM employee1 e
JOIN departments d
ON e.eid = d.did
JOIN student s
ON d.did = s.student_id;

SELECT * FROM departments;

SELECT dept,
SUM(esal)
from employee e
JOIN departments d
ON e.eid=d.did
GROUP BY dname;

SELECT e.dept,
       SUM(e.esal) AS Total_Salary
FROM employee1 e
JOIN departments d
ON e.eid = d.did
GROUP BY e.dept;

#--------------------------------------------Practice Set=6--------------------------------------------------------------------------------------------------------------------
#Foreign Key & Advanced Join
SELECT *FROM employee1;
SELECT *FROM departments;

FOREIGN KEY (Sno)
REFERENCES employee1(Sno)
ON DELETE CASCADE;

ALTER TABLE departments
ADD CONSTRAINT fk_emp
FOREIGN KEY (Sno)
REFERENCES employee1(Sno)
ON DELETE CASCADE;

ALTER TABLE employee1
ADD COLUMN Sno INT AUTO_INCREMENT UNIQUE;

ALTER TABLE departments
ADD COLUMN Sno INT AUTO_INCREMENT UNIQUE;

UPDATE employee1
SET salary = 25000
WHERE student_id = 101;

SELECT e.ename, e.eadd
FROM employee1 AS e
JOIN departments AS d
ON e.eid = d.did;

CREATE TABLE std (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);

INSERT INTO std VALUES
(101,'Rahul',21),
(102,'Amit',22),
(103,'Priya',20),
(104,'Neha',23),
(105,'Rohit',24);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    fees INT
);

INSERT INTO courses VALUES
(1,'SQL',5000),
(2,'Python',7000),
(3,'Power BI',6000),
(4,'Excel',3000),
(5,'Machine Learning',10000);

UPDATE courses SET course_id = 101 WHERE course_id = 1;
UPDATE courses SET course_id = 102 WHERE course_id = 2;
UPDATE courses SET course_id = 103 WHERE course_id = 3;
UPDATE courses SET course_id = 104 WHERE course_id = 4;
UPDATE courses SET course_id = 105 WHERE course_id = 5;

SELECT *
FROM employee1 e
JOIN departments d
ON e.eid=d.did
JOIN std st
ON st.id=d.did
JOIN courses c
ON c.course_id=st.id;

ALTER TABLE courses
ADD COLUMN price DECIMAL(10,2),
ADD COLUMN quantity INT;

UPDATE courses
SET
    price = CASE course_id
        WHEN 101 THEN 499.99
        WHEN 102 THEN 699.99
        WHEN 103 THEN 599.99
        WHEN 104 THEN 299.99
        WHEN 105 THEN 999.99
    END,
    quantity = CASE course_id
        WHEN 101 THEN 50
        WHEN 102 THEN 40
        WHEN 103 THEN 35
        WHEN 104 THEN 60
        WHEN 105 THEN 25
    END
WHERE course_id IN (101,102,103,104,105);

UPDATE courses
SET price = 499.99, quantity = 50
WHERE course_id = 101;

UPDATE courses
SET price = 699.99, quantity = 40
WHERE course_id = 102;

UPDATE courses
SET price = 599.99, quantity = 35
WHERE course_id = 103;

UPDATE courses
SET price = 299.99, quantity = 60
WHERE course_id = 104;

UPDATE courses
SET price = 999.99, quantity = 25
WHERE course_id = 105;

SELECT *,SUM(price*quantity)
AS Total_Spending
FROM employee1 e
JOIN departments d
ON e.eid=d.did
JOIN std st
ON st.id=d.did
JOIN courses c
ON c.course_id=st.id
group by eid;

#--------------------------------Practice Set 7-------------------------------------------------------------------------------------------------------------------------------
SELECT*FROM employee;
CALL GetEmployees();

-- DELIMITER //
-- CREATE PROCEDURE procedure_name()
-- BEGIN
-- #--SQL STATEMENTS
-- END //
-- DELIMITER ;

SELECT * FROM departments;

SELECT *
FROM departments
WHERE dname IN ('Amit', 'Rahul', 'Priya');

DELIMITER //
CREATE PROCEDURE AddDocument(
    IN p_docid INT,
    IN p_docname VARCHAR(100),
    IN p_category VARCHAR(50)
)
BEGIN
    INSERT INTO documents(doc_id, doc_name, category)
    VALUES(p_docid, p_docname, p_category);
END //
DELIMITER ;

CALL AddDocument(101);

DELIMITER //
CREATE PROCEDURE GetDocCount(
    OUT total_docs INT
)
BEGIN
    SELECT COUNT(*)
    INTO total_docs
    FROM documents;
END //
DELIMITER ;

CALL GetDocCount(@cnt);
SELECT @cnt;

IF condition THEN
SQL Statements
ELSE 
SQL Statements
END IF;

-- CASE
-- WHEN condition THEN result
-- WHEN condition THEN result
-- ELSE result
-- END 

-- START TRANSACTION 
-- COMMIT
-- ROLLBACK
SELECT* FROM employee1;
SELECT SUM(esal)
FROM employee1;

-- DECLARE CURSOR
-- OPEN curser_name;
-- FETCH cursor_name;
-- CLOSE cursor_name;
#--------------------------------Practice Set 8-------------------------------------------------------------------------------------------------------------------------------
Select* from employee1;

DELIMITER $$
CREATE TRIGGER trg_salary_update
AFTER UPDATE ON employee1
FOR EACH ROW
BEGIN
IF OLD.esal <> NEW.esal THEN
INSERT INTO esal_log
(eid,old_esal,new_esal)
VALUES
(OLD.eid,OLD.esal,NEW.esal);
END IF;
END$$
DELIMITER ;

#prevent negative account balance:-
DELIMITER $$
CREATE TRIGGER trg_prevent_negative_balance
BEFORE UPDATE ON employee1
FOR EACH ROW
BEGIN
IF NEW.esal<0 THEN
SIGNAL SQLSTATE '45000'
SET message_text='Balance cannot be negative';
END IF;
END$$
DELIMITER ;

Socho employee1 table me employees ki salary rakhi hui hai.

eid	Name	esal
101	Rahul	30000

Ab kisi ne galti se likh diya:

UPDATE employee1
SET esal = -5000
WHERE eid = 101;

-- Salary negative nahi ho sakti.
-- Isliye BEFORE UPDATE Trigger pehle hi check karega.
-- Line by Line
-- 1.
-- BEFORE UPDATE ON employee1
-- ➡️ Update hone se pehle trigger chalega.

-- 2.
-- FOR EACH ROW
-- ➡️ Har update hone wali row ke liye trigger execute hoga.

-- 3.
-- IF NEW.esal < 0 THEN
-- NEW.esal ka matlab:
-- 👉 Update ke baad jo salary hone wali hai.
-- Agar wo 0 se chhoti hai,
-- jaise
-- -100
-- -500
-- -1000
-- to condition TRUE ho jayegi.

-- 4.
-- SIGNAL SQLSTATE '45000'
-- Ye MySQL ko bolta hai:
-- 🚫 "Error dikhao aur UPDATE ko rok do."
-- 45000 ek custom error code hai.

-- 5.
-- SET MESSAGE_TEXT = 'Balance cannot be negative';
-- User ko ye message dikhai dega:
-- ERROR 1644 (45000):
-- Balance cannot be negative
-- Real Life Example 🎒

-- Socho school me rule hai:
-- Bag ka weight negative nahi ho sakta.
-- Teacher pehle check karta hai.

-- Agar koi bole:
-- Bag Weight = -5 kg

-- Teacher turant bolta hai:
-- ❌ Allowed nahi hai!
-- Bilkul waise hi trigger database ko galat data save hone se pehle rok deta hai.

-- Flow Diagram
-- UPDATE employee1
--        │
--        ▼
-- BEFORE UPDATE Trigger
--        │
--        ▼
-- Is NEW.esal < 0 ?
--       │
--  ┌────┴────┐
--  │         │
-- No        Yes
--  │         │
--  ▼         ▼
-- Update     SIGNAL ERROR
-- Saved      ❌ Update Cancel
-- 🧠 Memory Trick
-- BEFORE UPDATE → Pehle check karo.
-- NEW.esal → Update ke baad wali salary.
-- SIGNAL SQLSTATE '45000' → Custom error dikhao.
-- MESSAGE_TEXT → Error ka message user ko dikhana.
-- Ye trigger ka main purpose hai: database me invalid data (jaise negative salary) save hone se pehle hi
SELECT * FROM employee1;
#AUTOMATICALLY UPDATE ORDER TOTAL

DELIMITER $$
CREATE TRIGGER trg_update_sal_total
BEFORE INSERT ON employee1
FOR EACH ROW
BEGIN
    SET NEW.total_esal = emon * esal;
END$$

DELIMITER ;


ALTER TABLE employee1
ADD COLUMN total_esal INT;

ALTER TABLE employee1
ADD COLUMN emon INT;
UPDATE employee1 SET emon = 1 WHERE eid = 101;
UPDATE employee1 SET emon = 2 WHERE eid = 102;
UPDATE employee1 SET emon = 3 WHERE eid = 103;
UPDATE employee1 SET emon = 4 WHERE eid = 104;
UPDATE employee1 SET emon = 5 WHERE eid = 105;
UPDATE employee1 SET emon = 6 WHERE eid = 106;
UPDATE employee1 SET emon = 7 WHERE eid = 107;
UPDATE employee1 SET emon = 8 WHERE eid = 108;
UPDATE employee1 SET emon = 9 WHERE eid = 109;
UPDATE employee1 SET emon = 10 WHERE eid = 110;
UPDATE employee1 SET emon = 11 WHERE eid = 111;
UPDATE employee1 SET emon = 12 WHERE eid = 112;
UPDATE employee1 SET emon = 1 WHERE eid = 113;
UPDATE employee1 SET emon = 2 WHERE eid = 114;
UPDATE employee1 SET emon = 3 WHERE eid = 115;
UPDATE employee1 SET emon = 4 WHERE eid = 116;
UPDATE employee1 SET emon = 5 WHERE eid = 117;
UPDATE employee1 SET emon = 6 WHERE eid = 118;
UPDATE employee1 SET emon = 7 WHERE eid = 119;
UPDATE employee1 SET emon = 8 WHERE eid = 120;

UPDATE employee1
SET total_esal = esal * emon
WHERE eid=101;

UPDATE employee1
SET total_esal = esal * emon
WHERE eid=102;

UPDATE employee1
SET total_esal = esal * emon
WHERE eid=103;

UPDATE employee1
SET total_esal = esal * emon
WHERE eid=104;
UPDATE employee1
SET total_esal = esal * emon
WHERE eid=105;

#SOFT DELETE LOGGING:
DELIMITER $$
CREATE TRIGGER trg_product_delete
BEFORE DELETE ON employee1
FOR EACH ROW
BEGIN
	INSERT INTO total_esal
    (eid,ename,esal)
    VALUES(OLD.eid,OLD.ename,OLD.esal);
    END$$
    DELIMITER ;

#PREVENT DUPLICATE EMAIL:
DELIMITER $$
CREATE TRIGGER trg_prevent_duplicate_email
BEFORE INSERT ON  employee1
FOR EACH ROW
BEGIN
	IF EXISTS(
    SELECT 1
    FROM employee1
    WHERE eid=NEW.eid
    ) THEN 
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Email already exists';
    END IF;
    END$$
    DELIMITER ;

#STUDENT MARKS AUDIT
DELIMITER $$
CREATE TRIGGER trg_employee_salary_audit
AFTER UPDATE ON employee1
FOR EACH ROW
BEGIN
	IF OLD.esal<>NEW.esal THEN
    INSERT INTO emoployee1_audit
    (eid,OLD_esal,NEW_esal)
    VALUES(OLD.eid,OLD.ename,NEW.esal);
    END IF;
    END$$
    DELIMITER ;

DELIMITER $$
CREATE TRIGGER trg_update_post_timestamp
BEFORE UPDATE ON employee1
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$
DELIMITER ;
#--------------------------------------------------Practice Set 9------------------------------------------------------------------------
#Audit every new employee insertion 
DELIMITER $$
CREATE TRIGGER trg_employee_insert_audit
AFTER INSERT ON employee1
FOR EACH ROW
BEGIN
INSERT INTO audit_employee
(eid,ename,action)
VALUES
(NEW.eid,NEW.ename,'INSERT');
END$$
DELIMITER ;

-- SELECT * FROM employee1;
-- Pehle samjho Trigger kya hota hai?
-- 🎒 Socho tumhare school me ek rule hai:
-- Jab bhi koi naya student admission le, register me automatically entry ho jaye.
-- Koi teacher alag se entry nahi karta.
-- Automatic ho jati hai.
-- Database me isi automatic kaam ko Trigger kehte hain.

-- Aapka Trigger
-- DELIMITER $$
-- Matlab
-- Ab trigger $$ dekhkar khatam hoga.
-- CREATE TRIGGER trg_employee_insert_audit
-- Matlab
-- Ek trigger banao jiska naam hai

-- trg_employee_insert_audit
-- Naam kuch bhi rakh sakte ho.
-- AFTER INSERT ON employee1
-- Matlab
-- Jab bhi
-- employee1 table me
-- naya employee INSERT hoga
-- tab trigger chalega.
-- Socho...
-- Employee table
-- eid	ename
-- 101	Rahul
-- Ab tum insert karte ho

-- INSERT INTO employee1
-- VALUES(102,'Amit','Delhi',50000,'IT',2,5,NULL);
-- Jaise hi ye employee insert hua...
-- Trigger automatically start ho gaya.

-- FOR EACH ROW
-- Matlab
-- Har ek naye employee ke liye trigger alag chalega.
-- Agar
-- 5 employees insert hue
-- to trigger
-- 5 baar chalega.

-- BEGIN
-- Matlab
-- Ab trigger ke andar ka kaam shuru.
-- INSERT INTO audit_employee
-- Iska matlab
-- Audit table me ek entry karo.
-- Audit table ek History Register hota hai.
-- Jaise school me
-- Admission Register
-- (eid,ename,action)

-- Audit table ke columns
-- eid
-- ename
-- action
-- VALUES
-- (
-- NEW.eid,
-- NEW.ename,
-- 'INSERT'
-- );

-- Yeh sabse important part hai.
-- NEW kya hota hai?
-- NEW matlab
-- Jo employee abhi-abhi insert hua hai.

-- Example
-- Tumne insert kiya
-- eid=121
-- ename=Ramesh
-- To
-- NEW.eid
-- ban jayega
-- 121
-- Aur
-- NEW.ename
-- ban jayega
-- Ramesh
-- Aur
-- 'INSERT'
-- Likha jayega
-- taaki future me pata chale
-- ye record
-- Insert hua tha.

-- Audit Table me kya save hoga?
-- Agar tum insert karte ho
-- INSERT INTO employee1
-- VALUES
-- (121,'Ramesh','Delhi',50000,'IT',21,12,600000);

-- Automatically
-- audit_employee table me
-- ye save ho jayega
-- eid	ename	action
-- 121	Ramesh	INSERT

-- Tumne alag se kuch bhi nahi likha.
-- Trigger ne khud kar diya.
-- END $$
-- Matlab
-- Trigger khatam.
-- DELIMITER ;
-- Normal mode me wapas aa jao.
-- Last Line
-- SELECT * FROM employee1;
-- Ye sirf employee table dikhata hai.

-- Output
-- eid	ename	salary
-- 101	Rahul	45000
-- 102	Amit	55000
-- 121	Ramesh	50000

-- Agar audit table dekhni ho to likho:
-- SELECT * FROM audit_employee;
-- Output
-- eid	ename	action
-- 121	Ramesh	INSERT
-- Real Life Example 🎒
-- Socho school me ek Admission Register aur ek History Register hai.

-- 👨‍🎓 Naya student aaya:
-- Ramesh
-- Teacher uska naam Admission Register me likhta hai.

-- Saath hi school ka computer automatically History Register me bhi likh deta hai:
-- Student : Ramesh
-- Action  : INSERT

-- Teacher ko alag se kuch nahi karna padta.
-- Database me ye kaam Trigger karta hai.
-- Memory Trick 🧠
-- INSERT Employee
--         │
--         ▼
-- AFTER INSERT Trigger
--         │
--         ▼
-- NEW.eid
-- NEW.ename
--         │
--         ▼
-- Audit Table
-- Ek line me yaad rakho:
-- Jab bhi employee1 me naya employee add hoga, trigger uski information audit_employee table me automatically save kar dega. Ye audit table ek history book ki tarah kaam karta hai, jisse baad me pata chal sakta hai ki kaun sa employee kab insert hua tha.

#Audit every account update
DELIMITER $$
CREATE TRIGGER trg_employee_update_audit
AFTER UPDATE ON employee1
FOR EACH ROW
BEGIN
INSERT INTO audit_employee
(eid,ename,action)
VALUES
(NEW.eid,NEW.ename,'UPDATE');
END$$
DELIMITER ;

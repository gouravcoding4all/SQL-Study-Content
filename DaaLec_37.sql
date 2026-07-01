#--------------------------Lecture 12-----------------------------------------------------------------------------------------------------------------------------------------------------------------
USE amazon;
SHOW TABLES;
SELECT * FROM employee;
/*
Stored Procedure:-It is a stored query that we can execute wheneverwe want
To execute this stored query you need to call it.
Stored Procedure is same as like user define function in a programming laguage.

Syntax:-
DELEMITER //
CREATE PROCEDURE procedure_name()
BEGIN
		---SQL QUERY;
END	// DELIMETER ;

CALL PROCEDURE_NAME();

DELIMITER //
CREATE PROCEDURE procedure_name(parameter)
BEGIN
		---SQL QUERY;
END	// DELIMITER ;

CALL procedure_name(argument);
*/
DELIMITER $$
CREATE PROCEDURE show_emp()
BEGIN
		SELECT*FROM employee;
END $$ DELIMITER ;

CALL show_emp();

SELECT * FROM employee WHERE eadd='Noida';

DELIMITER //
CREATE PROCEDURE city_emp(address VARCHAR(50))
BEGIN
	SELECT*FROM employee WHERE eadd=address;
END // DELIMITER ;

# You can use IN command also with parameter
DELIMITER //
CREATE PROCEDURE city_emp(IN address VARCHAR(50))
BEGIN
	SELECT*FROM employee WHERE eadd=address;
END // DELIMITER ;

CALL city_emp('Noida');
CALL city_emp('GZB');
CALL city_emp('Delhi');

SET @myname="Rahul";
SELECT @myname;
#I WANT TO STORE TOTAL SALARY IN A VARIABLE
SET @totalSalary = 0;
SELECT sum(esal) FROM employee;

DELIMITER $$
CREATE PROCEDURE sumsalary(OUT salary DECIMAL(10,2))
BEGIN
		SELECT sum(esal) INTO salary
        FROM employee;
END $$ DELIMITER ;
 
 CALL sumsalary(@totalSalary);
 SELECT @totalSalary;
 
 #IN , OUT
 SELECT sum(esal) FROM employee WHERE 
 eadd='Delhi';
 
 DELIMITER //
 CREATE PROCEDURE sal_city(OUT salary
 DECIMAL(10,2),IN address TEXT)
 BEGIN
		SELECT sum(esal) INTO salary
FROM employee WHERE eadd=address;
END // DELIMITER ;

CALL sal_city(@totalSalary,'DELHI');
SELECT @totalSalary;

CALL sal_city(@totalSalary,'Noida');
SELECT @totalSalary;

CALL sal_city(@totalSalary,'GZB');
SELECT @totalSalary;

#---------------------------Lecture 13------------------------------------------------------------------------------------------------------------------------
#Stored Procedure
USE amazon;
SHOW TABLES;
SELECT*FROM employee;

SET @dis=15;
DELIMITER //
CREATE PROCEDURE get_bonus(INOUT amt DECIMAL(10,2))
BEGIN
		SELECT sum(esal)*amt/100 amt FROM employee;
	END // DELIMITER ;

CALL get_bonus(@dis);
SELECT @dis;

#CTE(Common Table Expression)
#CTE IS A TEMPORARY TABLE WHICH WILL WORK WITHIN THE QUERY ONLY.
SELECT*,DENSE_RANK() OVER(ORDER BY esal DESC) AS rnk FROM employee;

WITH newTable AS(
SELECT*FROM employee WHERE esal>80000
)SELECT*FROM newTable;

#Print 2nd Highest Salary of employee
WITH myTable AS(
SELECT*,DENSE_RANK() OVER(ORDER BY esal DESC) AS rnk
FROM employee
)SELECT*FROM myTABLE WHERE RNK=2;

#VIEW
CREATE VIEW noida_emp AS
SELECT*FROM employee WHERE eadd='Noida';

SELECT*FROM noida_emp;
SHOW TABLES;

#---------------------Lecture 14-------------------------------------------------------------------------------------------------------------------------------
/*
TCL:Transaction Control Language
*/
USE amazon;

CREATE TABLE Bank (
    Account_No INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    Branch VARCHAR(50),
    Account_Type VARCHAR(20),
    Balance DECIMAL(10,2)
);


INSERT INTO Bank
VALUES
(1001, 'Rahul Sharma', 'Delhi', 'Savings', 50000.00),
(1002, 'Priya Singh', 'Mumbai', 'Current', 75000.00),
(1003, 'Amit Kumar', 'Lucknow', 'Savings', 25000.00),
(1004, 'Neha Verma', 'Jaipur', 'Current', 90000.00),
(1005, 'Rohan Gupta', 'Chandigarh', 'Savings', 45000.00);

SHOW TABLES;
SELECT*FROM accouts;
SELECT*FROM Bank;

START TRANSACTION;
UPDATE Bank SET Balance=Balance-20000 where Account_No=1001;
UPDATE Bank SET Balance=Balance+20000 where Account_No=1002;
COMMIT;
ROLLBACK;
/*ROLLBACK ka use SQL mein kisi transaction ke dauran kiye gaye changes ko undo (wapas) karne ke liye hota hai.
Agar aapne galti se data INSERT, UPDATE, ya DELETE kar diya ho aur abhi tak COMMIT nahi kiya hai, to ROLLBACK command se database ko uski pehli wali state mein laa sakte hain.
Syntax
ROLLBACK;
Example
Maan lijiye Bank table mein account balance update karte hain:
START TRANSACTION;
UPDATE Bank
SET Balance = Balance - 5000
WHERE Account_No = 1001;

UPDATE Bank
SET Balance = Balance + 5000
WHERE Account_No = 1002;
Ab agar aapko lage ki transaction galat ho gayi hai:
ROLLBACK;
Result: Dono UPDATE cancel ho jayenge aur balances pehle jaise ho jayenge.

COMMIT vs ROLLBACK
Command	Kaam
COMMIT	Changes permanently save karta hai
ROLLBACK	Changes ko cancel karke purani state mein le jata hai
Real-Life Example
Socho aap bank se ₹5000 transfer kar rahe ho:
Account A se ₹5000 deduct hua.
Account B mein add karne se pehle system crash ho gaya.

Aisi situation mein:
ROLLBACK;
poora transaction cancel ho jayega, taaki paise na loss hon aur data consistent rahe.
Important Point
COMMIT;
karne ke baad:
ROLLBACK;
kaam nahi karega, kyunki changes already permanently save ho chuke hote hain.
Simple yaad rakho:
👉 COMMIT = Save Changes
👉 ROLLBACK = Undo Changes*/
SELECT*FROM Bank;
/*
ACID
A-Automicity(All OR Nothing)
C-Consistency
I-Isolation
D-Durability(Once Commited, data is permanently saved)
*/
SET SQL_SAFE_UPDATES = 0;
START TRANSACTION;
UPDATE Bank SET Balance=Balance-5000 WHERE Account_No=1003;
UPDATE Bank SET Balance=Balance+5000 WHERE Account_No=1003;
SAVEPOINT SP1;
UPDATE Bank SET Balance=Balance-7000 WHERE Account_No=1004;
UPDATE Bank SET Balance=Balance+7000 WHERE Account_No=1004;
COMMIT;
ROLLBACK TO SP1;
ROLLBACK;
SELECT*FROM Bank;
#-------------------------------------Lecture 15------------------------------------------------------------------------------------------------------------------
USE amazon;
SHOW TABLES;
SELECT*FROM employee;

#1st Highest
SELECT max(esal) FROM employee;

#2nd Highest
SELECT max(esal)FROM employee;
SELECT esal
FROM employee
ORDER BY esal DESC
LIMIT 2 OFFSET 1;
SELECT max(esal) FROM employee WHERE esal<79367.36;

#SUB-QUERY
SELECT max(esal) FROM employee
WHERE esal<(SELECT max(esal) FROM employee);
SELECT *FROM employee;

#INDEX
#PRIMARY KEY
#UNIQUE
#Custom INDEX

SELECT* FROM employee WHERE eadd='Noida'; #Slow
CREATE INDEX eadd_idx
ON employee(esal);
SELECT * FROM employee WHERE eadd='Noida'; #FAST AFTER CREATING INDEX
SELECT * FROM employee WHERE esal>70000; #SLOW
CREATE INDEX esal_idx
ON employee(esal);
SELECT * FROM employee WHERE esal>70000; #FAST AFTER CREATING INDEX
#INDEX increases THE SPEED OF SELECT QUERY
SELECT*FROM employee WHERE esal>70000 AND eadd=Delhi; #Slow
CREATE INDEX sal_add_idx
ON employee(eadd,esal);
SELECT*FROM employee WHERE esal>70000 AND eadd='DELHI';

#CURSOR
SELECT * FROM employee;

DELIMITER //
CREATE PROCEDURE show_emp_name()
BEGIN 
		DECLARE done INT DEFAULT FALSE;
        DECLARE emp_name VARCHAR(100);

		DECLARE emp_cur CURSOR FOR 
		SELECT ename FROM employee;
        
        DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET DONE = TRUE;
        
        OPEN emp_cur;
        read_loop:LOOP
					FETCH emp_cur INTO emp_name;
				IF done THEN
							LEAVE read_loop;
						END IF;
				SELECT emp_name;
			END LOOP;
            CLOSE emp_cur;
		END // DELIMITER ;

SELECT * FROM employee;
CALL show_emp_name();

#-------------------------------------------------------------------------------------------------------------------------------------------
-- Select Database
USE amazon;

-- Create Customer Table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(50)
);

INSERT INTO Customer
(customer_id, customer_name, email, phone, city)
VALUES
(101, 'Amit Sharma', 'amit@gmail.com', '9876543210', 'Delhi'),
(102, 'Priya Verma', 'priya@gmail.com', '9876543211', 'Mumbai'),
(103, 'Rahul Singh', 'rahul@gmail.com', '9876543212', 'Lucknow'),
(104, 'Neha Gupta', 'neha@gmail.com', '9876543213', 'Jaipur'),
(105, 'Rohit Kumar', 'rohit@gmail.com', '9876543214', 'Patna'),
(106, 'Anjali Yadav', 'anjali@gmail.com', '9876543215', 'Kanpur'),
(107, 'Vikas Mishra', 'vikas@gmail.com', '9876543216', 'Bhopal'),
(108, 'Pooja Jain', 'pooja@gmail.com', '9876543217', 'Indore'),
(109, 'Karan Malhotra', 'karan@gmail.com', '9876543218', 'Chandigarh'),
(110, 'Sneha Roy', 'sneha@gmail.com', '9876543219', 'Kolkata');

SELECT * FROM Customer;

#Backup And Recovery
#How to make a backup file of a database's table 
#we need to perform a command line
/*
mysqldump -u root -p database.table > anyname.sql;
*/
DROP DATABASE amazon;
#WE need to perform one more command on command line to recover the data
/*
mysql -u root -p databasename < anyname.sql
*/

/*
Trigger Practice
*/
USE amazon;
SHOW TABLES;
SELECT * FROM emp_log;
INSERT INTO emp_log(empid,empname,tme_)
VALUE(102,'Ravi',current_timestamp());

DELIMITER //
CREATE TRIGGER ins_emp
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
INSERT INTO emp_log(empid,empname,tme_)
VALUE(102,'Ravi',current_timestamp());
END // DELIMITER ;

SHOW TRIGGERS;
SHOW TRIGGERS FROM amazon;

INSERT INTO employee(eid,ename) VALUE(101,'Raman');

DELIMITER //
CREATE PROCEDURE emp_ins1(IN id INT , IN name VARCHAR(100))
BEGIN
INSERT INTO employee(eid,ename) VALUE(id,name);
END // DELIMITER ;

CALL emp_ins1(102,'Raju');



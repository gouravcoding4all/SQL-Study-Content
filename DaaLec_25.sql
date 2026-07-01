#Single Line Comment
/* 
Multi
Line
Comment
For Explaination
*/

#SQL : Structure Query Language
#SQL works on Commands
# DDL ,DML ,TCL,DCL

#DDL: Data Definition Language ( to create Schema (Structure of Database))
#Create, Drop,Alter

#How to Create a Database
#Syntax:-
#CRAEATE DATABASE database_name;
CREATE DATABASE daa1;

#Delete A database
#syntax:-
#DROP DATABASE database_name;
DROP DATABASE daa1;

#SQL IS NOT CASE-SENSITIVE (a=A)

#USE/SECLECTED database
#USE database_name;
USE daa1;

#CREATE TABLE
#CREATE TABLE table_name( col1 DataType , col2 DataType ... );
CREATE TABLE student(sid INT, sname TEXT ,sadd TEXT);

#ADD  a New Column
ALTER TABLE student ADD COLUMN email TEXT;

#DELETE A Column
ALTER TABLE student DROP COLUMN sadd;

#DELETE TABLE
DROP TABLE student;
#LECTURE 26
DROP DATABASE my_db_name;
CREATE DATABASE college;
USE college;
CREATE TABLE student1(
sid INT ,
sname TEXT ,
sadd TEXT ,
semail TEXT
);
ALTER TABLE student1 ADD COLUMN smob TEXT;
DESCRIBE student1;

ALTER TABLE student1 DROP COLUMN semail;
#Change Datatype of a column smob(text)-> int
ALTER TABLE student MODIFY smob INT;

# DML : Data Manipulation Language
#SELECT , DELETE , UPDATE , INSERT

#INSERT 
#INSERT INTO table_name value(val1,val2,val3..);
INSERT INTO student1 VALUE(101,'Rahul Kumar','Noida 16',278337823);

#SELECT (to read Data)
#select col1,col2.. FROM table_name;
SELECT sid,sname,sadd,smob FROM student1;
SELECT * FROM student1;
SELECT sid,sname FROM STUDENT1;

#INSERT
INSERT INTO student1 value(102,'Siya  Singh','Delhi',86238);
#insert into table(col1,col2) value(val1, val2);
INSERT INTO student1(sid,sname,smob) value(103,'Monu Sing',897368);

INSERT INTO student1(sid,sname,sadd) value(104,'Anu','Noida');
SELECT *FROM student1;

INSERT INTO student1 VALUES
(105,'Ravi','Noida',82563834),
(106,'Rohit','Delhi',3784734),
(107,'Shubham','Noida',862348);

SELECT *FROM student1;

INSERT INTO student1 value (103,'Gouri','Goa',825384874);

SET SQL_SAFE_UPDATES = 0;
#UPDATE
#update table_name SET col_name = value;
UPDATE student1 SET sadd = 'GZB' WHERE sid=104;
UPDATE student1 SET smob = 99999999 WHERE sname='Anu';

#DELETE
#DELETE FROM table_name;
DELETE FROM  student1 WHERE sid=106;

# Lecture=>3
/*
Data Types
TINYINT		1 Byte		-128 TO 127
SMALLINT	2 Byte		-32K TO 32K
MEDIUMINT	3 Byte		-8M TO 8M
INT			4 Byte		-2.27B TO 2.47B
BIGINT		8 Byte		HUGE NUMBER

FLOAT		Appropriate
DOUBLE		Appropriate,Slower
DECIMAL		EXACT EX DECIMAL(10,2)	99999999.99

Textual Data
TINYTEXT - 255 Character
TEXT - 255 Character
MEDIUMTEXT - 16MB
LONGTEXT - 4GB
CHAR - 255 Character(Faster)
VARCHAR - 65K(Faster/Variable) EX VARCHAR(20)
*/

SET SQL_SAFE_UPDATES = 0;

CREATE DATABASE school;
USE school;
#PRIMARY KEY - No Duplicate , No Null ,Foreign Key
#UNIQUE		 - No Duplicate
CREATE TABLE student(
sid INT PRIMARY KEY AUTO_INCREMENT ,
sname VARCHAR(50) NOT NULL ,
sadd VARCHAR(100) NOT NULL ,
smob VARCHAR(15) ,
semail VARCHAR(50) NOT NULL ,
sfee DECIMAL(8,2) NOT NULL , #999999.99
sage TINYINT CHECK(sage>9) ,
sstatus VARCHAR(10) DEFAULT "ACTIVE"
);

INSERT INTO student(sname ,sadd , semail, sfee , sage)
VALUE('Mohan','Noida','mohan123@gmail.com',37574.67,22);

SELECT * FROM student;

CREATE TABLE trainer(
tid INT PRIMARY KEY,
tname VARCHAR(100) NOT NULL,
tmob BIGINT UNIQUE AUTO_INCREMENT
);

INSERT INTO trainer(tid,tname,tmob)
VALUE(101,'Raman',9263899233);
INSERT INTO trainer(tid,tname)
VALUE(104,'Mohit');

SELECT*FROM TRAINER;
#-------------------------------------------------------
#Lecture 4

DROP DATABASE amazon;
CREATE  DATABASE amazon;
USE amazon;
CREATE TABLE employee(
eid INT PRIMARY KEY AUTO_INCREMENT ,
ename VARCHAR(50) NOT NULL,
eadd VARCHAR(50),
esal DECIMAL(8,2) DEFAULT 0.0
);
DESCRIBE employee;

INSERT INTO employee VALUE(101,'RAHUL KUMAR','Noida',63457.45);
SELECT*FROM employee;
INSERT INTO employee(ename,eadd,esal) 
VALUE('Raman','GZB',273667);

INSERT INTO employee(ename,eadd,esal) VALUES
('Riya Kumari','Delhi',76384.34),
('Sanjay','Noida',83648.56),
('Ravi',NULL,67456.67),
('Ramandeet','Delhi',37446.45),
('Ramanjeet','Noida',Null);

SELECT *FROM employee;
INSERT INTO employee(ename) VALUE('Siya Singh');

#UPDATE
#UPDATE table_name SET column=value WHERE condition;
SELECT * FROM employee;
SELECT * FROM employee WHERE esal>70000;

UPDATE employee SET eadd='Delhi'; #it will change entire column
UPDATE employee SET eadd='Delhi' WHERE ename='Ravi';

SET SQL_SAFE_UPDATES = 0;

UPDATE employee SET eadd='Pune' WHERE eid=105;
SELECT * FROM employee;

#---------------------
#DDL , DML
#Aggregation Functions
#sum , count , max , avg
SELECT*FROM employee;
SELECT esal FROM employee;
SELECT SUM(esal) FROM employee;
SELECT MAX(esal) FROM employee;
SELECT MIN(esal) FROM employee;
SELECT AVG(esal) FROM employee;	# count values
SELECT COUNT(eadd) FROM employee; # count rows

SELECT eadd FROM employee;
SELECT DISTINCT eadd FROM employee;
SELECT COUNT(DISTINCT eadd) FROM employee;

#Increase Salary of All Employees by 1k
UPDATE employee SET esal = esal + 1000;
SELECT * FROM employee;

#Order By
SELECT*FROM employee;
SELECT*FROM employee ORDER BY esal;
SELECT*FROM employee ORDER BY esal ASC;
SELECT*FROM employee ORDER BY esal DESC;

#Limit
SELECT*FROM employee;
SELECT * FROM employee LIMIT 3;
SELECT * FROM employee ORDER BY esal DESC;

#SHOW 3 employee who are making highest salary
SELECT * FROM employee;
SELECT * FROM employee ORDER BY esal DESC;
SELECT * FROM employee ORDER BY esal DESC LIMIT 3;

#---------------------------------------------------------------------------------------
#Lecture=5
#Joins
/*
Database(store)
customer(cid,cname,cmob,cadd)
product(pid,pname,price)
orders(oid,cid,pid,qty)
*/
CREATE DATABASE  store;
USE store;
CREATE TABLE customer(
cid INT PRIMARY KEY AUTO_INCREMENT ,
cname VARCHAR(100) NOT NULL,
cadd VARCHAR(100) NOT NULL,
cmob VARCHAR(15) NOT NULL
);

INSERT INTO customer Values
(101,'Raman Singh','Noida','+9188773'),
(102,'Siya SIngh','Delhi','+91934647765'),
(103,'Riya Kumar','Noida','+91833844748'),
(104,'Yogesh Saini','Delhi','+91783738');
SELECT*FROM customer;

CREATE TABLE product(
pid INT PRIMARY KEY AUTO_INCREMENT,
pname VARCHAR(100) NOT NULL,
price DECIMAL(8,2)
);

INSERT INTO product VALUES
(501,'Monitor',5290),
(502,'Keyboard',1930),
(503,'Mouse',870),
(504,'SSD',8560);
SELECT*FROM product;

CREATE TABLE orders(
oid INT PRIMARY KEY AUTO_INCREMENT,
cid INT NOT NULL,
pid INT NOT NULL,
qty INT DEFAULT 1
);

INSERT INTO orders(cid,pid,qty) VALUES
(102,504,5),
(103,502,6),
(104,508,8),
(109,501,5);

SELECT * FROM ORDERS;
#joins
#CROSS JOIN /JOIN ( EVERY ROW OF FIRST TABLE WITH EVERY ROW OF ANOTHER TABLE )
SELECT * FROM customer
JOIN orders;

SELECT * FROM customer
CROSS JOIN orders;

#INNER JOIN/JOIN(COMMON DATA )
SELECT*FROM customer
JOIN orders
USING (cid);

SELECT * FROM customer
INNER JOIN orders
USING(cid);

SELECT * FROM customer;
SELECT * FROM orders;

SELECT *FROM customer
JOIN orders
ON customer.cid = orders.cid;

SELECT* FROM customer AS c
JOIN orders AS o
ON c.cid = o.cid;

SELECT * FROM customer c
JOIN orders o
ON  c.cid = o.cid;

SELECT* FROM customer c
JOIN orders o
ON c.cid=o.cid
JOIN product p
ON o.pid = p.pid;

SELECT c.*,pname,price,qty
FROM customer c 
JOIN orders o
ON c.cid=o.cid
JOIN product p
ON o.pid = p.pid;

SELECT c.*,pname,price,qty,price*qty AS Amount,price*qty*0.18 AS GST,
price*qty+ price*qty*0.18 AS NetAmount
FROM customer c 
JOIN orders o 
ON c.cid = o.cid
JOIN product p
ON o.pid = p.pid;

#left join / left outer join
SELECT * FROM customer
LEFT JOIN orders
ON customer.cid = orders.cid;

SELECT * FROM customer;
SELECT * FROM orders;

SELECT*FROM customer
LEFT OUTER JOIN orders
ON customer.cid = orders.cid;

#RIGHT JOIN / RIGHT OUTER JOIN
SELECT*FROM customer
RIGHT JOIN orders
ON customer.cid =orders.cid;

SELECT*FROM customer
RIGHT OUTER JOIN orders
ON customer.cid = orders.cid;

#FULL JOIN / FULL OUTER JOIN(DO NOT SUPPORT IN MYSQL)
#WE CAN PERFORM FULL OUTER JOIN IN MYSQL USING UNION
SELECT*FROM customer LEFT JOIN orders
ON customer.cid = orders.cid
UNION
SELECT*FROM customer RIGHT JOIN orders
ON customer.cid = orders.cid;

#SELF JOIN 4*4=16 rows
SELECT*FROM customer c1
JOIN customer c2;

SELECT*FROM customer c1
JOIN customer c2 USING (cid);

SELECT*FROM customer c1
JOIN customer c2 ON c1.cid = c2.cid;

DROP DATABASE college;
CREATE DATABASE IF  NOT EXISTS college;
USE college;
CREATE TABLE student(
sid INT PRIMARY KEY AUTO_INCREMENT,
sname VARCHAR(100) NOT NULL,
sadd VARCHAR(100) NOT NULL,
cid INT NOT NULL
);

INSERT INTO student VALUES
(101,'Rahul Kumar','Noida',302),
(102,'Harish Kumar','Delhi',301);
SELECT * FROM student;

CREATE TABLE course(
cid INT PRIMARY KEY AUTO_INCREMENT,
cname VARCHAR(100) NOT NULL,
cfee DECIMAL(8,2)
);
INSERT INTO course VALUES
(301,'Python Full Stack','64260'),
(302,'Data Engineering','54820');
SELECT * FROM course;

SELECT*FROM student;
SELECT*FROM student 
JOIN course
USING(cid);

SELECT*FROM student
JOIN course
ON student.cid=course.cid;

INSERT INTO student VALUE(103,'Ramandeep','GZB',303);
SELECT*FROM student;

#FOREIGN KEY
#IS USE TO CREATE A RELATIONSHIP B/W TWO TABLES INTERNALLY
DROP DATABASE college;
CREATE DATABASE IF NOT  EXISTS college;
USE college;

CREATE TABLE course(
cid INT PRIMARY KEY AUTO_INCREMENT,
cname VARCHAR(100) NOT NULL,
cfee DECIMAL(8,2)
);

CREATE TABLE student(
sid INT PRIMARY KEY AUTO_INCREMENT,
sname VARCHAR(100) NOT NULL,
sadd VARCHAR(100) NOT NULL,
cid  INT NOT NULL,
FOREIGN KEY (cid) REFERENCES course(cid)
);

INSERT INTO course VALUES
(301,'Data Engineering',72300),
(302,'Python DSA',34800);
SELECT*FROM course;

INSERT INTO student VALUE(101,'Raman','Noida',301);
SELECT*FROM student;

DELETE FROM course WHERE cid=301; #NOT POSSIBLE(USING THIS CID)
DELETE FROM course WHERE cid=302; #POSSIBLE
UPDATE course SET cid=305 WHERE cid=301; #NOT POSSIBLE(USING THIS CID)
UPDATE course SET cid=305 WHERE cid=302;

DROP DATABASE college;
CREATE DATABASE IF NOT EXISTS college;
USE college;

CREATE TABLE course(
cid INT PRIMARY KEY AUTO_INCREMENT,
cname VARCHAR(100) NOT NULL,
cfee DECIMAL(8,2)
);

CREATE TABLE student(
sid INT PRIMARY KEY AUTO_INCREMENT ,
sname VARCHAR(100) NOT NULL,
sadd VARCHAR(100) NOT NULL,
cid INT NOT NULL,
FOREIGN KEY(cid) REFERENCES course(cid) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO course VALUES
(301,'Data Engineering',72300),
(302,'Python DSA',34800);
SELECT*FROM course;

INSERT INTO student VALUE(102,'Raman','Noida',306);  #CANNOT CHANGE DUE TO FOREIGN KEY RELATION
SELECT*FROM student;
UPDATE course SET cid=301 WHERE cid=302;  #CANNOT CHANGE DUE TO FOREIGN KEY RELATION

UPDATE course SET cid=302 WHERE Sid=101;  #CANNOT CHANGE DUE TO FOREIGN KEY RELATION
DELETE FROM course WHERE cid=305;
DELETE FROM course WHERE cid=301;

DESCRIBE student;
ALTER TABLE student MODIFY cid INT NOT NULL; #CHANGE DATATYPE
SHOW CREATE TABLE student; #check foregin key name 

#--------------------------------------------------------------
# Lecture 7
#Clauses
USE amazone;
SHOW TABLES;
SELECT*FROM employee;
UPDATE employee SET eadd='Nagpur' WHERE eadd IS NULL;
UPDATE employee SET esal=46552 WHERE esal=0;

#AGGREGATE FUNCTIONS
#SUM,MAX,MIN, COUNT,AVG
SELECT esal FROM employee;
SELECT MAX(esal) FROM employee;
SELECT MIN(esal) FROM employee;
SELECT SUM(esal) FROM employee;
SELECT COUNT(esal) FROM employee;
SELECT AVG(esal) FROM employee;
SELECT * FROM employee ORDER BY esal DESC LIMIT 3;

#DISTINCT
SELECT eadd FROM employee;
SELECT DISTINCT eadd FROM employee;

#GROUPBY
SELECT COUNT(eadd) FROM employee; 
SELECT COUNT(eadd) FROM employee GROUP BY eadd; 
SELECT eadd,COUNT(eadd) FROM employee GROUP BY eadd; 

SELECT SUM(esal) FROM employee;
SELECT eadd,SUM(esal)FROM employee GROUP BY eadd;

#ORDER BY
SELECT * FROM employee; 
SELECT * FROM employee ORDER BY esal; #DEFAULT ASC
SELECT * FROM employee ORDER BY esal ASC;
SELECT * FROM employee ORDER BY esal DESC;

# GROUP BY + ORDER BY
SELECT eadd,SUM(esal) FROM employee GROUP BY eadd;
SELECT eadd,SUM(esal) FROM employee GROUP BY eadd ORDER BY SUM(esal);
SELECT eadd,SUM(esal) AS Salary FROM employee GROUP BY eadd ORDER BY Salary;
#LIMIT
SELECT * FROM  employee;
SELECT * FROM employee LIMIT 3;
SELECT *FROM employee LIMIT 2;

#HIGHEST SALARY'S EMPLOYEE
SELECT*FROM employee ORDER BY esal DESC LIMIT 1;
#2ND HIGHEST SALARY'S EMPLOYEE
SELECT*FROM employee ORDER BY esal DESC LIMIT 1 OFFSET 1;
#3RD HIGHEST SALARY'S EMPLOYEE
SELECT*FROM employee ORDER BY esal DESC LIMIT 1 OFFSET 2;

-- SELECT *
-- FROM employee
-- ORDER BY esal DESC
-- LIMIT 1 OFFSET n;
-- ORDER BY esal DESC → sorts salaries from highest to lowest.
-- OFFSET n → skips the first n rows.
-- LIMIT 1 → returns only one row after skipping.
-- Example
-- Suppose salaries are:
-- Emp	Salary
-- A	90000
-- B	80000
-- C	70000
-- D	60000

-- After:
-- SELECT * FROM employee
-- ORDER BY esal DESC;

-- Result:
-- Rank	Emp	Salary
-- 1	A	90000
-- 2	B	80000
-- 3	C	70000
-- 4	D	60000
-- 2nd Highest Salary Employee
-- SELECT *
-- FROM employee
-- ORDER BY esal DESC
-- LIMIT 1 OFFSET 1;
-- Skip 1 row (A)
-- Return next 1 row (B)
-- Result: B (80000)

-- 3rd Highest Salary Employee
-- SELECT *
-- FROM employee
-- ORDER BY esal DESC
-- LIMIT 1 OFFSET 2;
-- Skip 2 rows (A, B)
-- Return next 1 row (C)

-- Result: C (70000)
-- General Formula
-- Nth highest salary employee:

-- SELECT *
-- FROM employee
-- ORDER BY esal DESC
-- LIMIT 1 OFFSET N-1;

-- Examples:
-- 1st highest → OFFSET 0
-- 2nd highest → OFFSET 1
-- 3rd highest → OFFSET 2
-- 5th highest → OFFSET 4

# WHERE
SELECT*FROM employee WHERE esal>70000

#HAVING
SELECT eadd, SUM(esal) FROM employee GROUP BY eadd;
SELECT eadd, SUM(esal) FROM employee GROUP BY eadd;
# YOU CAN NOT USE WHERE AFTER THE GROUP BY
#SELECT eadd,SUM(esal) FROM employee GROUP BY eadd WHERE SUM(esal)>50000;
SELECT eadd, SUM(esal) FROM employee GROUP BY eadd HAVING SUM(esal)>80000;

SELECT * FROM employee HAVING esal>70000;
SELECT eadd,SUM(ESAL) FROM employee WHERE esal>70000 GROUP BY eadd; 
SELECT eadd,SUM(ESAL) FROM employee WHERE esal>70000 GROUP BY eadd HAVING  SUM(esal)>100000;
SELECT eadd,SUM(ESAL) FROM employee WHERE esal>70000 GROUP BY eadd HAVING  eadd='Noida';

#LIKE + WILDCARDS(%(MULTI CHARACTER),_(ONE CHARACTER))
SELECT *FROM employee; #➡️ Displays all records from the employee table.
SELECT *FROM employee WHERE eadd='Nagpur'; #➡️ Shows employees whose address (eadd) is exactly Nagpur.
SELECT *FROM employee WHERE eadd LIKE 'Nagpur'; #➡️ Same as above. LIKE without wildcards works like =.
SELECT *FROM employee WHERE eadd LIKE 'N%'; #➡️ Address starts with N.Examples: Nagpur, Nashik, Noida.
SELECT *FROM employee WHERE eadd LIKE 'Na%'; #➡️ Address starts with Na.Examples: Nagpur, Nashik.
SELECT *FROM employee WHERE eadd LIKE 'Nag%'; #➡️ Address starts with Nag.Examples: Nagpur, Nagaon.
SELECT *FROM employee WHERE eadd LIKE '%1%'; #➡️ Address contains 1 anywhere.Examples: A1 Colony, 123 Road.
SELECT *FROM employee WHERE esal LIKE '%1'; #➡ Salary ends with 1.Examples: 5001, 12001.
SELECT *FROM employee WHERE eadd LIKE '4%'; #➡️ Address starts with 4.Examples: 4th Street, 401 Colony.
SELECT *FROM employee WHERE eadd LIKE '_a%'; #➡️ Second character must be a.Examples: Nagpur (N-a-gpur), Jaipur (J-a-ipur).

-- Wildcards
-- % → Any number of characters (0, 1, or many)
-- Example: 'N%' → N, Na, Nagpur, Nashik
-- _ → Exactly one character
-- Example: '_a%' → Second character is a

-- Memory Trick:
-- % = Many characters
-- _ = One character only

#AND ,OR ,NOT
SELECT *FROM  employee;
SELECT*FROM employee WHERE eadd='Noida';
SELECT*FROM employee WHERE eadd='Nanital' OR eadd='Delhi' OR eadd='GZB';
SELECT*FROM employee WHERE eadd='Noida' OR esal>70000;
SELECT*FROM employee WHERE eadd='Noida' AND esal>70000;
SELECT*FROM employee WHERE NOT eadd='Noida';


#-------------------------------------------------------------
#Lecture=8
/*
Functions
-Aggregate Functions
sum , max , min , count , avg
SQL aggregation is the process of collecting multiple values from rows to return a single, summarized value.
*/
USE amazon;
SHOW TABLES;
SELECT * FROM employee;
SELECT esal FROM employee;
SELECT sum(esal) FROM employee;
SELECT max(esal) FROM employee;
SELECT min(esal) FROM employee;
SELECT avg(esal) FROM employee; 
SELECT count(esal) FROM employee;

# - String Functions
# upper ,lower
SELECT ename , upper(ename) FROM employee;
SELECT ename , lower(ename) FROM employee;
SELECT ename , length(ename) FROM employee;
SELECT CONCAT(ename,'-',eadd) FROM employee;
SELECT eadd , SUBSTRING(eadd,1,3) FROM employee;
SELECT eadd , UPPER(SUBSTRING(eadd,1,3)) FROM employee;
SELECT eadd , REPLACE(eadd,'Nainital','Haldwani') FROM employee;
SELECT REPLACE('Hello','Ranjeet','Kumar'); #Replace value
/*REPLACE(original_string, old_text, new_text)
original_string → जिस text में बदलाव करना है
old_text → जिसे ढूंढकर बदलना है
new_text → नया text जो replace होगा
आपकी query:
SELECT REPLACE('Hello','Ranjeet','Kumar');
इसका मतलब है:
Original String = 'Hello'
Search Text = 'Ranjeet'
Replace With = 'Kumar'
SQL 'Hello' के अंदर 'Ranjeet' को ढूंढेगा। लेकिन 'Hello' में 'Ranjeet' है ही नहीं, इसलिए कोई replacement नहीं होग।
*/
SELECT'aman';
SELECT TRIM('   aman  ');	#Remove Extra Spaces
#NUMERICAL FUNCTIONS
SELECT esal FROM  employee;
SELECT esal , ROUND(esal,0) FROM employee; #Normal Rounding(0.0-0.4 down , 0.5-0.9 upside)
SELECT esal , ROUND(esal,1) FROM employee;
SELECT esal , CEIL(esal) FROM employee; # upisde roundoff ,0.51 to 1.00 =1
SELECT esal , FLOOR(esal) FROM employee;  #DOWNSIDE  ROUND OFF
SELECT MOD(11,4);
SELECT MOD(14,6); #CALCULATE REMAINDER
SELECT POWER(5,3); #5 TO THE POWER OF 3
SELECT SORT(9);  #CALCULATE THE SQUARE ROOT
SELECT MOD( 5 ); 

#DATE AND TIME
SELECT NOW(); #DISPLAY CURRENT DAATE AND TIME
SELECT CURDATE(); # CURRENT DATE
SELECT CURTIME(); # CURRENT TIME
SELECT DATEDIFF(CURDATE(),'1998-11-12');# COUNT DAYS
SELECT DATEDIFF('2026-06-01','1998-11-12');
SELECT DATEDIFF('2026-06-01','1998-11-12')/365;
SELECT YEAR('1998-11-12');
SELECT MONTH('1998-11-12');
SELECT DAY('1998-11-12');

#CONDITIONAL FUNCTION 
-- SELECT *,IF(esal>80000,'High Salary','Average Salary') AS Status
-- FROM employee;

SELECT *,
       IF(esal > 80000, 'High Salary', 'Average Salary') AS Status
FROM employee;

SELECT*,IF(esal<50000,"Low Salary",
	IF(esal<80000,"Average Salary",
    "High Salary")) AS Status FROM employee;
    
SELECT*,
CASE
	WHEN esal<50000
    THEN 'Low Salary'
    WHEN esal<80000
    THEN 'Average Salary'
    ELSE 'High Salary'
    END AS Status
    FROM employee;
    
    #------------------------------------------------------------------------------------------------------------------------
    #LECTURE 9
    #window functions
    USE amazon;
    SELECT * FROM employee;
    SELECT sum(esal) FROM employee;
    SELECT SUM(esal) FROM employee GROUP BY eadd;
    SELECT eadd,SUM(esal) FROM employee GROUP BY eadd;
    SELECT ename,eadd,SUM(esal) FROM employee GROUP BY eadd;
    #YOU CAN NOT PRINT THIS QUERY ,YOU CAN TAKE ONLY THAT COLUMN ON WHICH YOU APPLY
    SELECT ename,eadd,sum(esal) FROM employee GROUP BY eadd;
    
    #YOU CAN NOT PRINT ANY COLUMN WITH AGGREGATE FUNCTION , YOU NEED GROUP BY 
    SELECT *,sum(esal) FROM employee;
    
    #window function 
    #with wf you can perform calcution with set of rows without group by 
    #Syntax
    #SELECT*,WIN_FUN() OVER() FROM TABLE_NAME;
    #ALL AGGREGATE FUNCTIONS BEHAVE LIKE WINDOW FUNCTION WITH OVER()
    SELECT*,sum(esal) OVER() AS TOTALSalary FROM employee;
	SELECT*,AVG(esal) OVER() AS TOTALSalary FROM employee;

    #SYNTAX
    #SELECTED*,WIN_FUN() OVER(PARTITION BY col_name,ORDER BY col_name)
    #FROM table_name;
    SELECT*,SUM(esal) OVER(PARTITION BY eadd ORDER BY esal) FROM employee;
	SELECT*,SUM(esal) OVER(PARTITION BY eadd ORDER BY esal DESC) FROM employee;

#ROW NUMBER
SELECT * FROM employee ORDER BY esal;
SELECT*,ROW_NUMBER() OVER() FROM employee;
SELECT*,ROW_NUMBER() OVER(ORDER BY esal) FROM employee;
SELECT*,ROW_NUMBER() OVER(ORDER BY esal DESC) FROM employee;
 
 #RANK
 SELECT *,RANK() OVER(ORDER BY esal DESC) FROM employee;
    
#DENSE_RANK    
SELECT *,DENSE_RANK() OVER(ORDER BY esal DESC) FROM employee;
#NTILE
SELECT*,NTILE(4) OVER(ORDER BY esal DESC) FROM employee;
SELECT*,NTILE(5) OVER(ORDER BY esal DESC) FROM employee;

#NTILE(4): A built-in window function that splits the queried dataset into 4 bucket numbers (1, 2, 3, and 4).OVER (ORDER BY esal DESC)
    
#LAG(CARRY PREVIOUS VALUE)
SELECT *,LAG(esal) OVER() FROM employee;    
SELECT *,LAG(esal) OVER(ORDER BY esal DESC) FROM employee;    
    
#LEAD(CARRY NEXT VALUE)    
SELECT *,LEAD(esal) OVER() FROM employee;    
SELECT *,LEAD(esal) OVER(ORDER BY esal DESC) FROM employee;    

#--------------------------------------------------------------------------------------------------------------------------------------------
#LECTURE 10
/*
#Trigger:-Trigger is a stored query which  will execute automatically when, an event will occur.
Event:-insert,update,delete
type of Trigger
Before Insert
After Insert
before update
after update
before delete
after delete
*/
USE amazon;
SHOW TABLES;
SELECT*FROM employee;
DELETE FROM employee WHERE eid=102;

CREATE TABLE EMP_LOG(
logid INT PRIMARY KEY AUTO_INCREMENT,
empid INT,
empname VARCHAR(100),
empadd VARCHAR(100),
esal DECIMAL(8,2),
evnt VARCHAR(50),
tme TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT*FROM employee;
SELECT*FROM emp_log;
INSERT INTO employee VALUE(102,'Yogesh Sing','Noida',86283);

INSERT INTO emp_log(empid,empname,empadd,esal,evnt)
VALUE(102,'Yogesh Sing','Noida',86283,'joined');

/*
delimiter $$
CREATE TRIGGER trigger_name
AFTER | BEFORE   DELETE | INSERT | UPDATE ON table_name
FOR EACH ROW
BEGIN
--SQL;
END $$ DELIMITER;
*/

DELIMITER //
CREATE TRIGGER ins_emp
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
INSERT INTO emp_log(empid,empname,empadd,esal,evnt)
VALUE(102,'Yogesh Singh','Noida',86283,'Joined');
END  //
DELIMITER ;

DELIMITER //
CREATE TRIGGER ins_emp
AFTER INSERT ON employee
FOR EACH ROW
BEGIN 
INSERT INTO emp_log(empid,empname,empadd,esal,evnt)
VALUE(NEW.eid,NEW.ename,NEW.eadd,NEW.esal,'Joined');
END //
 DELIMITER ;

INSERT INTO employee VALUE(104,'Hrish Singh','Delhi'97733);
SELECT*FROM employee;
SELECT *FROM emp_log;

DELIMITER //
CREATE TRIGGER del_emp
AFTER INSERT ON employee
FOR EACH ROW
BEGIN 
INSERT INTO emp_log(empid,empname,empadd,esal,evnt)
VALUE(OLD.eid,OLD.ename,OLD.eadd,OLD.esal,'Resigned');
END //
 DELIMITER ;
 
 DELETE FROM employee WHERE eid=102;
 
 #-------------------------------------------
 #LECTURE 11 
#Triggers 
USE amazon;
SHOW TABLES;
SELECT*FROM employee;
SELECT*FROM emp_log;

DELIMITER //
CREATE TRIGGER  up_emp
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
	INSERT INTO emp_log(empid,empname,empadd,epsal,evnt) VALUES
    (OLD.eid,OLD.ename,OLD.eadd,OLD.esal,'Update');
    END // DELIMITER ;
    
    SELECT*FROM employee;
    UPDATE employee SET esal=99000 WHERE eid=103;

DELIMITER $$
CREATE TRIGGER validate_salary
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN 
IF NEW.esal<22000
THEN
	SIGNAL SQLSTATE '45000'
#SET MESSAGE_TEXT "SALARY SHOULD BE GREATER THAN 22000";
THEN
SET NEW.esal<22000;
		END IF;
END $$ DELIMITER ;
INSERT INTO employee(ename,eadd,esal) VALUE('Anu','Noida',86000);
INSERT INTO employee(ename,eadd,esal) VALUE('Anu','Noida',19000);
SELECT*FROM emp_log;












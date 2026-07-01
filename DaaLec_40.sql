#Day16-> 
#DCL:- Data Control Language
#CREATE USER
CREATE USER 'user1'@'localhost' IDENTIFIED BY '12345';
USE amazon;
SHOW TABLES;
SELECT*FROM customer;
#allow Permissions
GRANT SELECT ON  amazon.customer TO 'user1'@'localhost';
GRANT SELECT,DELETE ON  amazon.customer TO 'user1'@'localhost';

#Remove Permissions
REVOKE SELECT ON amazon.customer FROM 'user1'@'localhost';
REVOKE ALL PRIVILEGES  ON amazon.* FROM 'user1'@'localhost';

#Allow All Permissions
GRANT ALL PRIVILEGES ON amazon.customer TO 'user1'@'localhost';

#Revoke All Permissions with all tables of a database 
GRANT ALL PRIVILEGES ON  amazon.* TO 'user1'@'localhost';

#DELETE USER
DROP USER 'user1'@'localhost';

use amazon;
SHOW TABLES;
SELECT * FROM customer; 
SELECT * FROM cust_log; 





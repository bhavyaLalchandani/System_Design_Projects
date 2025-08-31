-- Pre Work
-- Create an example database and users table
CREATE DATABASE example;
USE example;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Insert a value in users table
INSERT INTO users VALUES(1, 'Abha');

-- Open 2 Instances of MySQL command line clients
-- In both MySQL cli run the following queries
-- Set current session's isolation level to read committed
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Check whether the isolation level was updated or not
SELECT @@transaction_ISOLATION;
SELECT * FROM users; -- In both the clients you will see the same result as below
/*
+----+------+
| id | name |
+----+------+
|  1 | Abha |
+----+------+
*/

-- In MySQL CLI - 1, Start TRANSACTION - 1 and parallely in MySQL CLI - 2, Start TRANSACTION - 2

START TRANSACTION;
SELECT * FROM users;
/*
+----+------+
| id | name |
+----+------+
|  1 | Abha |
+----+------+
*/

-- In MySQL CLI - 2, Start TRANSACTION - 2
START TRANSACTION;
SELECT * FROM users;
/*
+----+------+
| id | name |
+----+------+
|  1 | Abha |
+----+------+
*/

-- In TRANSACTION 1 - Update the Value and commit
UPDATE users SET name = 'Ethan' WHERE id = 1;
-- Read value in same transaction
/*
Result:
+----+-------+
| id | name  |
+----+-------+
|  1 | Ethan |
+----+-------+
*/

-- Commit the transaction
COMMIT;

-- In MySQL CLI - 2, read the value again in TRANSACTION - 2
SELECT * FROM users;
/*
As the change from the Transaction-1 was committed after the value was already read in the current transaction (TRANSACTION-2) it will not be reflected
+----+------+
| id | name |
+----+------+
|  1 | Abha |
+----+------+
*/

-- HENCE IN REPEATABLE READS THE READS ACROSS A TRANSACTION REMAIN CONSISTENT


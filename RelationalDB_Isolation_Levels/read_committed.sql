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
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Check whther the isolation level was updated or not
SELECT @@transaction_ISOLATION;
SELECT * FROM users; -- In both the clients you will see the same result as below
/*
+----+------+
| id | name |
+----+------+
|  1 | Abha |
+----+------+
*/
-- In MySQL CLI - 1, Start TRANSACTION - 1

START TRANSACTION;
UPDATE users SET name = 'Aadya' WHERE id = 1;
SELECT * FROM users;
/*
This time as the name was updated in transaction the result of select statement in the same transaction will be as follows:
+----+-------+
| id | name  |
+----+-------+
|  1 | Aadya |
+----+-------+
*/

-- In MySQL CLI - 2, Start TRANSACTION - 2
START TRANSACTION;
SELECT * FROM users;
/*
As the change from the transaction hasn't been committed yet, Transaction 2 will read the last committed value
+----+------+
| id | name |
+----+------+
|  1 | Abha |
+----+------+
*/

-- Back to Transaction - 1 (CLI 1), Commit the transaction
COMMIT; 

-- Now in the ongoing transaction - 2, read the value
SELECT * FROM users;
/*
This will be the result, As transaction-1 was committed, the current transaction will now read the last committed value
+----+-------+
| id | name  |
+----+-------+
|  1 | Aadya |
+----+-------+
*/
COMMIT;


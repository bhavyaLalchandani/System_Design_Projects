-- user for replication (lab only)
CREATE USER IF NOT EXISTS 'replicaUser'@'%' IDENTIFIED WITH mysql_native_password BY 'replicaPass';
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'replicaUser'@'%';

-- app user (lab only)
CREATE USER IF NOT EXISTS 'appUser'@'%' IDENTIFIED mysql_native_password BY BY 'appPass';
GRANT SELECT, INSERT, UPDATE, DELETE ON glamgram.* TO 'appUser'@'%';

-- small table to test with
CREATE TABLE IF NOT EXISTS glamgram.posts (
  post_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

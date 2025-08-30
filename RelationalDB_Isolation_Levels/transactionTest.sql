-- SUCCESSFUL TRANSACTION
START TRANSACTION;
-- Signup Ananya
INSERT INTO users (username, email, password_hash) VALUES
('Ananya', 'ananya@example.com', SHA2('ananya123', 256));

-- Signup Abhinav
INSERT INTO users (username, email, password_hash) VALUES
('Abhinav', 'abhinav@example.com', SHA2('abhinav123', 256));

COMMIT;

USE Glamgram;
SELECT userId, username, password_hash FROM users;

-- Try login for Ananya
-- If the Password is correct the row comes up if password is wrong no row comes up
SELECT * FROM users WHERE
    username = 'Ananya'
    AND password_hash = SHA2('ananya123', 256);

-- ATOMICITY TEST AND TRANSACTION FAILURE
START TRANSACTION;

-- Ananya posts a message
INSERT INTO posts (userId, caption)
VALUES (1, 'Hey People, A Bit about me, I Love Ginger Tea!');

-- Abhinav comments on Ananya's post
INSERT INTO comments (userId, postId, content)
VALUES (2, 1, 'Hey, I too love Ginger Tea!');

-- Simulate a failure by rolling back
ROLLBACK;

SELECT * FROM posts;
SELECT * FROM comments;

START TRANSACTION;

-- Ananya posts a message
INSERT INTO posts (userId, caption)
VALUES (1, 'Hey People, A Bit about me, I Love Ginger Tea!');

-- Abhinav comments on Ananya's post
INSERT INTO comments (userId, postId, content)
VALUES (2, 2, 'Hey, I too love Ginger Tea!');

-- Simulate a failure by rolling back
COMMIT;




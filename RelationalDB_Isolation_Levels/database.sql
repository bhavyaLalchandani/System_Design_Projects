CREATE DATABASE Glamgram;
USE Glamgram;

-- Users Table
CREATE TABLE users (
    userId INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,-- Storing hash instead of plain password
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

-- Posts Table
CREATE TABLE posts (
    postId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    caption TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES users(userId)
);

-- Comments Table
CREATE TABLE comments (
    commentId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    postId INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Foreign Key (userId) REFERENCES users(userId),
    Foreign Key (postId) REFERENCES posts(postId)
);
ALTER TABLE comments
ADD COLUMN content TEXT NOT NULL AFTER postId;
DESCRIBE comments;
-- Likes Table
CREATE TABLE likes (
    likeId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    postId INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(postId, userId), -- a user can like a post only once
    FOREIGN KEY (userId) REFERENCES users(userId),
    FOREIGN KEY (postId) REFERENCES posts(postId)
);

-- Follows Table
CREATE TABLE follows (
    followerId INT NOT NULL,
    followingId INT NOT NULL,
    PRIMARY KEY (followerId, followingId),
    FOREIGN KEY (followerId) REFERENCES users(userId),
    FOREIGN KEY (followingId) REFERENCES users(userId)
)
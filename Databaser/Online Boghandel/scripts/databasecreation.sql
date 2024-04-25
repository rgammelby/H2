-- Drops database if it exists, creates database if not exists
DROP DATABASE IF EXISTS OnlineBookStore;
CREATE DATABASE IF NOT EXISTS OnlineBookStore;

-- Creates a database admin and grants all permissions
DROP USER IF EXISTS 'admin'@'localhost';
FLUSH PRIVILEGES;
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;
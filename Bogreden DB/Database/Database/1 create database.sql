-- ----------------- --
-- Initiate Database --
-- ----------------- --
-- Drop the database if it exists
DROP DATABASE IF EXISTS bogreden;

-- Create the database
CREATE DATABASE bogreden;

-- Select the database to use
USE bogreden;

-- --------------------------- --
-- create privileges and users --
-- --------------------------- --
-- Drop the existing user
DROP USER IF EXISTS 'Owner'@'localhost';

-- Create the user 'Owner' with a password
CREATE USER 'Owner'@'localhost' IDENTIFIED BY 'Owner!0ret';

-- Grant full privileges to the 'Owner' user for all tables in the bogreden database
GRANT ALL PRIVILEGES ON bogreden.* TO 'Owner'@'localhost';

-- Apply the changes
FLUSH PRIVILEGES;

-- --------------------------------- --
-- Create tables without forein keys --
-- --------------------------------- --
CREATE TABLE br_bogreden_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    log_table_key VARCHAR(25),
    log_time_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    log_message TEXT
);

-- I have defined this as a varchar because there are countries, 
-- such as canada, which use letters in the postal code.
CREATE TABLE br_city (
    city_postal_code VARCHAR(15) PRIMARY KEY,
    city_name VARCHAR(200) NOT NULL
);

CREATE TABLE br_user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_first_name VARCHAR(50) NOT NULL,
    user_last_name VARCHAR(50) NOT NULL,
    user_username VARCHAR(50) UNIQUE NOT NULL,
    user_password VARCHAR(250) NOT NULL,
    user_email VARCHAR(254) UNIQUE NOT NULL,
    user_phone_number VARCHAR(25) UNIQUE NOT NULL
);

CREATE TABLE br_pricing (
    pri_id INT AUTO_INCREMENT PRIMARY KEY,
    pri_purchase_price DECIMAL(6, 2) NOT NULL,
    pri_sales_price DECIMAL(6, 2) NOT NULL,
    pri_sale_percentage DECIMAL(5, 2),
    pri_price_reduction DECIMAL(6, 2)
);

Create table br_tax ( -- types of taxes
    tax_id INT AUTO_INCREMENT PRIMARY KEY,
    tax_rate DECIMAL(6,2) NOT NULl, -- the percentage of tax
    tax_name VARCHAR(100), -- ingoing tax, sales tax, outgoing tax
    tax_incoming BOOLEAN NOT NULL -- false if tax is outgoing
);

-- this table only contains a single row.
CREATE TABLE br_taxes (
   pri_id INT AUTO_INCREMENT PRIMARY KEY, -- the id of the price
   fk_tax_id INT NOT NULL, -- the id of the type of tax
   Accumi_tax decimal(6,2), -- the sum of the taxes paid
   last_update datetime, -- the last time the tax was updated
   last_tax_paid datetime -- the last time the tax was paid
);

CREATE TABLE br_genre (gen_value VARCHAR(100) PRIMARY KEY);

CREATE TABLE br_author (auth_name VARCHAR(100) PRIMARY KEY);

-- ------------------------------ --
-- create tables with forein keys --
-- ------------------------------ --
CREATE TABLE br_address (
    adr_id INT AUTO_INCREMENT PRIMARY KEY,
    adr_postal_code VARCHAR(15) NOT NULL,
    adr_user_id INT NOT NULL,
    adr_street_address VARCHAR(100) NOT NULL,
    adr_country varchar(60) NOT NULL,
    adr_is_billing_address BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (adr_postal_code) REFERENCES br_city(city_postal_code),
    FOREIGN KEY (adr_user_id) REFERENCES br_user(user_id) ON DELETE CASCADE
);

CREATE TABLE br_order (
    odr_id INT AUTO_INCREMENT PRIMARY KEY,
    odr_user_id INT,
    odr_shipping_date TIMESTAMP,
    odr_sold_price DECIMAL(6, 2),
    odr_status Enum(
        'Received',
        'Processed',
        'Shipped',
        'Delivered',
        'Cancelled',
        'Returned',
        'Failed',
        'On Hold'
    ),
    FOREIGN KEY (odr_user_id) REFERENCES br_user(user_id)
);

CREATE TABLE br_book (
    bk_id INT AUTO_INCREMENT PRIMARY KEY,
    bk_pricing_id INT,
    bk_titel VARCHAR(100),
    bk_weight DECIMAL(6, 4),
    bk_description TEXT,
    bk_image VARCHAR(50),
    FOREIGN KEY (bk_pricing_id) REFERENCES br_pricing(pri_id)
);

-- ------------------------------ --
-- create tables with forein keys --
-- ------------------------------ --
-- we don't delete the author with the book, because one author might have more books.
CREATE TABLE br_book_author (
    ba_id INT AUTO_INCREMENT PRIMARY KEY,
    ba_book_id INT,
    ba_author_name VARCHAR(100),
    FOREIGN KEY (ba_book_id) REFERENCES br_book(bk_id),
    FOREIGN KEY (ba_author_name) REFERENCES br_author(auth_name)
);

CREATE TABLE br_book_genre (
    bg_id INT AUTO_INCREMENT PRIMARY KEY,
    bg_book_id INT,
    bg_genre VARCHAR(100),
    FOREIGN KEY (bg_book_id) REFERENCES br_book(bk_id),
    FOREIGN KEY (bg_genre) REFERENCES br_genre(gen_value)
);

CREATE TABLE br_book_order (
    bo_id INT AUTO_INCREMENT PRIMARY KEY,
    bo_book_id INT,
    bo_ord_id INT,
    FOREIGN KEY (bo_book_id) REFERENCES br_book(bk_id),
    FOREIGN KEY (bo_ord_id) REFERENCES br_order(odr_id)
);
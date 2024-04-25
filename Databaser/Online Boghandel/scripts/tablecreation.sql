-- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES 

USE OnlineBookStore;

CREATE TABLE Author (
	author_id SMALLINT PRIMARY KEY AUTO_INCREMENT,  -- Using smallints to conserve space, as I don't figure I'll have very many entries, otherwise int instead of smallint
    first_name VARCHAR(256) NOT NULL,  -- Using varchar to accept any character in name
    last_name VARCHAR(256) NOT NULL
);
CREATE INDEX author_index ON Author(last_name) USING BTREE;
CREATE INDEX author_first_name_index ON Author(first_name) USING BTREE;

CREATE TABLE Genre (
	genre_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(256) NOT NULL
);
CREATE INDEX genre_index ON Genre(name) USING BTREE;

-- Book with external references to Author and Genre (each book has one)
CREATE TABLE Book (
	book_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(256) NOT NULL,
    author SMALLINT NOT NULL,
    price INT NOT NULL,
    genre SMALLINT NOT NULL,
    FOREIGN KEY (author) REFERENCES Author(author_id),
    FOREIGN KEY (genre) REFERENCES Genre(genre_id)
);
CREATE INDEX book_index ON Book(title) USING BTREE;
CREATE INDEX price_index ON Book(price) USING BTREE;
    
-- Table for imported city & postcode information
CREATE TABLE Address(
	address_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    postcode VARCHAR(4) NOT NULL,
    city VARCHAR(50) NOT NULL
);
CREATE INDEX postcode_index ON Address(postcode) USING BTREE;
CREATE INDEX city_index ON Address(city) USING BTREE;
    
-- Customer with address reference
CREATE TABLE Customer (
	customer_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(256) NOT NULL,
    last_name VARCHAR(256) NOT NULL,
    email VARCHAR(256) NOT NULL,
    road_and_number VARCHAR(256) NOT NULL,
    address SMALLINT NOT NULL,
    FOREIGN KEY (address) REFERENCES Address(address_id)
);
CREATE INDEX customer_index ON Customer(last_name) USING BTREE;
CREATE INDEX customer_name_index ON Customer(first_name) USING BTREE;
CREATE INDEX email_index ON Customer(email) USING BTREE;
CREATE INDEX address_index ON Customer(road_and_number) USING BTREE;
    
-- Name 'Order' unavailable
-- Each order (purchase) belongs to a user
CREATE TABLE Purchase (
	order_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    order_number INT NOT NULL,
    customer SMALLINT,
    FOREIGN KEY (customer) REFERENCES Customer(customer_id)
);
CREATE INDEX order_index ON Purchase(order_number) USING BTREE;

-- Table for n -> n relation (Book & Order)
-- several BookOrder items exist for each order number (user order); these are all the books belonging to a single order
CREATE TABLE BookOrder (
	order_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    order_number SMALLINT NOT NULL,
    book SMALLINT NOT NULL,
    FOREIGN KEY (order_number) REFERENCES Purchase(order_id),
    FOREIGN KEY (book) REFERENCES Book(book_id)
);
CREATE INDEX bookorder_index ON BookOrder(order_number) USING BTREE;
    
-- Log table
-- Later triggers log attempts and successful attempts at insertions, updates & deletes
CREATE TABLE bogreden_log (
	log_id INT PRIMARY KEY AUTO_INCREMENT,
    change_type VARCHAR(30),
    id_key SMALLINT,
    table_name VARCHAR(64),
    log_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX change_type_index ON bogreden_log(change_type) USING BTREE;
CREATE INDEX table_name_index ON bogreden_log(table_name) USING BTREE;
CREATE INDEX log_time_index ON bogreden_log(log_time) USING BTREE;

-- Imports data from csv file. Must be located correctly in the given path for it to run
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/postnumre.csv'
INTO TABLE Address
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES (postcode, city);
    
-- SHOW TABLES;  -- confirm successful table creation

-- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES 

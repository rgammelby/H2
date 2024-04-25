-- Drops database if it exists, creates database if not exists
DROP DATABASE IF EXISTS OnlineBookStore;
CREATE DATABASE IF NOT EXISTS OnlineBookStore;

-- Creates a database admin and grants all permissions
DROP USER IF EXISTS 'admin'@'localhost';
FLUSH PRIVILEGES;
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;

-- Ensures the rest of the script is applied to the correct database
USE OnlineBookStore;

-- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES 

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
    name VARCHAR(256) NOT NULL,
    email VARCHAR(256) NOT NULL,
    road_and_number VARCHAR(256) NOT NULL,
    address SMALLINT NOT NULL,
    FOREIGN KEY (address) REFERENCES Address(address_id)
);
CREATE INDEX customer_index ON Customer(name) USING BTREE;
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

-- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS 

-- AUTHOR TRIGGERS
	-- AFTER TRIGGERS
    -- Logs successful change attempts
DELIMITER //
CREATE TRIGGER author_create_trigger
AFTER INSERT
ON Author
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.author_id, 'Insert successful. ', 'Author');
END;
//

CREATE TRIGGER author_update_trigger
AFTER UPDATE
ON Author
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.author_id, 'Update successful. ', 'Author');
END;
//

CREATE TRIGGER author_delete_trigger
AFTER DELETE
ON Author
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (OLD.author_id, 'Delete successful. ', 'Author');
END;//

-- BEFORE TRIGGERS
	-- Logs attempts before success or failure
CREATE TRIGGER author_before_create_trigger
BEFORE INSERT
ON Author
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.author_id, 'Attempting insert... ', 'Author');
END;
//

CREATE TRIGGER author_before_update_trigger
BEFORE UPDATE
ON Author
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.author_id, 'Attempting update... ', 'Author');
END;
//

CREATE TRIGGER author_before_delete_trigger
BEFORE DELETE
ON Author
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (OLD.author_id, 'Attempting delete... ', 'Author');
END;//
DELIMITER ;

-- GENRE TRIGGERS
DELIMITER //
CREATE TRIGGER genre_create_trigger
AFTER INSERT
ON Genre
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.genre_id, 'Insert successful. ', 'Genre');
END;
//

CREATE TRIGGER genre_update_trigger
AFTER UPDATE
ON Genre
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.genre_id, 'Update successful. ', 'Genre');
END;
//

CREATE TRIGGER genre_delete_trigger
AFTER DELETE
ON Genre
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (OLD.genre_id, 'Delete successful. ', 'Genre');
END;//

-- BEFORE TRIGGERS
DELIMITER //
CREATE TRIGGER genre_before_create_trigger
BEFORE INSERT
ON Genre
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.genre_id, 'Attempting insert... ', 'Genre');
END;
//

CREATE TRIGGER genre_before_update_trigger
BEFORE UPDATE
ON Genre
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.genre_id, 'Attempting update... ', 'Genre');
END;
//

CREATE TRIGGER genre_before_delete_trigger
BEFORE DELETE
ON Genre
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (OLD.genre_id, 'Attempting delete... ', 'Genre');
END;//
DELIMITER ;

-- BOOK TRIGGERS
DELIMITER //
CREATE TRIGGER book_create_trigger
AFTER INSERT
ON book
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.book_id, 'Insert successful. ', 'Book');
END;
//

CREATE TRIGGER book_update_trigger
AFTER UPDATE
ON book
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.book_id, 'Update successful. ', 'Book');
END;
//

CREATE TRIGGER book_delete_trigger
AFTER DELETE
ON book
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (OLD.book_id, 'Delete successful. ', 'Book');
END;//

-- BEFORE TRIGGERS:
DELIMITER //
CREATE TRIGGER book_before_create_trigger
BEFORE INSERT
ON book
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.book_id, 'Attempting insert... ', 'Book');
END;
//

CREATE TRIGGER book_before_update_trigger
BEFORE UPDATE
ON book
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.book_id, 'Attempting update... ', 'Book');
END;
//

CREATE TRIGGER book_before_delete_trigger
BEFORE DELETE
ON book
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (OLD.book_id, 'Attempting delete... ', 'Book');
END;//
DELIMITER ;

-- ADDRESS TRIGGERS
DELIMITER //
CREATE TRIGGER address_create_trigger
AFTER INSERT
ON address
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.address_id, 'Insert successful. ', 'Address');
END;
//

CREATE TRIGGER address_update_trigger
AFTER UPDATE
ON address
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.address_id, 'Update successful. ', 'Address');
END;
//

CREATE TRIGGER address_delete_trigger
AFTER DELETE
ON address
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (OLD.address_id, 'Delete successful. ', 'Address');
END;//

-- BEFORE TRIGGERS:
DELIMITER //
CREATE TRIGGER address_before_create_trigger
BEFORE INSERT
ON address
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.address_id, 'Attempting insert... ', 'Address');
END;
//

CREATE TRIGGER address_before_update_trigger
BEFORE UPDATE
ON address
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.address_id, 'Attempting update... ', 'Address');
END;
//

CREATE TRIGGER address_before_delete_trigger
BEFORE DELETE
ON address
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (OLD.address_id, 'Attempting delete... ', 'Address');
END;//
DELIMITER ;

-- CUSTOMER TRIGGERS
DELIMITER //
CREATE TRIGGER customer_create_trigger
AFTER INSERT
ON customer
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.customer_id, 'Insert successful. ', 'Customer');
END;
//

CREATE TRIGGER customer_update_trigger
AFTER UPDATE
ON customer
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.customer_id, 'Update successful. ', 'Customer');
END;
//

CREATE TRIGGER customer_delete_trigger
AFTER DELETE
ON customer
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (OLD.customer_id, 'Delete successful. ', 'Customer');
END;//

-- BEFORE TRIGGERS: 
DELIMITER //
CREATE TRIGGER customer_before_create_trigger
BEFORE INSERT
ON customer
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.customer_id, 'Attempting insert... ', 'Customer');
END;
//

CREATE TRIGGER customer_before_update_trigger
BEFORE UPDATE
ON customer
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.customer_id, 'Attempting update... ', 'Customer');
END;
//

CREATE TRIGGER customer_before_delete_trigger
BEFORE DELETE
ON customer
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (OLD.customer_id, 'Attempting delete... ', 'Customer');
END;//
DELIMITER ;

-- PURCHASE TRIGGERS
DELIMITER //
CREATE TRIGGER purchase_create_trigger
AFTER INSERT
ON purchase
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.order_id, 'Insert successful. ', 'Purchase');
END;
//

CREATE TRIGGER purchase_update_trigger
AFTER UPDATE
ON purchase
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.order_id, 'Update successful. ', 'Purchase');
END;
//

CREATE TRIGGER purchase_delete_trigger
AFTER DELETE
ON purchase
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (OLD.order_id, 'Delete successful. ', 'Purchase');
END;//

-- BEFORE TRIGGERS:
DELIMITER //
CREATE TRIGGER purchase_before_create_trigger
BEFORE INSERT
ON purchase
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.order_id, 'Attempting insert... ', 'Purchase');
END;
//

CREATE TRIGGER purchase_before_update_trigger
BEFORE UPDATE
ON purchase
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.order_id, 'Attempting update... ', 'Purchase');
END;
//

CREATE TRIGGER purchase_before_delete_trigger
BEFORE DELETE
ON purchase
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (OLD.order_id, 'Attempting delete... ', 'Purchase');
END;//
DELIMITER ;

-- BOOKORDER TRIGGERS
DELIMITER //
CREATE TRIGGER bookorder_create_trigger
AFTER INSERT
ON bookorder
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.order_id, 'Insert successful. ', 'BookOrder');
END;
//

CREATE TRIGGER bookorder_update_trigger
AFTER UPDATE
ON bookorder
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.order_id, 'Update successful. ', 'BookOrder');
END;
//

CREATE TRIGGER bookorder_delete_trigger
AFTER DELETE
ON bookorder
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (OLD.order_id, 'Delete successful. ', 'BookOrder');
END;//

-- BEFORE TRIGGERS:
DELIMITER //
CREATE TRIGGER bookorder_before_create_trigger
BEFORE INSERT
ON bookorder
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.order_id, 'Attempting insert... ', 'BookOrder');
END;
//

CREATE TRIGGER bookorder_before_update_trigger
BEFORE UPDATE
ON bookorder
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (NEW.order_id, 'Attempting update... ', 'BookOrder');
END;
//

CREATE TRIGGER bookorder_before_delete_trigger
BEFORE DELETE
ON bookorder
FOR EACH ROW
BEGIN
	INSERT INTO bogreden_log (id_key, change_type , table_name)
    VALUES (OLD.order_id, 'Attempting delete... ', 'BookOrder');
END;//
DELIMITER ;

-- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS 

-- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES

-- Generate a random number
DROP PROCEDURE IF EXISTS GenerateOrderNumber;

DELIMITER //
CREATE PROCEDURE GenerateOrderNumber(OUT orderNumber INT)
BEGIN
	DECLARE randomNumber INT;

	REPEAT
        SET randomNumber = (100000 + RAND() * 900000);
    UNTIL NOT EXISTS (SELECT 1 FROM Purchase WHERE order_number = randomNumber) END REPEAT;
    
    SET orderNumber = randomNumber;
END//
DELIMITER ;

-- Creates a new order and generates an order number
DROP PROCEDURE IF EXISTS CreateNewOrder;

DELIMITER //
CREATE PROCEDURE CreateNewOrder (IN customerName VARCHAR(256))
BEGIN
	DECLARE orderNumber INT;
	CALL GenerateOrderNumber(orderNumber);
    SELECT orderNumber;
    INSERT INTO Purchase
    VALUES (DEFAULT, orderNumber, (SELECT customer_id FROM Customer WHERE name LIKE CONCAT('%', customerName, '%')));
    
END //
DELIMITER ;

-- Fetches logs made in a span of dates 
DROP PROCEDURE IF EXISTS GetLogsBetweenDates;

DELIMITER //
CREATE PROCEDURE GetLogsBetweenDates (
    IN firstDay INT, 
    IN firstMonth INT, 
    IN firstYear VARCHAR(4), 
    IN lastDay INT, 
    IN lastMonth INT, 
    IN lastYear VARCHAR(4)
)

BEGIN
    IF firstYear = '' THEN SET firstYear = YEAR(CURDATE()); END IF;
    IF lastYear = '' THEN SET lastYear = YEAR(CURDATE()); END IF;
    SELECT log_id, change_type, table_name, id_key, log_time 
    FROM bogreden_log
    WHERE log_time BETWEEN CONCAT(firstYear, '-', firstMonth, '-', firstDay)
    AND CONCAT(lastYear, '-', lastMonth, '-', lastDay)
    ORDER BY log_time;
END //
DELIMITER ;

-- Get books by author
DROP PROCEDURE IF EXISTS GetBooksByAuthor;

DELIMITER //
CREATE PROCEDURE GetBooksByAuthor (IN authorName VARCHAR(256))
BEGIN 
	SELECT DISTINCT b.title AS Title, b.price AS 'Price (kr.)', CONCAT(a.first_name, a.last_name) AS Author 
    FROM Book b
    JOIN Author a 
    ON b.author = a.author_id
    WHERE b.author IN (SELECT author_id FROM Author WHERE first_name LIKE CONCAT('%', authorName, '%') OR last_name LIKE CONCAT('%', authorName, '%') ORDER BY last_name ASC);
END //
DELIMITER ;

-- Get author of book
DROP PROCEDURE IF EXISTS GetAuthorByBookTitle;

DELIMITER //
CREATE PROCEDURE GetAuthorByBookTitle (IN bookTitle VARCHAR(256)) 
BEGIN
	SELECT b.title AS Title, concat(a.first_name, a.last_name) AS Author
    FROM Author a
    JOIN Book b ON a.author_id = b.author
    WHERE b.title LIKE CONCAT('%', bookTitle, '%');
END //
DELIMITER ;

-- Get customer info by customer
DROP PROCEDURE IF EXISTS GetCustomerInfoByCustomerName;

DELIMITER //
CREATE PROCEDURE GetCustomerInfoByCustomerName (IN customerName VARCHAR(256))
BEGIN
	SELECT c.name AS Name, c.email AS 'E-mail', c.road_and_number AS Address, a.postcode AS 'Postcode', a.city AS City
    FROM Customer c
    JOIN Address a ON c.address = a.address_id
    WHERE c.name LIKE CONCAT('%', customerName, '%');
END //
DELIMITER ;

-- Get orders by customer
DROP PROCEDURE IF EXISTS GetOrdersByCustomer;

DELIMITER //
CREATE PROCEDURE GetOrdersByCustomer (IN customerName VARCHAR(256))
BEGIN
	SELECT p.order_number, b.title, c.name FROM BookOrder o
    JOIN Purchase p ON o.order_number = p.order_id
    JOIN Customer c ON p.customer = c.customer_id
    JOIN Book b ON o.book = b.book_id
    WHERE c.name LIKE CONCAT('%', customerName, '%');
END //
DELIMITER ;

-- Get book info by book
DROP PROCEDURE IF EXISTS GetBookInfoByBookTitle;

DELIMITER //
CREATE PROCEDURE GetBookInfoByBookTitle (IN bookTitle VARCHAR(256))
BEGIN
	SELECT b.title AS Title, CONCAT(a.first_name, a.last_name) AS Author, b.price AS 'Price (kr.)', g.name AS Genre
    FROM Book b
    JOIN Author a ON b.author = a.author_id
    JOIN Genre g ON b.genre = g.genre_id
    WHERE title LIKE CONCAT('%', bookTitle, '%');
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS CreateNewUser;

DELIMITER //
CREATE PROCEDURE CreateNewUser (
    IN customerName VARCHAR(256), 
    IN customerMail VARCHAR(256), 
    IN customerAddress VARCHAR(256), 
    IN addressIdFromPostcode SMALLINT
)
BEGIN
	INSERT INTO Customer
    VALUES (DEFAULT, customerName, customerMail, customerAddress, (SELECT address_id FROM Address WHERE postcode = addressIdFromPostcode));
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS CreateNewAuthor;

DELIMITER //
CREATE PROCEDURE CreateNewAuthor (IN authorName VARCHAR(256), IN authorLastName varchar(256))
BEGIN
	DECLARE existingAuthor INT;
	SELECT author_id FROM Author WHERE first_name LIKE CONCAT('%', authorName, '%') AND last_name LIKE CONCAT('%', authorLastName, '%') INTO existingAuthor;
    
    IF existingAuthor IS NULL THEN
		INSERT INTO Author
		VALUES (DEFAULT, CONCAT(authorName, ' '), authorLastName);
	
    ELSE SELECT "This author already exists in the database. " AS Error;
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS CreateNewGenre;

DELIMITER //
CREATE PROCEDURE CreateNewGenre (IN genreName VARCHAR(50))
BEGIN
	DECLARE existingGenre INT;
    SELECT genre_id FROM Genre WHERE name = genreName INTO existingGenre;
    IF existingGenre IS NULL THEN
		INSERT INTO Genre
		VALUES (DEFAULT, genreName);
        
	ELSE SELECT "This genre already exists in the database. " AS Error;
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS CreateNewBook;

DELIMITER //
CREATE PROCEDURE CreateNewBook (
    IN bookTitle VARCHAR(256), 
    IN bookAuthor VARCHAR(256), 
    IN bookAuthorLastName VARCHAR(256),
    IN bookPrice SMALLINT, 
    IN bookGenre VARCHAR(50)
)
BEGIN
	-- Declare author and genre ids to ensure the book gets created even if the author or genre is not currently in the database
	DECLARE authorId SMALLINT;
    DECLARE genreId SMALLINT;
    DECLARE existingBookTitle SMALLINT;
    
    -- Checks validity of author and genre in procedure call
    SELECT author_id INTO authorId FROM Author WHERE first_name LIKE CONCAT('%', bookAuthor, '%') OR last_name LIKE CONCAT('%', bookAuthorLastName, '%');
    SELECT genre_id INTO genreId FROM Genre WHERE name LIKE CONCAT('%', bookGenre, '%');
    SELECT book_id INTO existingBookTitle FROM Book WHERE title = bookTitle;
    
    IF existingBookTitle IS NULL THEN
		-- If author or genre from procedure call does not exist, create record for that author or genre
		IF authorId IS NULL THEN
			CALL CreateNewAuthor(bookAuthor, bookAuthorLastName);
			SELECT LAST_INSERT_ID() INTO authorId;
		END IF;
    
		IF genreId IS NULL THEN
			CALL CreateNewGenre(bookGenre);
			SELECT LAST_INSERT_ID() INTO genreId;
		END IF;
        
	INSERT INTO Book
    VALUES (DEFAULT, bookTitle, authorId, bookPrice, genreId);
    
    ELSE SELECT "This book already exists in the database. " AS Error;
    END IF;
    
END //
DELIMITER ;

-- Assigns a product to a specific order number using a pre-generated order number from Purchase and the Book(book_id) - call for each book purchased
DROP PROCEDURE IF EXISTS CreateNewBookOrder;

DELIMITER //
CREATE PROCEDURE CreateNewBookOrder (IN orderNumber SMALLINT, IN orderedBook SMALLINT)
BEGIN
	INSERT INTO BookOrder
    VALUES (DEFAULT, orderNumber, (SELECT book_id FROM Book WHERE title LIKE CONCAT('%', orderedBook, '%')));
END //
DELIMITER ; 

-- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES

-- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA 

-- Inserting dummy data into the Author table
INSERT INTO Author (first_name, last_name)
VALUES 
    ('J. R. R.', 'Tolkien'),
	('William', 'Shakespeare'),
	('George', 'Orwell'),
	('Leo', 'Tolstoy'),
	('C. S.', 'Lewis'),
	('Lewis', 'Carroll'),
	('Stephen', 'King'),
	('Stephanie', 'Meyer');
    
-- Inserting dummy data into the Genre table
INSERT INTO Genre (name)
VALUES 
    ('Fantasy'),
	('Science Fiction'),
	('Mystery'),
	('Novel'),
	('Poetry'),
	('Non-fiction'),
	('Thriller'),
	('Academic');
    
-- Inserting dummy data into the Book table
INSERT INTO Book (title, author, price, genre)
VALUES 
    ('The Lord of the Rings', 1, 640, 1),
	('1984', 3, 180, 1),
    ('War and Peace', 4, 250, 7),
    ('Hamlet', 2, 230, 5),
    ('The Hunting of the Snark', 6, 120, 3),
    ('Narnia', 5, 300, 1),
    ('It', 7, 150, 7),
    ('Twilight', 8, 120, 1);
    
-- default, name, mail, address, address_id
INSERT INTO Customer (name, email, road_and_number, address)
VALUES 
	('Sascha G', 's@mail.dk', 'Søborg Hovedgade 9', (SELECT address_id FROM address WHERE postcode = '2870')),
	('Christine G', 'c@mail.dk', 'Toftevej 20', (SELECT address_id FROM address WHERE postcode = '7700')),
	('Bo B', 'bb@mail.dk', 'Vinkelvej 1', (SELECT address_id FROM address WHERE postcode = '4220')),
    ('Benjamin L', 'b@mail.dk', 'Jagtvej 139', (SELECT address_id FROM address WHERE postcode = '2200')),
    ('Henriette B', 'h@mail.dk', 'Ved Klostret 10', (SELECT address_id FROM address WHERE postcode = '2100')),
    ('Markus Å', 'm@mail.dk', 'Elmegårdsvænget 19', (SELECT address_id FROM address WHERE postcode = '8210')),
    ('Mette M', 'mm@mail.dk', 'Asfaltvej 9', (SELECT address_id FROM address WHERE postcode = '9000')),
    ('Anne-Marie B', 'am@mail.dk', 'Nybro Vænge', (SELECT address_id FROM address WHERE postcode = '2800'));

-- Inserting dummy data into the Purchase table
SET @order1 = 0;
SET @order2 = 0;
SET @order3 = 0;
SET @order4 = 0;
SET @order5 = 0;
SET @order6 = 0;
SET @order7 = 0;
SET @order8 = 0;

CALL GenerateOrderNumber(@order1);
CALL GenerateOrderNumber(@order2);
CALL GenerateOrderNumber(@order3);
CALL GenerateOrderNumber(@order4);
CALL GenerateOrderNumber(@order5);
CALL GenerateOrderNumber(@order6);
CALL GenerateOrderNumber(@order7);
CALL GenerateOrderNumber(@order8);

INSERT INTO Purchase (order_number, customer)
VALUES 
    (@order1, 1),
	(@order2, 2),
    (@order3, 3),
    (@order4, 4),
    (@order5, 5),
    (@order6, 6),
    (@order7, 7),
    (@order8, 8);

-- Inserting dummy data into the BookOrder table
INSERT INTO BookOrder (order_number, book)
VALUES 
    (1, 1),
	(1, 2),
	(1, 7),
	(1, 5),
	(2, 7),
	(2, 8),
	(3, 4),
	(4, 8),
	(4, 4),
	(4, 1),
	(4, 2),
	(5, 5),
	(5, 4),
	(5, 6),
	(6, 3),
	(7, 3),
	(7, 8),
	(8, 8),
	(8, 3),
	(8, 4);

-- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA 

-- PROCEDURE CALLS -- PROCEDURE CALLS -- PROCEDURE CALLS -- PROCEDURE CALLS -- PROCEDURE CALLS -- PROCEDURE CALLS -- PROCEDURE CALLS -- PROCEDURE CALLS -- PROCEDURE CALLS -- PROCEDURE CALLS 
-- FOR TESTING.

/*
CALL GetLogsBetweenDates('23', '04', '', '27', '04', '');

CALL CreateNewGenre('Romance');

CALL CreateNewAuthor('Peter', 'Jensen');

CALL GetBooksByAuthor('george');

CALL GetAuthorByBookTitle('rings');

CALL GetCustomerInfoByCustomerName('G');

CALL GetOrdersByCustomer('Sascha');

CALL GetBookInfoByBookTitle('the');

CALL CreateNewUser('Peter Jensen', 'pj@mail.dk', 'Duevænget 12', 7700);

CALL CreateNewBook('The Hobbit', 'J. R. R.', 'Tolkien', 300, 'Fantasy');

CALL CreateNewBook('A Game of Thrones', 'George R. R.', 'Martin', 100, 'Fantasy');

select * from book;

CALL CreateNewBook('A Clash of Kings', 'George R. R.', 'Martin', 120, 'Fantasy');

CALL CreateNewOrder('Sascha');

-- PROCEDURE CALLS -- PROCEDURE CALLS -- PROCEDURE CALLS -- PROCEDURE CALLS -- PROCEDURE CALLS -- PROCEDURE CALLS -- PROCEDURE CALLS -- PROCEDURE CALLS -- PROCEDURE CALLS -- PROCEDURE CALLS 

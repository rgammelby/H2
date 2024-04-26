-- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES

USE OnlineBookStore;

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
CREATE PROCEDURE CreateNewOrder (IN customerUsername VARCHAR(64))
BEGIN
	DECLARE orderNumber INT;
	CALL GenerateOrderNumber(orderNumber);
    SELECT orderNumber;
    INSERT INTO Purchase
    VALUES (DEFAULT, orderNumber, (SELECT customer_id FROM Customer WHERE username LIKE CONCAT('%', customerUsername, '%')));
    
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
    SELECT log_id as 'Log no.', change_type, table_name, id_key as Id, log_time as 'Time and Date' 
    FROM bogreden_log
    WHERE log_time BETWEEN CONCAT(firstYear, '-', firstMonth, '-', firstDay)
    AND CONCAT(lastYear, '-', lastMonth, '-', lastDay)
    ORDER BY log_time;
END //
DELIMITER ;

-- Get books by author
DROP PROCEDURE IF EXISTS GetBooksByAuthor;

DELIMITER //
CREATE PROCEDURE GetBooksByAuthor (IN authorName VARCHAR(50))
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
CREATE PROCEDURE GetCustomerInfoByUsername (IN customerUsername VARCHAR(50))
BEGIN
	SELECT CONCAT(c.first_name, c.last_name) AS Name, c.email AS 'E-mail', c.road_and_number AS Address, a.postcode AS 'Postcode', a.city AS City
    FROM Customer c
    JOIN Address a ON c.address = a.address_id
    WHERE c.username = customerUsername;
END //
DELIMITER ;

-- Get orders by customer
DROP PROCEDURE IF EXISTS GetOrdersByCustomerUsername;

DELIMITER //
CREATE PROCEDURE GetOrdersByCustomer (IN customerUsername VARCHAR(50))
BEGIN
	SELECT p.order_number, b.title, c.name FROM BookOrder o
    JOIN Purchase p ON o.order_number = p.order_id
    JOIN Customer c ON p.customer = c.customer_id
    JOIN Book b ON o.book = b.book_id
    WHERE c.username = customerUsername;
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
	IN customerUsername VARCHAR(64),
    IN customerPassword VARCHAR(64),
    IN customerFirstName VARCHAR(50), 
    IN customerLastName VARCHAR(50),
    IN customerMail VARCHAR(50), 
    IN customerAddress VARCHAR(50), 
    IN addressIdFromPostcode SMALLINT
)
BEGIN
	INSERT INTO Customer
    VALUES (DEFAULT, customerUsername, SHA2(customerPassword, 256), CONCAT(customerFirstName, ' '), customerLastName, customerMail, customerAddress, (SELECT address_id FROM Address WHERE postcode = addressIdFromPostcode));
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS CreateNewAuthor;

DELIMITER //
CREATE PROCEDURE CreateNewAuthor (IN authorName VARCHAR(50), IN authorLastName varchar(50))
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
    IN bookAuthor VARCHAR(50), 
    IN bookAuthorLastName VARCHAR(50),
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

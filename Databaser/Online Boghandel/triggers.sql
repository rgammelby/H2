-- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS 

USE OnlineBookStore;

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

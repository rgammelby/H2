DELIMITER ¤

-- ------------------------------------- --
-- Create [insert procedures] procedures --
-- ------------------------------------- --

CREATE PROCEDURE insert_new_user(
    IN `first_name` VARCHAR(50),
    IN `last_name` VARCHAR(50),
    IN `username` VARCHAR(50),
    IN `password` VARCHAR(250),
    IN `confirm_password` VARCHAR(250),
    IN `email` VARCHAR(254),
    IN `phone_number` VARCHAR(25)
)
BEGIN
    IF `password` = `confirm_password` THEN
        INSERT INTO br_user (
            user_first_name,
            user_last_name,
            user_username,
            user_password,
            user_email,
            user_phone_number
        )
        VALUES (
            `first_name`,
            `last_name`,
            `username`,
            `password`,
            `email`,
            `phone_number`
        );
    ELSE
        SELECT 'Passwords do not match' AS ErrorMessage;
    END IF;
END¤

CREATE PROCEDURE insert_new_pricing(
    IN `purchase_price` DECIMAL(6, 2),
    IN `sales_price` DECIMAL(6, 2),
    IN `sale_percentage` DECIMAL(5, 2),
    IN `price_reduction` DECIMAL(6, 2)
)
BEGIN
    INSERT INTO br_pricing(
        pri_purchase_price,
        pri_sales_price,
        pri_sale_percentage,
        pri_price_reduction
    )
    VALUES(
        `purchase_price`,
        `sales_price`,
        `sale_percentage`,
        `price_reduction`
    );
END¤

CREATE PROCEDURE insert_new_genre(
    IN `value` VARCHAR(100)
)
BEGIN
    INSERT INTO br_genre (
        gen_value
    )
    VALUES (
        `value`
    );
END¤

CREATE PROCEDURE insert_new_author(
    IN `name` VARCHAR(100)
)
BEGIN
    INSERT INTO br_author(
        auth_name
    )
    VALUES(
        `name`
    );
END¤

CREATE PROCEDURE insert_new_address(
    IN `postal_code` VARCHAR(15),
    IN `user_id` INT,
    IN `street_address` VARCHAR(100),
    IN `country` varchar(60),
    IN `is_billing_address` BOOLEAN
)
BEGIN
    INSERT INTO br_address(
        adr_postal_code,
        adr_user_id,
        adr_street_address,
        adr_country,
        adr_is_billing_address
    )
    VALUES(
        `postal_code`,
        `user_id`,
        `street_address`,
        `country`,
        `is_billing_address`
    );
END¤

CREATE PROCEDURE insert_new_order(
    IN `user_id` INT,
    IN `shipping_date` TIMESTAMP,
    IN `sold_price` DECIMAL(6, 2),
    IN `status` ENUM('Received', 'Processed', 'Shipped', 'Delivered', 'Cancelled', 'Returned', 'Failed', 'On Hold')
)
BEGIN
    INSERT INTO br_order(
        odr_user_id,
        odr_shipping_date,
        odr_sold_price,
        odr_status
    )
    VALUES(
        `user_id`,
        `shipping_date`,
        `sold_price`,
        `status`
    );
END¤

CREATE PROCEDURE insert_new_book(
    IN `pricing_id` INT,
    IN `titel` VARCHAR(100),
    IN `weight` DECIMAL(6, 4),
    IN `description` TEXT,
    IN `image` VARCHAR(50)
)
BEGIN 
    INSERT INTO br_book(
        bk_pricing_id,
        bk_titel,
        bk_weight,
        bk_description,
        bk_image
    )
    VALUES(
        `pricing_id`,
        `titel`,
        `weight`,
        `description`,
        `image`
    );
END¤

CREATE PROCEDURE insert_new_book_author(
    IN `book_id` INT,
    IN `author_name` VARCHAR(100)
)
BEGIN
    INSERT INTO br_book_author(
        ba_book_id,
        ba_author_name
    )
    VALUES(
        `book_id`,
        `author_name`
    );
END¤

CREATE PROCEDURE insert_new_book_genre(
    IN `book_id` INT,
    IN `genre` VARCHAR(100)
)
BEGIN
    INSERT INTO br_book_genre(
        bg_book_id,
        bg_genre
    )
    VALUES(
        `book_id`,
        `genre`
    );
END¤

CREATE PROCEDURE insert_new_book_order(
    IN `book_id` INT,
    IN `ord_id` INT
)
BEGIN
    INSERT INTO br_book_order(
        bo_book_id,
        bo_ord_id
    )
    VALUES(
        `book_id`,
        `ord_id`
    );
END¤

CREATE PROCEDURE insert_new_tax (
    `rate` DECIMAL(6,2),
    `name` VARCHAR(100),
    `incoming` BOOLEAN
)
BEGIN
    INSERT INTO br_tax(
        tax_rate,
        tax_name,
        tax_incoming
    )
    VALUES(
        `rate`,
        `name`,
        `incoming`
    );
END¤


-- -------------------------------------- --
-- Create [UPDATE PROCEEDURES] procedures --
-- -------------------------------------- --
-- note that we only update entities which have a value.
-- If they are set to NULL they are not updated.
-- I have chosen this aproach because I do not want 
-- the database to contain invalid addresses.
--
CREATE PROCEDURE update_user(
    IN `id` INT,
    IN `first_name` VARCHAR(50),
    IN `last_name` VARCHAR(50),
    IN `username` VARCHAR(50),
    IN `password` VARCHAR(250),
    IN `confirm_password` VARCHAR(250),
    IN `email` VARCHAR(254),
    IN `phone_number` VARCHAR(25)
)
BEGIN
    IF `password` IS NOT NULL THEN
        IF `password` = `confirm_password` THEN
            -- Update password
            UPDATE br_user
            SET user_password = `password`
            WHERE user_id = `id`;
        ELSE
            -- Handle password mismatch
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Passwords do not match';
        END IF;
    END IF;

    -- Update first name
    IF `first_name` IS NOT NULL THEN
        UPDATE br_user
        SET user_first_name = `first_name`
        WHERE user_id = `id`;
    END IF;

    -- Update last name
    IF `last_name` IS NOT NULL THEN
        UPDATE br_user
        SET user_last_name = `last_name`
        WHERE user_id = `id`;
    END IF;

    -- Update username
    IF `username` IS NOT NULL THEN
        UPDATE br_user
        SET user_username = `username`
        WHERE user_id = `id`;
    END IF;

    -- Update email
    IF `email` IS NOT NULL THEN
        UPDATE br_user
        SET user_email = `email`
        WHERE user_id = `id`;
    END IF;

    -- Update phone number
    IF `phone_number` IS NOT NULL THEN
        UPDATE br_user
        SET user_phone_number = `phone_number`
        WHERE user_id = `id`;
    END IF;
END¤

CREATE PROCEDURE update_genre(
    IN `current_value` VARCHAR(100),
    IN `new_value` VARCHAR(100)
)
BEGIN
    IF `new_value` IS NOT NULL THEN
        UPDATE br_genre
        SET gen_value = `new_value`
        WHERE gen_value = `current_value`;
    END IF;
END¤

CREATE PROCEDURE update_author(
    IN `current_name` VARCHAR(100),
    IN `new_name` VARCHAR(100)
)
BEGIN
    IF `new_name` IS NOT NULL THEN
        UPDATE br_author
        SET auth_name = `new_name`
        WHERE auth_name = `current_name`;
    END IF;
END¤

CREATE PROCEDURE update_address(
    IN `id` INT,
    IN `postal_code` VARCHAR(15),
    IN `street_address` VARCHAR(100),
    IN `country` varchar(60),
    IN `is_billing_address` BOOLEAN
)
BEGIN
    IF `postal_code` IS NOT NULL THEN
        UPDATE br_address
        SET adr_postal_code = `postal_code`
        WHERE adr_id = `id`;
    END IF;
    
    IF `street_address` IS NOT NULL THEN
        UPDATE br_address
        SET adr_street_address = `street_address`
        WHERE adr_id = `id`;
    END IF;
    
    IF `country` IS NOT NULL THEN
        UPDATE br_address
        SET adr_country = `country`
        WHERE adr_id = `id`;
    END IF;

    IF `is_billing_address` IS NOT NULL THEN
        UPDATE br_address
        SET adr_is_billing_address = `is_billing_address`
        WHERE adr_id = `id`;
    END IF;
END¤

-- ------------------------------------- --
-- Create [DELETE PROCEDURES] procedures --
-- ------------------------------------- --

CREATE PROCEDURE delete_user(
    IN `id` INT
)
BEGIN
    DELETE FROM br_user WHERE user_id = `id`;
END¤

CREATE PROCEDURE delete_genre(
    IN `value` VARCHAR(100)
)
BEGIN
    DELETE FROM br_genre WHERE gen_value = `value`;
END¤

CREATE PROCEDURE delete_author(
    IN `name` VARCHAR(100)
)
BEGIN
    DELETE FROM br_author WHERE auth_name = `name`;
END¤

CREATE PROCEDURE delete_address(
    IN `id` INT
)
BEGIN
    DELETE FROM br_address WHERE adr_id = `id`;
END¤

-- ------------------------------------- --
-- Create [SELECT PROCEDURES] procedures --
-- ------------------------------------- --
CREATE PROCEDURE select_user(
    IN `id` INT,
)
BEGIN
    SELECT * FROM br_user WHERE user_id = `id`;
END¤

CREATE PROCEDURE select_genre(
    IN `id` INT,
)
BEGIN
    SELECT * FROM br_genre WHERE gen_value = `id`;
END¤

CREATE PROCEDURE select_author(
    IN `id` INT,
)
BEGIN
    SELECT * FROM br_author WHERE auth_name = `id`;
END¤

CREATE PROCEDURE select_address(
    IN `id` INT,
)
BEGIN
    SELECT * FROM br_address WHERE adr_id = `id`;
END¤

DELIMITER ;
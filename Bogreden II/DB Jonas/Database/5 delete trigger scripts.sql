DELIMITER ¤ 

-- ----------------------------------- --
-- create after delete trigger scripts --
-- ----------------------------------- --

CREATE TRIGGER tr_city_delete_after AFTER DELETE
ON br_city FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "city_after",
        CURRENT_TIMESTAMP(),
        "Row Deleted"
    );
END¤

CREATE TRIGGER tr_user_delete_after AFTER DELETE
ON br_user FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "user_after",
        CURRENT_TIMESTAMP(),
        "Row Deleted"
    );
END¤ 

CREATE TRIGGER tr_pricing_delete_after AFTER DELETE
ON br_pricing FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "pricing_after",
        CURRENT_TIMESTAMP(),
        "Row Deleted"
    );
END¤ 

CREATE TRIGGER tr_genre_delete_after AFTER DELETE
ON br_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "genre_after",
        CURRENT_TIMESTAMP(),
        "Row Deleted"
    );
END¤ 

CREATE TRIGGER tr_author_delete_after AFTER DELETE
ON br_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "author_after",
        CURRENT_TIMESTAMP(),
        "Row Deleted"
    );
    UPDATE br_book_author
    SET ba_author_name = (SELECT auth_name FROM br_author WHERE auth_name = "unknown")
    WHERE ba_author_name = `ba_author_name`;
END¤

CREATE TRIGGER tr_address_delete_after AFTER DELETE
ON br_address FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "address_after",
        CURRENT_TIMESTAMP(),
        "Row Deleted"
    );
END¤ 

CREATE TRIGGER tr_order_delete_after AFTER DELETE
ON br_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "order_after",
        CURRENT_TIMESTAMP(),
        "Row Deleted"
    );
END¤ 

CREATE TRIGGER tr_book_delete_after AFTER DELETE
ON br_book FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "book_after",
        CURRENT_TIMESTAMP(),
        "Row Deleted"
    );
END¤

CREATE TRIGGER tr_book_author_delete_after AFTER DELETE
ON br_book_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "book_author_after",
        CURRENT_TIMESTAMP(),
        "Row Deleted"
    );
END¤

CREATE TRIGGER tr_book_genre_delete_after AFTER DELETE
ON br_book_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "book_genre_after",
        CURRENT_TIMESTAMP(),
        "Row Deleted"
    );
END¤

CREATE TRIGGER tr_book_order_delete_after AFTER DELETE
ON br_book_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "book_order_after",
        CURRENT_TIMESTAMP(),
        "Row Deleted"
    );
END¤ 

CREATE TRIGGER tr_tax_delete_before AFTER DELETE
    ON br_tax FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        "tax_after",
        CURRENT_TIMESTAMP(),
        "Row Deleted"

    );
END¤

CREATE TRIGGER tr_taxes_delete_before AFTER DELETE
    ON br_taxes FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        "taxes_after",
        CURRENT_TIMESTAMP(),
        "Row Deleted"
    );
END¤

-- ------------------------------------ --
-- create before delete trigger scripts --
-- ------------------------------------ --

CREATE TRIGGER tr_city_before_delete BEFORE DELETE
ON br_city FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "city_after",
        CURRENT_TIMESTAMP(),
        "Deleting Row"
    );
END¤

CREATE TRIGGER tr_user_before_delete BEFORE DELETE
ON br_user FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "user_after",
        CURRENT_TIMESTAMP(),
        "Deleting Row"
    );
END¤

CREATE TRIGGER tr_pricing_before_delete BEFORE DELETE
ON br_pricing FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "pricing_after",
        CURRENT_TIMESTAMP(),
        "Deleting Row"
    );
END¤

CREATE TRIGGER tr_genre_before_delete BEFORE DELETE
ON br_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "genre_after",
        CURRENT_TIMESTAMP(),
        "Delete Row"
    );
END¤

CREATE TRIGGER tr_author_before_delete BEFORE DELETE
ON br_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "author_after",
        CURRENT_TIMESTAMP(),
        "Delete Row"
    );
END¤

CREATE TRIGGER tr_address_before_delete BEFORE DELETE
ON br_address FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "address_after",
        CURRENT_TIMESTAMP(),
        "Deleting Row"
    );
END¤

CREATE TRIGGER tr_order_before_delete BEFORE DELETE
ON br_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "order_after",
        CURRENT_TIMESTAMP(),
        "Deleting Row"
    );
END¤

CREATE TRIGGER tr_book_before_delete BEFORE DELETE
ON br_book FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "book_after",
        CURRENT_TIMESTAMP(),
        "Deleting Row"
    );
END¤

CREATE TRIGGER tr_book_author_before_delete BEFORE DELETE
ON br_book_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "book_author_after",
        CURRENT_TIMESTAMP(),
        "Deleting Row"
    );
END¤

CREATE TRIGGER tr_book_genre_before_delete BEFORE DELETE
ON br_book_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "book_genre_after",
        CURRENT_TIMESTAMP(),
        "Deleting Row"
    );
END¤

CREATE TRIGGER tr_book_order_before_delete BEFORE DELETE
ON br_book_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "book_order_after",
        CURRENT_TIMESTAMP(),
        "Deleting Row"
    );
END¤

CREATE TRIGGER tr_tax_insert_before BEFORE DELETE
    ON br_tax FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        "tax_after",
        CURRENT_TIMESTAMP(),
        "Deleting Row"

    );
END¤

CREATE TRIGGER tr_taxes_insert_before BEFORE DELETE
    ON br_taxes FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        "taxes_after",
        CURRENT_TIMESTAMP(),
        "Deleting Row"
    );
END¤


DELIMITER ;
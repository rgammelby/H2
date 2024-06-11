DELIMITER ¤ 
-- ----------------------------------- --
-- create after insert trigger scripts --
-- ----------------------------------- --
CREATE TRIGGER tr_city_insert_after AFTER INSERT
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
        CONCAT(
            "city_postal_code: ",
            NEW.city_postal_code,
            ", ",
            "city_name: ",
            NEW.city_name
        )
    );
END¤

CREATE TRIGGER tr_user_insert_after AFTER INSERT
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
        CONCAT(
            "user_id: ",
            NEW.user_id,
            ", ",
            "user_first_name: ",
            NEW.user_first_name,
            ", ",
            "user_last_name: ",
            NEW.user_last_name,
            ", ",
            "user_username: ",
            NEW.user_username,
            ", ",
            "user_password: ",
            NEW.user_password,
            ", ",
            "user_email: ",
            NEW.user_email,
            ", ",
            "user_phone_number: ",
            NEW.user_phone_number
        )
    );
END¤

CREATE TRIGGER tr_pricing_insert_after AFTER INSERT
    ON br_pricing FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        "pricing_after",
        CURRENT_TIMESTAMP(),
        CONCAT(
            "pri_id: ",
            NEW.pri_id,
            ", ",
            "pri_purchase_price: ",
            NEW.pri_purchase_price,
            ", ",
            "pri_sales_price: ",
            NEW.pri_sales_price,
            ", ",
            "pri_sale_percentage: ",
            NEW.pri_sale_percentage,
            ", ",
            "pri_price_reduction: ",
            NEW.pri_price_reduction,
            ", "
        )
    );
END¤

CREATE TRIGGER tr_genre_insert_after AFTER INSERT
    ON br_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        "genre_after",
        CURRENT_TIMESTAMP(),
        CONCAT("gen_value: ", NEW.gen_value)
    );
END¤

CREATE TRIGGER tr_author_insert_after AFTER INSERT
    ON br_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        "author_after",
        CURRENT_TIMESTAMP(),
        CONCAT("auth_name: ", NEW.auth_name)
    );
END¤

CREATE TRIGGER tr_address_insert_after AFTER INSERT
    ON br_address FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        "address_after",
        CURRENT_TIMESTAMP(),
        CONCAT(
            "adr_id: ",
            NEW.adr_id,
            ", ",
            "adr_postal_code: ",
            NEW.adr_postal_code,
            ", ",
            "adr_user_id: ",
            NEW.adr_user_id,
            ", ",
            "adr_street_address: ",
            NEW.adr_street_address,
            ", ",
            "adr_country: ",
            NEW.adr_country,
            ", ",
            "adr_is_billing_address: ",
            NEW.adr_is_billing_address,
            ", "
        )
    );
END¤

CREATE TRIGGER tr_order_insert_after AFTER INSERT
    ON br_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        "order_after",
        CURRENT_TIMESTAMP(),
        CONCAT(
            "odr_id: ",
            NEW.odr_id,
            ", ",
            "odr_user_id: ",
            NEW.odr_user_id,
            ", ",
            "odr_shipping_date: ",
            NEW.odr_shipping_date,
            ", ",
            "odr_sold_price: ",
            NEW.odr_sold_price,
            ", ",
            "odr_status: ",
            NEW.odr_status,
            ", "
        )
    );
    IF NEW.odr_status = 'Received' THEN 
        -- Add the final tax to the br_taxes.accumi_tax
        UPDATE br_taxes
        SET accumi_tax = accumi_tax + (
			NEW.odr_sold_price - (
				SELECT br_order.odr_id, br_pricing.pri_purchase_price
                FROM br_order
                JOIN br_book_order ON br_order.odr_id = br_book_order.bo_ord_id
                JOIN br_book ON br_book_order.bo_book_id = br_book.bk_id
                JOIN br_pricing ON br_book.bk_pricing_id = br_pricing.pri_id
                WHERE br_order.odr_id = NEW.odr_id
			)
		) * (SELECT tax_rate FROM br_tax),
            last_update = NOW();
    END IF;
END¤

CREATE TRIGGER tr_book_insert_after AFTER INSERT
    ON br_book FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        "book_after",
        CURRENT_TIMESTAMP(),
        CONCAT(
            "bk_id: ",
            NEW.bk_id,
            ", ",
            "bk_pricing_id: ",
            NEW.bk_pricing_id,
            ", ",
            "bk_titel: ",
            NEW.bk_titel,
            ", ",
            "bk_weight: ",
            NEW.bk_weight,
            ", ",
            "bk_description: ",
            NEW.bk_description,
            ", ",
            "bk_image: ",
            NEW.bk_image,
            ", "
        )
    );
END¤

CREATE TRIGGER tr_book_author_insert_after AFTER INSERT
    ON br_book_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        "book_author_after",
        CURRENT_TIMESTAMP(),
        CONCAT(
            "ba_id: ",
            NEW.ba_id,
            ", ",
            "ba_book_id: ",
            NEW.ba_book_id,
            ", ",
            "ba_author_name: ",
            NEW.ba_author_name,
            ", "
        )
    );
END¤

CREATE TRIGGER tr_book_genre_insert_after AFTER INSERT
    ON br_book_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        "book_genre_after",
        CURRENT_TIMESTAMP(),
        CONCAT(
            "bg_id: ",
            NEW.bg_id,
            ", ",
            "bg_book_id: ",
            NEW.bg_book_id,
            ", ",
            "bg_genre: ",
            NEW.bg_genre,
            ", "
        )
    );
END¤

CREATE TRIGGER tr_book_order_insert_after AFTER INSERT
    ON br_book_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        "book_order_after",
        CURRENT_TIMESTAMP(),
        CONCAT(
            "bo_id: ",
            NEW.bo_id,
            ", ",
            "bo_book_id: ",
            NEW.bo_book_id,
            ", ",
            "bo_ord_id: ",
            NEW.bo_ord_id,
            ", "
        )
    );
END¤

CREATE TRIGGER tr_tax_insert_after AFTER INSERT
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
        CONCAT(
            "tax_id: ",
            NEW.tax_id,
            ", ",
            "tax_rate: ",
            NEW.tax_rate,
            ", ",
            "tax_name: ",
            NEW.tax_name,
            ", ",
            "tax_incoming: ",
            NEW.tax_incoming
        )
    );
END¤

CREATE TRIGGER tr_taxes_insert_after AFTER INSERT
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
        CONCAT(
            "pri_id: ",
            NEW.pri_id,
            ", ",
            "fk_tax_id: ",
            NEW.fk_tax_id,
            ", ",
            "Accumi_tax: ",
            NEW.Accumi_tax,
            ", ",
            "last_update: ",
            NEW.last_update,
            ", ",
            "last_tax_paid: ",
            NEW.last_tax_paid
        )
    );
END¤

-- ------------------------------------ --
-- create before insert trigger scripts --
-- ------------------------------------ --
CREATE TRIGGER tr_city_before_insert BEFORE INSERT
    ON br_city FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "city_before",
        CURRENT_TIMESTAMP(),
        "Insert New Row"
    );
END¤

CREATE TRIGGER tr_user_before_insert BEFORE INSERT
    ON br_user FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "user_before",
        CURRENT_TIMESTAMP(),
        "Insert New Row"
    );
END¤

CREATE TRIGGER tr_pricing_before_insert BEFORE INSERT
    ON br_pricing FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "pricing_before",
        CURRENT_TIMESTAMP(),
        "Insert New Row"
    );
END¤

CREATE TRIGGER tr_genre_before_insert BEFORE INSERT
    ON br_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "genre_before",
        CURRENT_TIMESTAMP(),
        CONCAT("gen_value: ", NEW.gen_value)
    );
END¤

CREATE TRIGGER tr_author_before_insert BEFORE INSERT
    ON br_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "author_before",
        CURRENT_TIMESTAMP(),
        CONCAT("auth_name: ", NEW.auth_name)
    );
END¤

CREATE TRIGGER tr_address_before_insert BEFORE INSERT
    ON br_address FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "address_before",
        CURRENT_TIMESTAMP(),
        "Insert New Row"
    );
END¤

CREATE TRIGGER tr_order_before_insert BEFORE INSERT
    ON br_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "order_before",
        CURRENT_TIMESTAMP(),
        "Insert New Row"
    );
END¤

CREATE TRIGGER tr_book_before_insert BEFORE INSERT
    ON br_book FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "book_before",
        CURRENT_TIMESTAMP(),
        "Insert New Row"
    );
END¤

CREATE TRIGGER tr_book_author_before_insert BEFORE INSERT
    ON br_book_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "book_author_before",
        CURRENT_TIMESTAMP(),
        "Insert New Row"
    );
END¤

CREATE TRIGGER tr_book_genre_before_insert BEFORE INSERT
    ON br_book_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "book_genre_before",
        CURRENT_TIMESTAMP(),
        "Insert New Row"
    );
END¤

CREATE TRIGGER tr_book_order_before_insert BEFORE INSERT
    ON br_book_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        "book_order_before",
        CURRENT_TIMESTAMP(),
        "Insert New Row"
    );
END¤

CREATE TRIGGER tr_tax_before_insert BEFORE INSERT
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
        "tax_before",
        CURRENT_TIMESTAMP(),
        "Insert New Row"
    );
END¤

CREATE TRIGGER tr_taxes_before_insert BEFORE INSERT
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
        "taxes_before",
        CURRENT_TIMESTAMP(),
        "Insert New Row"
    );
END¤

DELIMITER ;
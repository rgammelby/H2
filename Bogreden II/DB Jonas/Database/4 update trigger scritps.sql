DELIMITER ¤

-- ----------------------------------- --
-- create after update trigger scripts --
-- ----------------------------------- --

CREATE TRIGGER tr_cityupdate__after AFTER UPDATE
ON br_city FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
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

CREATE TRIGGER tr_userupdate__after AFTER UPDATE
ON br_user FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
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

CREATE TRIGGER tr_pricingupdate__after AFTER UPDATE
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

CREATE TRIGGER tr_genreupdate__after AFTER UPDATE
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

CREATE TRIGGER tr_authorupdate__after AFTER UPDATE
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

CREATE TRIGGER tr_addressupdate__after AFTER UPDATE
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

CREATE TRIGGER tr_orderupdate__after AFTER UPDATE
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
END¤

CREATE TRIGGER tr_bookupdate__after AFTER UPDATE
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

CREATE TRIGGER tr_book_authorupdate__after AFTER UPDATE
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

CREATE TRIGGER tr_book_genreupdate__after AFTER UPDATE
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

CREATE TRIGGER tr_book_orderupdate__after AFTER UPDATE
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

CREATE TRIGGER tr_tax_update_after AFTER UPDATE
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

CREATE TRIGGER tr_taxes_update_after AFTER UPDATE
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
-- create before update trigger scripts --
-- ------------------------------------ --

CREATE TRIGGER tr_city_update_before BEFORE UPDATE
ON br_city FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        "city_after",
        CURRENT_TIMESTAMP(),
        CONCAT(
            "city_postal_code: ",
            OLD.city_postal_code,
            ", ",
            "city_name: ",
            OLD.city_name
        )
    );
END¤

CREATE TRIGGER tr_user_update_before BEFORE UPDATE
ON br_user FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        "user_after",
        CURRENT_TIMESTAMP(),
        CONCAT(
            "user_id: ",
            OLD.user_id,
            ", ",
            "user_first_name: ",
            OLD.user_first_name,
            ", ",
            "user_last_name: ",
            OLD.user_last_name,
            ", ",
            "user_username: ",
            OLD.user_username,
            ", ",
            "user_password: ",
            OLD.user_password,
            ", ",
            "user_email: ",
            OLD.user_email,
            ", ",
            "user_phone_number: ",
            OLD.user_phone_number
        )
    );
END¤

CREATE TRIGGER tr_pricing_update_before BEFORE UPDATE
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
            OLD.pri_id,
            ", ",
            "pri_purchase_price: ",
            OLD.pri_purchase_price,
            ", ",
            "pri_sales_price: ",
            OLD.pri_sales_price,
            ", ",
            "pri_sale_percentage: ",
            OLD.pri_sale_percentage,
            ", ",
            "pri_price_reduction: ",
            OLD.pri_price_reduction,
            ", "
        )
    );
END¤

CREATE TRIGGER tr_genre_update_before BEFORE UPDATE
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

CREATE TRIGGER tr_author_update_before BEFORE UPDATE
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

CREATE TRIGGER tr_address_update_before BEFORE UPDATE
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
            OLD.adr_id,
            ", ",
            "adr_postal_code: ",
            OLD.adr_postal_code,
            ", ",
            "adr_user_id: ",
            OLD.adr_user_id,
            ", ",
            "adr_street_address: ",
            OLD.adr_street_address,
            ", ",
            "adr_country: ",
            OLD.adr_country,
            ", ",
            "adr_is_billing_address: ",
            OLD.adr_is_billing_address,
            ", "
        )
    );
END¤

CREATE TRIGGER tr_order_update_before BEFORE UPDATE
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
            OLD.odr_id,
            ", ",
            "odr_user_id: ",
            OLD.odr_user_id,
            ", ",
            "odr_shipping_date: ",
            OLD.odr_shipping_date,
            ", ",
            "odr_sold_price: ",
            OLD.odr_sold_price,
            ", ",
            "odr_status: ",
            OLD.odr_status,
            ", "
        )
    );
END¤

CREATE TRIGGER tr_book_update_before BEFORE UPDATE
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
            OLD.bk_id,
            ", ",
            "bk_pricing_id: ",
            OLD.bk_pricing_id,
            ", ",
            "bk_titel: ",
            OLD.bk_titel,
            ", ",
            "bk_weight: ",
            OLD.bk_weight,
            ", ",
            "bk_description: ",
            OLD.bk_description,
            ", ",
            "bk_image: ",
            OLD.bk_image,
            ", "
        )
    );
END¤

CREATE TRIGGER tr_book_author_update_before BEFORE UPDATE
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
            OLD.ba_id,
            ", ",
            "ba_book_id: ",
            OLD.ba_book_id,
            ", ",
            "ba_author_name: ",
            OLD.ba_author_name,
            ", "
        )
    );
END¤

CREATE TRIGGER tr_book_genre_update_before BEFORE UPDATE
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
            OLD.bg_id,
            ", ",
            "bg_book_id: ",
            OLD.bg_book_id,
            ", ",
            "bg_genre: ",
            OLD.bg_genre,
            ", "
        )
    );
END¤

CREATE TRIGGER tr_book_order_update_before BEFORE UPDATE
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
            OLD.bo_id,
            ", ",
            "bo_book_id: ",
            OLD.bo_book_id,
            ", ",
            "bo_ord_id: ",
            OLD.bo_ord_id,
            ", "
        )
    );
END¤

CREATE TRIGGER tr_tax_update_before BEFORE UPDATE
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
            OLD.tax_id,
            ", ",
            "tax_rate: ",
            OLD.tax_rate,
            ", ",
            "tax_name: ",
            OLD.tax_name,
            ", ",
            "tax_incoming: ",
            OLD.tax_incoming
        )
    );
END¤

CREATE TRIGGER tr_taxes_update_before AFTER UPDATE
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
            OLD.pri_id,
            ", ",
            "fk_tax_id: ",
            OLD.fk_tax_id,
            ", ",
            "Accumi_tax: ",
            OLD.Accumi_tax,
            ", ",
            "last_update: ",
            OLD.last_update,
            ", ",
            "last_tax_paid: ",
            OLD.last_tax_paid
        )
    );
END¤


DELIMITER ;
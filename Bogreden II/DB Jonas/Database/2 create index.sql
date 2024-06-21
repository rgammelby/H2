-- -------- --
-- Indexing --
-- -------- --

CREATE INDEX idx_city ON br_city (city_postal_code, city_name);

CREATE INDEX idx_user ON br_user (
    user_id,
    user_first_name,
    user_last_name,
    user_username,
    user_password,
    user_email,
    user_phone_number
);

CREATE INDEX idx_pricing ON br_pricing (
    pri_id,
    pri_purchase_price,
    pri_sales_price,
    pri_sale_percentage,
    pri_price_reduction
);

CREATE INDEX idx_genre ON br_genre (gen_value);

CREATE INDEX idx_author ON br_author (auth_name);

CREATE INDEX idx_address ON br_address (
    adr_id,
    adr_postal_code,
    adr_user_id,
    adr_street_address,
    adr_country,
    adr_is_billing_address
);

CREATE INDEX idx_order ON br_order (
    odr_id,
    odr_user_id,
    odr_shipping_date,
    odr_sold_price,
    odr_status
);

CREATE INDEX idx_book ON br_book (
    bk_id,
    bk_pricing_id,
    bk_titel,
    bk_weight
);

CREATE INDEX idx_book_author ON br_book_author (
    ba_id,
    ba_book_id,
    ba_author_name
);

CREATE INDEX idx_book_genre ON br_book_genre (bg_id, bg_book_id, bg_genre);

CREATE INDEX idx_book_order ON br_book_order (bo_id, bo_book_id, bo_ord_id);